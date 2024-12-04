cd 'C:\Users\duzun\OneDrive\Masaüstü\SKULE\BME595 Medical Imaging\Lab 1'
load mr_lab

%PART 2 - IMAGE CONTRAST
%Generate an image containing both objects
I3 = I1+I2;
I3 = I3+randn(size(I3)).*5; %Add Gaussian noise of 5
imagesc(I3);

%Q1
y=imcrop(); %crop top left (yellow) box - I1
t=imcrop(); %crop bottom right (teal) box - I2
b=imcrop(); %crop blue area (noise)

%Calculate the means
y_mean = mean2(y); %I1
t_mean = mean2(t); %I2

%Calculate the standard deviation of the noise
b_std = std2(b);

%SNR - Signal to Noise Ratio of each square
y_snr = y_mean/b_std;
t_snr = t_mean/b_std;

%CNR - Contrast to Noise Ratio of each square
cnr = (y_mean - t_mean)/b_std;

%--------------------------------------------------------------------

%Q2
%Generate T2-weighted Images at 10ms and 50ms, for TE = 20ms
I4 = I1 * exp(-20/10); %T2 = 10ms 
I5 = I2 * exp(-20/50); %T2 = 50ms
imagesc(I4);
imagesc(I5);

%Image containing both
I6 = I4 + I5;
I6 = I6+randn(size(I3)).*5;
imagesc(I6);

y2=imcrop(); %crop top left (teal) box - I4
t2=imcrop(); %crop bottom right (yellow) box - I5
b2=imcrop(); %crop noise

%Calculate the means
y2_mean = mean2(y2); %I4
t2_mean = mean2(t2); %I5

%Calculate the standard deviation of the noise
b2_std = std2(b2);

%SNR
y2_snr = y2_mean/b2_std;
t2_snr = t2_mean/b2_std;

%CNR
cnr2 = (t2_mean - y2_mean)/b2_std;

%---------------------------------------------------------------------

%Q3 
PA = 100; %proton density of I1 & I4 (top left box)
PB = 50; %proton denstiy of I2 & I5 (bottom right box)

T2_A = 10; %T2 value of I1 & I4
T2_B = 50; %T2 value of I2 & I5

%To produce zero contrast - TE = 8.6643ms
I7 = I1 * exp(-8.6643/10);
I8 = I2 * exp(-8.6643/50);

I9 = I7 + I8;
I9 = I9+randn(size(I3)).*5;
imagesc(I9);




