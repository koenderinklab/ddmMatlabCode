function [] = meanISF(Pathout,FilenameOut,f)

k = 0;

for filei=1:length(f)
    k = k+1;
Fn = f{filei}
dt = dlmread([Pathout Fn '_dt.txt']);
q = dlmread([Pathout Fn '_q.txt']);
isf = dlmread([Pathout Fn '_ISF.txt']);
size(isf)
size(dt)
Mffit(:,:,k) = isf; Mdt(:,k) = dt;
end
meanffit = mean(Mffit,3);stffit = std(Mffit,1,3);
meandt = mean(Mdt,2);stdt = std(Mdt,1,2);

mkdir([Pathout  '\Mean\'])
save([Pathout  '\Mean\'  FilenameOut '_ISF_mean.txt'],'meanffit','-ASCII')
save([Pathout  '\Mean\'  FilenameOut '_ISF_std_mean.txt'],'stffit','-ASCII')
save([Pathout  '\Mean\'  FilenameOut '_dt_mean.txt'],'meandt','-ASCII')
save([Pathout  '\Mean\'  FilenameOut '_dt_std_mean.txt'],'stdt','-ASCII')
end