function [dt,q,RadAverage] = dicf_full_nd2_fast (data,NrEnsAveraging)

% % %%%% reader %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  omeMeta = reader.getMetadataStore();
%  num_images = omeMeta.getPixelsSizeT(0).getValue();
% % dpix = str2num(omeMeta.getPixelsPhysicalSizeX(0).value(ome.units.UNITS.MICROM));
%  
%  fps0 =str2num(omeMeta.getPlaneDeltaT(0,0).value(ome.units.UNITS.S));
%  fps1 =str2num(omeMeta.getPlaneDeltaT(0,num_images-1).value(ome.units.UNITS.S));
%  framerate = num_images/(fps1-fps0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% data %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
omeMeta = data{4};
minPix = omeMeta.getPixelsSizeX(0).getValue();
num_images = omeMeta.getPixelsSizeT(0).getValue();
dpix = str2num(omeMeta.getPixelsPhysicalSizeX(0).value(ome.units.UNITS.MICROM));
fps0 =str2num(omeMeta.getPlaneDeltaT(0,0).value(ome.units.UNITS.S))
fps1 =str2num(omeMeta.getPlaneDeltaT(0,num_images-1).value(ome.units.UNITS.S))
%framerate = round(num_images/(fps1-fps0))
%framerate = (num_images/(fps1-fps0))
framerate = round(num_images/(fps1-fps0)*100)./100
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i = linspace(1,minPix/2,minPix/2);
q = (2*pi*i)./(minPix*dpix);

Factordt = 1.1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Maxdt = num_images-NrEnsAveraging;

NrPixels  = minPix;
% Im0=zeros(NrPixels,NrPixels);
% Im2=zeros(NrPixels,NrPixels);
halfDim = floor(NrPixels/2) - 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[X Y] = meshgrid(-(halfDim+1):halfDim, -(halfDim+1):halfDim);
[theta rho] = cart2pol(X, Y);                                
rho = round(rho);

% dt anlegen %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt0=1/framerate;
k=1;
while dt0 < (Maxdt/framerate)
     dt(k)=dt0;
     dt0=dt0*Factordt;
     
     if (dt0-dt(k))<(1/framerate)
         dt0=dt(k)+1/framerate;
     end
     k=k+1;
end
dt=round(dt*framerate)/framerate;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Schleife über dt %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Nrdt=length(dt);
RadAverage = zeros(Nrdt, halfDim+1);
PixelList = cell(halfDim+1,1);
for r = 1:halfDim+1
       PixelList{r} = find(rho == r);
end;

for idt = 1:Nrdt
    disp(['    calculating FFT for dt = ',num2str(idt),' of ',num2str(Nrdt)])
    % Mittelwert von  NrEnsAveraging (103) Fourier power spectrum  %%%%%%%%%%%% 
    dStep = round(dt(idt)*framerate);
    FD = zeros(NrPixels,NrPixels,'single');
    imax = num_images - dStep;
    rr = randi(imax,NrEnsAveraging,1);
 for i0 = 1:NrEnsAveraging
     r = rr(i0);
     d = single(data{1,1}{r+dStep,1})-single(data{1,1}{r,1});
     FD = FD + (abs(fft2(d))).^2;
%      imagesc((fftshift(FD)));
%      drawnow
 end
FD = fftshift(FD);
FD = FD/NrEnsAveraging;

% azimutale Mittelung --> 1D power spektrum %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  for r = 1:halfDim+1
    RadAverage(idt,r) = nanmean( FD( PixelList{r} ) );
  end
% 1D power spektrum wird gespeichert
%save(filenameOut,'RadAverage','-ASCII')
end
clearvars FD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end