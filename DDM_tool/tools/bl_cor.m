function [data_c] = bl_cor(data)

data_c = data;
omeMeta = data{4};
num_images = omeMeta.getPixelsSizeT(0).getValue();
MInt = zeros(num_images,1);

for i = 1:num_images  
bild = double(data{1,1}{i,1});
MInt(i) = mean(mean(bild,2));
data_c{1,1}{i,1} = data{1,1}{i,1}*(MInt(1)/MInt(i));

MInt(1)/MInt(i);
end

end