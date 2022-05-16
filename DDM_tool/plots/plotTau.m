function [] = plotTau(Pathout,FilenameOut,m,f,q,col)

Mfit = dlmread([Pathout, FilenameOut, '_fitParam_A_tau_n_B.txt']);

f={f.name};  
Fn = f{1}; 
qq = dlmread([Pathout Fn '_q.txt']); 
G = gray(5);


loglog(qq(q),Mfit(q,2),'*','Color',col);
hold on
for mi = m 
M = dlmread([Pathout, FilenameOut, '_Kumulanten_m' num2str(mi) '.txt']);   
loglog(qq(q),1./M(q,3),'.-','Color',G(mi,:));
end
xlabel('q');
ylabel('\tau [s]');

xlim([2e-1 2e1]);
ylim([1e-3 1e5]);
% title(['q_i = ' num2str(i)]);
% xlabel('time/s');
% ylabel('f');
end

