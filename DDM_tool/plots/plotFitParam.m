function [] = plotFitParam(Pathout,FilenameOut,f,q,col,PathOutPlot)

M = dlmread([Pathout, FilenameOut, '_fitParam_A_tau_n_B.txt']);

Fn = f{1}; 
qq = dlmread([Pathout Fn '_q.txt']); 

clf
semilogx(qq(q),M(q,1),'-','Color',col);
hold on
loglog(qq(q),M(q,4),':','Color',col);
xlabel('q [1/um]');
ylabel('A, B');
xlim([8e-2 5e1]);
ylim([-1 2]);
print([PathOutPlot '\FIT_AB.png'],'-dpng')

clf
loglog(qq(q),M(q,2),'d','Color',col);
hold on
xlabel('q [1/um]');
ylabel('\tau [s]');
xlim([1e-1 1e2]);
ylim([1e-6 1e5]);
set(gca,'XTick',[1e-1 1e0 1e1 1e2]);
set(gca,'YTick',[1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5]);
grid on
print([PathOutPlot '\FIT_tau.png'],'-dpng')

clf
semilogx(qq(q),M(q,3),'s:','Color',col);
hold on
xlabel('q [1/um]');
ylabel('n');
xlim([2e-1 1.3e1]);
ylim([0 1.1]);
grid on
set(gca,'XTick',[ 0.1 1 10 100]);
print([PathOutPlot '\FIT_n.png'],'-dpng')
end