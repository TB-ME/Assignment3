%Loading the images
wd = imread('Resources/WhiteDiamond2019.tif');
wd = wd(:,:,1:3);

wr = imread('Resources/WhiteRectangle2019.tif');
wr = wr(:,:,1:3);

ws = imread('Resources/WhiteSquare2019.tif');
ws = ws(:,:,1:3);

wt = imread('Resources/WhiteTriangle2019.tif');
wt = wt(:,:,1:3);

%Convert to intensity
wdI = double(wd(:,:,1)/3 + wd(:,:,2)/3 + wd(:,:,3)/3)/255;
wrI = double(wr(:,:,1)/3 + wr(:,:,2)/3 + wr(:,:,3)/3)/255;
wsI = double(ws(:,:,1)/3 + ws(:,:,2)/3 + ws(:,:,3)/3)/255;
wtI = double(wt(:,:,1)/3 + wt(:,:,2)/3 + wt(:,:,3)/3)/255;

%Run through Corner Dectector
[m,n] = size(wdI);
Diamond_Corners = CornerDetector(wdI,m,n,2);
[m,n] = size(wrI);
Rectangle_Corners = CornerDetector(wrI,m,n,2);
[m,n] = size(wsI);
Square_Corners = CornerDetector(wsI,m,n,2);
[m,n] = size(wtI);
Triangle_Corners = CornerDetector(wtI,m,n,2.01);

%Displaying the results
for i = 1:size(Diamond_Corners)
    if Diamond_Corners(i,1) > 0
        disp("CORNER " + i + " ON DIAMOND: " + Diamond_Corners(i,1) + "," + Diamond_Corners(i,2));
    end
end

%Displaying the results
for i = 1:size(Rectangle_Corners)
    if Rectangle_Corners(i,1) > 0
        disp("CORNER " + i + " ON RECTANGLE: " + Rectangle_Corners(i,1) + "," + Rectangle_Corners(i,2));
    end
end

%Displaying the results
for i = 1:size(Square_Corners)
    if Square_Corners(i,1) > 0
        disp("CORNER " + i + " ON SQUARE: " + Square_Corners(i,1) + "," + Square_Corners(i,2));
    end
end

%Displaying the results
for i = 1:size(Triangle_Corners)
    if Triangle_Corners(i,1) > 0
        disp("CORNER " + i + " ON TRIANGLE: " + Triangle_Corners(i,1) + "," + Triangle_Corners(i,2));
    end
end

