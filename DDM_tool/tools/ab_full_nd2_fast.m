function [RadAverage] = ab_full_nd2_fast (data,NrEnsAveraging)

% %%%% reader %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% omeMeta = reader.getMetadataStore();
% num_images = omeMeta.getPixelsSizeT(0).getValue();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
omeMeta = data{4};
minPix = omeMeta.getPixelsSizeX(0).getValue();
num_images = omeMeta.getPixelsSizeT(0).getValue();
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NrPixels  = minPix;
Im0=zeros(NrPixels,NrPixels);
Im2=zeros(NrPixels,NrPixels);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
halfDim = floor(minPix/2) - 1;
[X Y] = meshgrid(-(halfDim+1):halfDim, -(halfDim+1):halfDim);
[theta rho] = cart2pol(X, Y);                                
rho = round(rho);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RadAverage = zeros(11,halfDim+1);
PixelList = cell(halfDim+1,1);
for r = 1:halfDim+1
       PixelList{r} = find(rho == r);
end;


for idt = 0:10
disp(['    calculating AB FFT for dt = ',num2str(idt),' of ',num2str(10)])
dStep = idt;
FD = zeros(NrPixels,NrPixels,'single');
imax = num_images - dStep;
rr = randi(imax,NrEnsAveraging,1);
    
 for i0 = 1:NrEnsAveraging
    r = rr(i0);
    Im0 = single(data{1,1}{r+dStep,1});
    Im2 = single(data{1,1}{r,1});
    
    FIm0 = fft2(Im0);
    FIm2 = conj(fft2(Im2));
    %PS = fftshift(FIm0.*FIm2)./((mean(mean(abs(FIm0))))*(mean(mean(abs(FIm2))))* 262144) - 1; %%%Power Spectrum  
    FD = FD + real(FIm0.*FIm2);
 end
FD = fftshift(FD);
FD = FD/NrEnsAveraging;

BB = 2*FD;

% azimutale Mittelung %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for r = 1:halfDim+1
    RadAverage(idt+1,r) = mean( BB( PixelList{r} ) );
  end
end

B = RadAverage(1,:)-RadAverage(2,:);
A  = RadAverage(2,:);
%clearvars -except A B RadAverage
% save(filenameOutB,'B','-ASCII')
% save(filenameOutA,'A','-ASCII')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end