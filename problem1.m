% Read Image
img = imread('Resources/AppleTree.png');

RED = img(:,:,1);
GREEN = img(:,:,2);
BLUE = img(:,:,3);
% transform image into intensities


%Array to store the locations of the apples
Apples = zeros(10,2);
numApples = 0;

len = size(img);

for i = 1:len(1)
    for j = 1:len(2)
        %If x is above a threshold then the color is red
        if (RED(i,j) >= 200) && GREEN(i,j) <= 100 && BLUE(i,j) <= 100
            Apples(numApples+1,1) = i;
            Apples(numApples+1,2) = j;
            numApples = numApples + 1;
        end
    end
end

%Displaying the Number of Apples and Apple Locations
disp("NUMBER OF APPLES: " + numApples);

for i = 1:length(Apples)
    if Apples(i,1) ~= 0
        disp("APPLE LOCATION " + i + ": " + Apples(i,1) + "," + Apples(i,2));
    end
end
    