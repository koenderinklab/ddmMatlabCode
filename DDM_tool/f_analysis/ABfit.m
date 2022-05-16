function [ffit] = ABfit (D,M)

s = length(D(1,:));
Bfit = zeros(1,s);
Afit = zeros(1,s);

for i = 1:s%512
    k = round(4-0.1*i+3);%4
    if k<3%%%3
        k = 3;%%%3
    end
x = 2:k; y = M(2:k,i);
p = polyfit(x,y',1); Afit(i) = p(2);
end 

Bfit = M(1,:) - Afit;

% loglog(Bfit);
% hold on
% loglog(Afit)
ffit = 1 -( D - repmat(Bfit, size(D,1),1) ) ./repmat(Afit, size(D,1),1);
end
