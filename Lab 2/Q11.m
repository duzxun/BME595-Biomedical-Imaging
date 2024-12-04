% Image Reconstruction Lab #2
cd 'C:\Users\duzun\OneDrive\Masaüstü\SKULE\BME595 Medical Imaging\Lab 2'
load mr_lab

% Q10
% Central part of k_space around DC
k_space(1:88,:)=0;
k_space(139:224,:)=0;
k_space(:,1:88)=0;
k_space(:,139:224)=0;

% Transform the k_space into an image
img=abs(ifft2(k_space));

% Display k_space
imagesc(abs(img))
colormap(gray(256))
brighten(0.6)
axis image; axis off