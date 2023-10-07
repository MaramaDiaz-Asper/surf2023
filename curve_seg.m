function curve_seg(new_image)
    bwImage = imread(new_image);
    imshow(bwImage);
    title('Select the curve region');
    hROI = imfreehand;
    curveMask = createMask(hROI);
    selectedCurveImage = bwImage .* uint8(curveMask);
    %Save as new_curve_image
    imwrite(selectedCurveImage, 'new_curve_image.tif');
    figure;
    subplot(1, 2, 1);
    imshow(bwImage);
    title('Original Image');
    subplot(1, 2, 2);
    imshow(selectedCurveImage);
    title('Selected Curve');
end