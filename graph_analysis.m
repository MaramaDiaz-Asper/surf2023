function graph_analysis (curve_image)
    bwImage = imread(curve_image);
    figure;
    hold on;

    [height, width] = size(bwImage);
    x = 0:width - 1;
    y = 0:height - 1;
    [X, Y] = meshgrid(x, y);

    % Find the coordinates from curve segmented image
    brightnessThreshold = 100;
    brightPixels = bwImage > brightnessThreshold;
    %Flip (I have no idea why I need to flip-might be by condition
    Y = height - 1 - Y;

    % Plot
    scatter(X(brightPixels), Y(brightPixels), 5, 'r', 'filled');
    axis([0 width - 1 0 height - 1]);
    xlabel('X');
    ylabel('Y');
    title('Curve on Graph');
    figure;
    imshow(bwImage);
    title('Segmented Curve Image');
end

