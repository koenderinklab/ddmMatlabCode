function [] = fitmeanISF(Pathout,FilenameOut)
meanffit=dlmread([Pathout  '\Mean\'  FilenameOut '_ISF_mean.txt']);
meandt=dlmread([Pathout  '\Mean\'  FilenameOut '_dt_mean.txt']);
[M] = expfit_f(meanffit,meandt);
save([Pathout, FilenameOut, '_fitParam_A_tau_n_B.txt'],'M','-ASCII')
end