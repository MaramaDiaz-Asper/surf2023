%%Segmentation using edge detection
function segmentation(o_Image)
    bwImage = imread(o_Image);
    figure;
    imshow(bwImage);
    title('Selected Section');
    rect = getrect;
    xmin = round(rect(1));
    ymin = round(rect(2));
    width = round(rect(3));
    height = round(rect(4));
    selectedSegment = bwImage(ymin:ymin+height-1, xmin:xmin+width-1);
    % Edge points
    bwSelected = edge(selectedSegment, 'canny');
    [m, n] = find(bwSelected);
    newImage = zeros(size(selectedSegment));
    index = sub2ind(size(newImage), m, n);
    newImage(index) = 1;
    figure;
    subplot(1, 2, 1);
    imshow(bwImage);
    hold on;
    rectangle('Position', rect, 'EdgeColor', 'r', 'LineWidth', 2);
    title('Selected Segment');
    hold off;
    subplot(1, 2, 2);
    imshow(newImage);
    title('Image of Selected Section with Brightest Edge Points');
    imwrite(newImage, 'new_image.tif');
end