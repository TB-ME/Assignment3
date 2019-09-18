% Read Image
img = imread('AppleTree.png');

RED = img(:,:,1)
GREEN = img(:,:,2)
BLUE = img(:,:,3)
% transform image into intensities


%Array to store the locations of the apples
tempApples = zeros(10,2);
numApples = 1;

len = size(img);

for i = 1:len(1)
    for j = 1:len(2)
        %If x is above a threshold then the color is red
        if (RED(i,j) >= 200) && GREEN(i,j) <= 100 && BLUE(i,j) <= 100
            tempApples(numApples,1) = i;
            tempApples(numApples,2) = j;
            numApples = numApples + 1;
        end
    end
end

Apples = tempApples((Apples(:,1) > 0),:);
    