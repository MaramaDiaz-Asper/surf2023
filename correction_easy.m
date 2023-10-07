bwImage = imread('copy_image.tif');
if size(bwImage, 3) == 3
    bwImage = rgb2gray(bwImage);
end
threshold = 0.5; 
curveMask = bwImage > threshold;

original_depth = size(curveMask, 1);
global_RI = 1.34; 
specific_RI = 1.37; 
rescaled_depth = round(original_depth * (global_RI / specific_RI));
scaledCurve = imresize(curveMask, [rescaled_depth, size(curveMask, 2)]);
correctedImage = bwImage;
correctedImage(1:rescaled_depth, :) = correctedImage(1:rescaled_depth, :) .* (1 - scaledCurve) + scaledCurve;
figure;
imshow(correctedImage, []);
title('Image with Replaced Curve');
imwrite(uint8(correctedImage), 'corrected_image.tif');
