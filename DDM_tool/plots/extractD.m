function [D_av,D,q] = extractD(Pathin,Pathout,FilenameOut)
M = dlmread([Pathout, FilenameOut, '_fitParam_A_tau_n_B.txt']);
f=dir([Pathin '\*.nd2']);
f={f.name};
Fn = f{1}; 
q = dlmread([Pathout Fn '_q.txt']); 
q = q(:);
tau = M(:,2); 
n = 1./M(:,3);
tau_av =(tau.*n).*gamma(n);
D_av = 1./(tau_av.*(q.^2)); 
D = 1./(tau.*(q.^2));
%Dm = mean(D);
%st = std(D);
end