
function [] = plotmeanISF(Pathout,FilenameOut,qii,col,sym)
meanffit=dlmread([Pathout  '\Mean\'  FilenameOut '_ISF_mean.txt']);
stffit=dlmread([Pathout  '\Mean\'  FilenameOut '_ISF_std_mean.txt']);
meandt=dlmread([Pathout  '\Mean\'  FilenameOut '_dt_mean.txt']);
stdt=dlmread([Pathout  '\Mean\'  FilenameOut '_dt_std_mean.txt']);

for qi = qii
%shadedErrorBar(meandt,meanffit(:,qi),stffit(:,qi),{'-','Color',col},0.4);
semilogx(meandt,meanffit(:,qi),sym,'Color',col,'MarkerFaceColor','w');
hold on
end
%text(5e0,1, ['qi = ' num2str(qii)]);
set(gca,'xscale','log')
set(gca,'Xtick',[1e-2 1e-1 1e0 1e1 1e2 1e3]);
ylim([-0.1 1.1]);
xlim([0.001 1000]);
xlabel('\Deltat /s');
ylabel('f(q,\Deltat)');
end
