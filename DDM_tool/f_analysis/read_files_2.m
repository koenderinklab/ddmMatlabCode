function [ffitmean,stffit,dtmean] = read_files_2 (Pathout, Filename)

f_nd2=dir([Pathout Filename '_ffit_mean.txt']);f_nd2={f_nd2.name}; 
ffitmean = dlmread([Pathout  f_nd2{1}]);

f_nd2=dir([Pathout Filename '_ffit_std_mean.txt']);f_nd2={f_nd2.name}; 
stffit = dlmread([Pathout  f_nd2{1}]);

f_nd2=dir([Pathout Filename '_dt_mean.txt']);f_nd2={f_nd2.name}; 
dtmean = dlmread([Pathout  f_nd2{1}]);

%ffitmean = dlmread([Pathout Filename '_ffit_mean_' num2str(fps) 'fps.txt']);
%stffit = dlmread([Pathout Filename '_ffit_std_mean_' num2str(fps) 'fps.txt']);
%dtmean = dlmread([Pathout Filename '_dt_mean_' num2str(fps) 'fps.txt']);

end