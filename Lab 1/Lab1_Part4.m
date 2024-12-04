cd 'C:\Users\duzun\OneDrive\Masaüstü\SKULE\BME595 Medical Imaging\Lab 1'
load T1andT2.mat

%PART 4 - QUANTITATIVE T1 AND T2 MEASUREMENT
%Q1
%Plot signal intensity acquired at each echo time (TE)
plot(TE, T2signal, '.');

%T2signal=ke^(-TE/T2)
%Plot original datapoints and fitted line
cftool;

%Estimate T2 and express in ms
T2 = 1/0.005136;

%Q2
%Invert first 2 points
T1signal(1) = -T1signal(1);
T1signal(2) = -T1signal(2);

T1_original = abs(T1signal);

%Plot original datapoint
plot(TI, T1_original, '.');

%Plot corrected datapoint
plot(TI, T1signal, '.');

cftool;


