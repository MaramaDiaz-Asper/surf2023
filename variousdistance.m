function distance = variousdistance(imagePath)
    imshow(imagePath);
    title('Click two points on the image');

    % Get two points
    points = ginput(2);

    % Calculate the distance between the points
    x1 = points(1, 1);
    y1 = points(1, 2);
    x2 = points(2, 1);
    y2 = points(2, 2);

    distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
end

