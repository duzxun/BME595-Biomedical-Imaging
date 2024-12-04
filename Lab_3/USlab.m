% Matlab code with Ultrasound lab BME595 course
% Original author: Nicholas Ellens, Sunnybrook Health Sciences Centre
% Modified: Hai-Ling Margaret Cheng, University of Toronto, Nov. 13, 2019

% This code was completed by: Deniz Uzun and Nicole Haderer

% Useful matlab commands
% 'help x' for help on a specific command x
% 'imagesc' - forms 2D images of a matrix
% 'plot' to plot a vector ; 'hold on' to superimpose two successive traces on the same graph
% e.g. plot(x,y,'red') will plot x vs y with a red line
% 'title' for title
% 'xlabel', 'ylabel' - to label axes
% 'figure' to bring up a new figure

%% Loading the data from the mat file
% the data is from an ex-vivo mouse kidney embedded in agar.
load USlabdata.mat
% contains: RawRF - Raw RF data
%           SamplingFrequency - given below
%           NumberOfDataPointsInFastTime - explains size of data set
%           NumberOfLines - explains size of data set

% In addition, these parameters are given:
SampleFreq=500e6;   % known sampling freq (Hz)
LateralSize = 20;   % known lateral image size (mm)
c = 1540;           % assumed speed of sound (m/s)
Transducer_Fc = 30e6; % known centre frequency of transducer (Hz)

%% Question 21. Calculate the time recorded in each line and calculate the depth reached in each line
time_recorded = NumberOfDataPointsInFastTime / SampleFreq * 10^6; %in microseconds
depth_reached = time_recorded * c / 2 * 10^-3; %in mm

%% Question 22. Plot a single A-line (as a function of time): use line 200
% produce an appropriate x axis (time)
% also plot a zoom-in to the signal from 2 to 4 microseconds
% give your axes appropriate labels

time_vector = linspace(0,time_recorded, NumberOfDataPointsInFastTime);
plot(time_vector, RawRF(:,200))
title('Single A-line (Line 200) as a Function of Time')
xlabel('Time (microseconds)')
ylabel('Signal Intensity')

%Zoom in
xlim([2 4])

%% Question 23. Plot a raw B-mode image (in grayscale)
% use the 'imagesc' function; use axes in mm
% use labels and title
% indicate the position of the A-line plotted in item 22

depth_axis = linspace(0, depth_reached, NumberOfDataPointsInFastTime);
lateral_axis = linspace(0, LateralSize, NumberOfLines);

figure;
imagesc(lateral_axis, depth_axis, abs(RawRF));
colormap('gray'); % Set the colormap to grayscale
title('Raw B-Mode Image');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');

hold on;
line([lateral_axis(200) lateral_axis(200)], [min(depth_axis) max(depth_axis)], 'Color', 'r');
hold off;


%% Question 24. Perform envelope detection
% envelope detection [one of the below two approaches suggested - a) use hilbert transform or b) use demodulation] 
% a) Hilbert transform (easier? refer to class notes)
%  use 'hilbert' function
% b) Demodulation approach:
% demodulate into in-phase and quadrature components and
% then calculate the envelope as sqrt(I^2+Q^2).
% Use the Matlab function 'demod' with the option 'qam' (need Signal
% Processing Toolbox)
% then plot the same (envelope-detected) A-line as before into the figures of step 2
% and plot a new B-mode image
%
% Describe qualitatively what changes in the image when you perform this
% processing step

figure;
imagesc(lateral_axis, depth_axis, abs(hilbert(RawRF)));
colormap('gray'); % Set the colormap to grayscale
title('B-Mode Image with Hilbert Transform');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');


%% Question 25. Perform 'log compression'
% take logarithm of data so that a large range
% of signal intensities can be visualized in one plot, and plot the result

figure;
imagesc(lateral_axis, depth_axis, log10(abs(RawRF)));
colormap('gray'); % Set the colormap to grayscale
title('B-Mode Image with Log Compression');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');

figure;
imagesc(lateral_axis, depth_axis, log10(abs(hilbert(RawRF))));
colormap('gray'); % Set the colormap to grayscale
title('B-Mode Image with Hilbert Transform and Log Compression');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');

% Describe qualitatively what changes in the image when you perform this
% processing step
% Identify the following features in the resulting image: kidney,
% near-field diffraction artifact, multiple reflection artifact
%
% You will notice that log compression brings out low-intensity details as well as noise.
% Apply a suitable threshold to remove noise from the image, and repeat
% applying log compression.  Plot the result and compare the image to that
% in the first part of Question 25.

log_compressed_image = 20*log10(abs(RawRF));
threshold = -40; % in dB
log_compressed_image(log_compressed_image < threshold) = threshold;

% Plot the thresholded and log compressed image
figure;
imagesc(lateral_axis, depth_axis, log_compressed_image);
colormap('gray');
title('Thresholded and Log Compressed B-Mode Image');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');


log_compressed_image = 20*log10(abs(hilbert(RawRF)));
threshold = -40; % in dB
log_compressed_image(log_compressed_image < threshold) = threshold;

% Plot the thresholded and log compressed image
figure;
imagesc(lateral_axis, depth_axis, log_compressed_image);
colormap('gray');
title('Thresholded and Log Compressed B-Mode Image with Hilbert Transform');
xlabel('Lateral Position (mm)');
ylabel('Depth (mm)');

% Nicole's code
image_rejection = RawRF;
threshold = 2.0;

for i = linspace(1, NumberOfDataPointsInFastTime, NumberOfDataPointsInFastTime)
	for j = linspace(1, NumberOfLines, NumberOfLines)
		if image_rejection(i, j) <= threshold & image_rejection(i, j) >= threshold
		   Image_rejection(i, j) = 0;
		end
	end 
end

figure ()
figure8 = imagesc(lateral_axis, depth_axis, log10(abs(hilbert(image_rejection))));
colormap(gray(256));
title("Nicole - Log Coressed with Noise Rejection B-Mode Image")
xlabel("Lateral Distance (mm)")
ylabel("Depth (mm)")

