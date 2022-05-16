function [] = DDM_Step1(data,N,Pathout,Fn)

[data_c] = bl_cor(data); 
[dt,q,D] = dicf_full_nd2_fast (data_c,N);
[M] = ab_full_nd2_fast (data_c,N);

%A = M(2,:); B = M(1,:) - M(2,:);
%ISFf = 1 -( D - repmat(B, size(D,1),1) ) ./repmat(A, size(D,1),1);
[ISFffit] = ABfit(D,M);

save([Pathout Fn '_q.txt'],'q','-ASCII')
save([Pathout Fn '_dt.txt'],'dt','-ASCII')
save([Pathout Fn '_D.txt'],'D','-ASCII')
save([Pathout Fn '_M.txt'],'M','-ASCII')
%save([Pathout Fn '_ISFf.txt'],'ISFf','-ASCII')
save([Pathout Fn '_ISF.txt'],'ISFffit','-ASCII')

clearvars data_c
clearvars data
end

