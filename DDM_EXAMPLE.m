%function [] = DDM_EXAMPLE ()

clear all; clc; clf; 
set(0,'DefaultTextFontSize',16); set(0,'DefaultAxesFontSize',18);
set(0,'DefaultLineLineWidth',1);

Path = 'vim_mono';
Pathin = ['C:\DDM\' Path '\']; 
Pathout = ['C:\DDM\' Path '\DDM_Analysis\']; mkdir([Pathout]); 
f=dir([Pathin '\*.nd2']); f={f.name};

     for filei= 1:length(f) 
         Fn = f{filei}  
        N = 600;
         data = bfopen([Pathin Fn]);  
        DDM_Step1(data,N,Pathout,Fn)
     end
    
 %%  

meanISF(Pathout,Path,f)
%%
fitmeanISF(Pathout,Path)
%%
C = jet(7);
q = [3 20 50 80];
plotISF(Pathout,f,q,C(1,:),'-')
plotmeanISF(Pathout,Path,q,C(1,:),':')
xlim([1e-3 1e4]);
PathOutPlot = [Pathin '\ISF.png']; 
print(PathOutPlot,'-dpng')
hold off
%
%%
clf
for q =[3 20 50 80];
plotmeanISF(Pathout,Path,q,C(1,:),'o')
hold on
plotFitmeanISF(Pathout,Path,q,'k')
xlim([1e-3 1e4]);
set(gca,'Xtick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4]);
PathOutPlot = [Pathin '\ISF_Fit.png']; 
print(PathOutPlot,'-dpng')
hold on
end
%%
clf
for q = 3:5:80;
plotmeanISF_q2(Pathout,Path,f,q,C(1,:))
xlim([1e-3 8e4]);
set(gca,'Xtick',[1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4]);
PathOutPlot = [Pathin '\ISF_q2_qi3qi80.png']; 
print(PathOutPlot,'-dpng')
hold on
end
%%
clf
q = 1:250;
plotFitParam(Pathout,Path,f,q,C(1,:),Pathin)
%%
clf
[D_av,D,q] = extractD(Pathin,Pathout,Path);
loglog(q(1:250),D_av(1:250),'s','Color',C(1,:))
hold on
ylim([1e-3 10]);
xlim([0.1 30]);
xlabel('q [\mum^{-1}]');
ylabel('D [\mum^{2}/s]');
grid on
M(:,1) = q; M(:,2) = D_av; M(:,3) = D;
save([Pathout  '\q_Dav_D.txt'],'M','-ASCII')
PathOutPlot = [Pathin '\D.png']; 
print(PathOutPlot,'-dpng')
%%
clf
for qi = 7:9
[msd,dt] = MSD_q_aus_ISF (Pathin,Pathout,Path,qi);
size(msd)
size(dt)
loglog(dt,msd);
%fileID = fopen('C:\Users\fburla\Desktop\msd.txt','w');
%filew = [dt; msd];
%fprintf(fileID,'%6.2f %12.8f\r\n',filew);
%fclose(fileID);
hold on
end

%end 