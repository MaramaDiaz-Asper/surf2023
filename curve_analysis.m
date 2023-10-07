function curve_analysis(new_image)
    bwImage = imread(new_image);
    figure;
    imshow(bwImage);
    title('Select 6 Points on the Curve');
    [x, y] = ginput(6); 
    % 6 points for now- no need to keep this later on (user input risky)
    close;
    figure;
    imshow(bwImage);
    hold on;
    % Plot
    plot(x, y, 'go', 'MarkerSize', 10);
    %fitEllipseToPointsLSQ function
    ellipseParams = fitEllipseToPointsLSQ([x, y]);

    % Eccentricity
    eccentricity = sqrt(1 - (ellipseParams(3)^2 / ellipseParams(4)^2));
    %Parabola used is 2nd degree
    if eccentricity > 1
        p = polyfit(x, y, 2);
        xFit = linspace(min(x), max(x), 100);
        yFit = polyval(p, xFit);
        plot(xFit, yFit, 'b', 'LineWidth', 2);
        disp('Fitted Parabola Coefficients:');
        disp(p);
        fprintf('Equation: y = %.4fx^2 + %.4fx + %.4f\n', p(1), p(2), p(3));
    %Ellipse (section needs to be double checked found this info on sus site
    else
        a = ellipseParams(3);
        b = ellipseParams(4); 
        angle = deg2rad(ellipseParams(5)); 
        centerX = ellipseParams(1);
        centerY = ellipseParams(2);
        t = linspace(0, 2*pi, 100);
        xFit = centerX + a * cos(t) * cos(angle) - b * sin(t) * sin(angle);
        yFit = centerY + a * cos(t) * sin(angle) + b * sin(t) * cos(angle);
        plot(xFit, yFit, 'b', 'LineWidth', 2);
        % Ellipse parameters
        disp('Fitted Ellipse Parameters:');
        disp(['Center X: ', num2str(centerX)]);
        disp(['Center Y: ', num2str(centerY)]);
        disp(['Major Axis: ', num2str(a)]);
        disp(['Minor Axis: ', num2str(b)]);
        disp(['Orientation Angle (degrees): ', num2str(ellipseParams(5))]);
    end

    title('Fitted Curve and Shape Parameters');
    hold off;
    end