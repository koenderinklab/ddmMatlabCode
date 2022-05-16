function [] = plotISF(Pathout,f,qi,col,sym) 
for filei=1:length(f)%
Fn = f{filei} 

dt = dlmread([Pathout Fn '_dt.txt']);
q = dlmread([Pathout Fn '_q.txt']);
isf = dlmread([Pathout Fn '_ISF.txt']);

semilogx(dt,isf(:,qi),sym,'Color',col);
hold on
%text(1e-2*filei, 0.3, [num2str(qi)]);
ylim([-0.2 1.1]);
xlim([0.001 1000]);
%xlim([min(dt) max(dt)]);
drawnow
end
end