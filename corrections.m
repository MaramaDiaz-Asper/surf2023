bwImage = imread('copy_image.tif'); 
figure;
imshow(bwImage);
% Selection similar to segmentation.m
title('Select cornea');
rect = getrect;
xmin = round(rect(1));
ymin = round(rect(2));
width = round(rect(3));
height = round(rect(4));
selectedSegment = bwImage(ymin:ymin+height-1, xmin:xmin+width-1);

% Define dispersion coefficients for correction based on OCT parameter
dispersionCoefficients = [0, 0, 0]; % I'm not sure what these are
correctedSegment = DispersionCorrection(selectedSegment, dispersionCoefficients);
bwImage(ymin:ymin+height-1, xmin:xmin+width-1) = correctedSegment;
figure;
imshow(bwImage);
title('Original Image with Corrected Cornea Section');
imwrite(bwImage, 'corrected_image.tif');
