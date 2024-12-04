% Lab 2 - Part 2
cd 'C:\Users\duzun\OneDrive\Masaüstü\SKULE\BME595 Medical Imaging\Lab 2'

Turkey=dicomread("TurkeyLeg_slice0300.dcm");
[R,Theta,TurkeyAtten]=simulate_parallelbeam(Turkey,10,-10,0.1);

% Display
imagesc(Turkey);
colormap(gray(256))
axis image; axis off

% Radon Transform
plot(radon(Turkey, 0))
area = trapz(radon(Turkey, 0));

% Sinogram R
imagesc(R);

% Inverse Radon Transform (Reconstruction)
% Backprojection Summation Image
%ReconTurkey=iradon(R,Theta,'linear','none',1,760);
%imshow(ReconTurkey,[])

% Filtered Backprojection
ReconTurkey=iradon(R(:,1:1:360),Theta(1:1:360),'linear','Ram-Lak',1,760);
imshow(ReconTurkey,[])




