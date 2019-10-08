%Load each image and display the results
for ind = 1:8
    
    if ind == 1
        I = imread('Resources/WhiteCircle2019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Circle");
    elseif ind == 2
        I = imread('Resources/WhiteEllipse12019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Ellipse 1");
    elseif ind == 3
        I = imread('Resources/WhiteEllipse22019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Ellipse 2");
    elseif ind == 4
        I = imread('Resources/WhiteEllipse32019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Ellipse 3");
    elseif ind == 5
        I = imread('Resources/WhiteRectangle2019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Rectangle");
    elseif ind == 6
        I = imread('Resources/WhiteTriangle2019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Triangle");
    elseif ind == 7
        I = imread('Resources/WhiteRectangle22019-1.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Rectangle 2");
    elseif ind == 8
        I = imread('Resources/WhiteDiamond2019.tif');
        I = im2double(I(:,:,1)/3 + I(:,:,2)/3 + I(:,:,3)/3);
        disp("WHITE Diamond");
    end
    [centroid,box,angle,Area,perimeter,circ] = getShapeParams(I);

    Xc = centroid(1);
    Yc = centroid(2);
    
    %Draw in figure
    

    disp("CENTROID: " + Xc + "," + Yc);
    disp("BOUNDING BOX: " + box(1,1) + "," + box(1,2) + " " + box(2,1) + "," + box(2,2));
    disp("ANGLE: " + angle);
    disp("AREA: " + Area);
    disp("PERIMETER: " + perimeter);
    disp("CIRCULARITY: " + circ);
    disp("  ");
end

