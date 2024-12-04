h=figure;

try
    
    imagesc(abs(img))
    colormap(gray(256))
    brighten(0.6)
    title('Select ROI with Left Clicks.  After last vertex, right click.  Right click again, and choose "create mask"')
    axis image; axis off
    
catch
    
    Error('Error displaying figure.  Have you named your image variable "img"?');
    
end

mask=roipoly;  % generating mask in image

% calculating mean and standard deviation in ROI
mn=round(mean(nonzeros(abs(img).*mask)));
sd=round(std(nonzeros(abs(img).*mask)));

s=sprintf('Mean in Roi is %d, Standard Deviation is %d',mn,sd);
disp(s);

close(h);