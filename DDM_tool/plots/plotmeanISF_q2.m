function [] = plotmeanISF_q2(Pathout,FilenameOut,f,qi,col)
meanffit=dlmread([Pathout  '\Mean\'  FilenameOut '_ISF_mean.txt']);
meandt=dlmread([Pathout  '\Mean\'  FilenameOut '_dt_mean.txt']);

Fn = f{1}; 
q = dlmread([Pathout Fn '_q.txt']);
q(qi)
qq = q(qi).^2;

semilogx(meandt.*qq,meanffit(:,qi),'-','Color',col);
set(gca,'xscale','log')
hold on
ylim([-0.1 1.1]);
xlim([0.001 100000]);
xlabel('tq^2 / s\mum^{-2}');
ylabel('f(q,\Deltat)');
end