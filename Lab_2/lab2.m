% Image Reconstruction Lab #2
cd 'C:\Users\duzun\OneDrive\Masaüstü\SKULE\BME595 Medical Imaging\Lab 2'
load mr_lab

% Q1 
% Display k_space
imagesc(abs(k_space))
colormap(gray(256))
brighten(0.6)
axis image; axis off

% Q3 
% Transform the k_space into an image
img=ifft2(k_space);
img=abs(img);

% Display
imagesc(img)
colormap(gray(256))
brighten(0.6)
axis image; axis off

% Q5 
% Modify the resolution to 50%
k_space_new = k_space;
k_space_new = k_space_new(56:167, 56:167);

% Transform the k_space into an image
img=abs(ifft2(k_space_new));

% Display
imagesc(img)
colormap(gray(256))
brighten(0.6)
axis image; axis off

% Q7 
% Modify the k_space to 1/2 FOV
k_space_new2 = k_space;
k_space_new2 = k_space_new2(1:2:end,:);


% Transform the k_space into an image
img=abs(ifft2(k_space_new2));

% Display
imagesc(img)
colormap(gray(256))
brighten(0.6)
axis image; axis off

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

% Q11
% Zeroing the central part of k_space around DC
k_space(88:139,88:139)=0;

% Transform the k_space into an image
img=abs(ifft2(k_space));

% Display k_space
imagesc(abs(img))
colormap(gray(256))
brighten(0.6)
axis image; axis off

