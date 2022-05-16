function [msd,dt] = MSD_q_aus_ISF (Pathin,Pathout, FilenameOut,qi)
%for qi = 1:80
ISF = dlmread([Pathout  '\Mean\'  FilenameOut '_ISF_mean.txt']);
dt = dlmread([Pathout  '\Mean\'  FilenameOut '_dt_mean.txt']);
f=dir([Pathin '\*.nd2']);
f={f.name};
Fn = f{1}; 
q = dlmread([Pathout Fn '_q.txt']); 
idx = find(ISF(:,qi)>0.25,1,'last');
dt = dt(1:idx);

Dqt = ISF(1:idx,qi);
k = 1./(q(qi).^2);
m = -6*log(Dqt);
msd = m.*k;
% loglog(dtmean,msd,'.-');
% MSD(:,qi) = msd;
% hold on
% %end
% xlabel('dt  [s]');
% ylabel('msd  [\mum^2]');
% hold on
% save([Pathout, Filename, '_msd_qi' num2str(qi) '.txt'],'MSD','-ASCII')
end