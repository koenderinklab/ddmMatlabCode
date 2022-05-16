function [M] = expfit_f(ICF,dt) %[M] = expfit_f(Pathout, Filename)

%[ICF, stf, dt] = read_files_2 (Pathout, Filename);
qiend = length(ICF(1,:));
Be = 0;

 for qi = 1:qiend
     as = 0.5./((qi*0.1)^2);
     xData0 = logspace(-3,5,100); 
     indx1 = find(xData0 < dt(1),1,'last');
     indx2 = find(xData0 > dt(end),1,'first');
     xdata = xData0(indx1+1:indx2-1);
     ydata = interp1(dt,(ICF(:,qi)),xdata);


indices = isnan(ydata)| isinf(ydata);
ydata(indices) = 0;
% 
% sA = 1.00;
% lA = 0.3;
% uA = 1.0001;
% 
% %tau
% stau = 10;
% ltau = 1e-3;
% utau = 1e4;
% %n
% sn = 0.99;
% ln = 0.1;
% un = 1;
% %B
% sB = 0;
% lB = -0.0001;
% uB = 0.7;

%     
% fopts=fitoptions('Method','NonlinearLeastSquares',...
%                 'Startpoint',[stau,sn,sB,sA],...
%                 'Algorithm', 'Trust-Region',...
%                 'Lower',[ltau,ln,lB,lA],...
%                 'Upper',[utau,un,uB,uA]);
%             
% EXPR = @(tau,n,B,A,x) ( A * (exp(-(x/tau).^(n))) + B);



opts=fitoptions('Method','NonlinearLeastSquares',...
                 'Algorithm', 'Trust-Region');
ft = fittype( 'A * (exp(-(t/a).^(b))) + B', 'independent', 't');     

opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [1 Be as 0];
opts.Upper = [1.0 1 Inf 1];
opts.Lower = [0.95-Be -0.001 0 0];


[f, gof] = fit( xdata', ydata', ft, opts );
%f=fit(xdata,ydata,ftype,fopts);
%plot(f,xdata, ydata);
c = coeffvalues(f);
as = c(3);
Be = c(2);

semilogx(xdata, ydata,'o')
hold on

xdata = logspace(-4,5,100);
plot(xdata, (c(1)*(exp(- (xdata/c(3)).^c(4) ))+c(2)),'r');
 title(['q_i = ' num2str(qi)]);
 xlabel('time/s');
 ylabel('f');
 drawnow
 hold off

tau_out(qi) = c(3);
n_out(qi) = c(4);
A_out(qi) = c(1);
B_out(qi) = c(2);
 end
 
M(:,1) = A_out;
M(:,2) = tau_out;
M(:,3) = n_out;
M(:,4) = B_out;

%save([Pathout, Filename, '_fitParam_A_tau_n_B.txt'],'M','-ASCII')
end