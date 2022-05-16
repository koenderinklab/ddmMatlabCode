
function [] = plotFitmeanISF(Pathout,FilenameOut,qi,col)
M = dlmread([Pathout, FilenameOut, '_fitParam_A_tau_n_B.txt']);
xdata = 0.001:0.001:10;
semilogx(xdata, (M(qi,1).*(exp(- (xdata./M(qi,2)).^M(qi,3) ))+M(qi,4)),'-.','Color',col);
hold on
xdata = 10:10:1000000;
semilogx(xdata, (M(qi,1).*(exp(- (xdata./M(qi,2)).^M(qi,3) ))+M(qi,4)),'-.','Color',col);
% title(['q_i = ' num2str(i)]);
% xlabel('time/s');
% ylabel('f');
end
