%% Histogram of Brightness for reference
%This produces a histogram showing the brightness of the pixels across the
%imahe
image = imread("5a_wholeeye_ant-pos-AVG.tif");
[rows, columns] = size(image);
origin= [rows/2,columns/2];
% Calculate the distance from the center of the image for each pixel
%Euclidian
distanceMap = zeros(rows, columns);
for i = 1:rows
    for j = 1:columns
        distanceMap(i, j) = sqrt((i - origin(1))^2 + (j - origin(2))^2);
    end
end
distanceV = distanceMap(:);
brightnessVector = double(image(:));
image(:);
[sortDistance, sortedIndices] = sort(distanceV);
sortBrightness = brightnessVector(sortedIndices);

% Plot brightness per distance
figure;
plot(sortDistance, sortBrightness);
ylim([0,9e4]);
title('Brightness per Distance from Origin');
xlabel('Distance from Origin');
ylabel('Brightness');
mean(figure) = threshold;

%% Image "cleaning"- mainly for the lens
%Grayscale check
if size(image, 3) > 1
    error('The image is not grayscale.');
end

% Threshold- high pass filter
threshold = 20000;
highlightedImage = image;

% Identify pixels under the threshold and turn them to black
darkPixels = image < threshold;
highlightedImage(darkPixels) = 0; 

imshow(highlightedImage);
imwrite(highlightedImage, 'cleaned_image.tif');
%% Gradient detection
% This isn't particularly useful past detecting changes in gradient to see
% if that's a more optimal method than edge detection
[Gmag,Gdir] = imgradient(highlightedImage);
%can come back to this to find a method to do this that isn't arbitrary
Gthreshold=50;
% Find the x and y coordinates
[changeX, changeY] = find(abs(Gmag) >= Gthreshold);
markedImage = repmat(image, [1, 1, 3]);

% Mark the points with changing gradient
for i = 1:length(changeX)
    x = changeX(i);
    y = changeY(i);
    markedImage(x, y, 2) = 255;
    markedImage(x, y, 3) = 0; 
end

imshow(markedImage);
%% Lens adition
%This uses the enhances image. Asks the user for 10 point along the lens
%and creates an oval which is then placed on the original image
lens_add('enhanced.tif')
%% Section selection
%This selects the general section of the image for later analysis. It
%detects the brightest pixels and using edge detection, outups a binary
%black/white figure
segmentation('marama.tif')
%% Curve Selection
%User selects curved region using same edge detection
curve_seg('new_image.tif')
%% Graphical analysis (no practical use other than the report)
graph_analysis('new_curve_image.tif')
%% Curve analysis
%Analyzes curve using eccentricity
fprintf('The curve info is as follows')
curve_analysis ('new_curve_image.tif')
%% Distance curve
%For non-uniform curves or curves that only first the ideal section
distance1 = variousdistance('new_curve_image.tif');
fprintf('The diameter is: %f pixels\n', distance1);
disp('The radius:')
radius = distance1/2
%% Distance between some two points
%For thickness, etc.
distance = variousdistance('cleaned_image.tif');
fprintf('The distance between these two points is: %f pixels\n', distance);
%% Correction- z axis(depth)
%% Corrections- based on parameters


