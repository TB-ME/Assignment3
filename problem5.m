%Pseudocode (draft):
%Input image and binarise
%Scan through line by line until a desired pixel is found
%Check in every direction until undesired pixel is found and record the max and min location values and store
%Extract blob to new image, remove blob from previous image and label figure
%Repeat until image has been completely scanned

%Import image
WhiteMix = loadTIF('Resources/WhiteMix2019.tif');
%WhiteMix = imread('WhiteMix2019.tif');
%figure, imshow(WhiteMix);

%Apply Filter
%convert image to greyscale and binarise
I = double(WhiteMix(:,:,1)/3 + WhiteMix(:,:,2)/3 + WhiteMix(:,:,3)/3);
[m,n] = size(I);
Ithreshold = zeros(m,n);
for i = 1:m
    for j = 1:n
        if I(i,j) > 220
            Ithreshold(i,j) = 255;
        else
            Ithreshold(i,j) = 0;
        end
    end
end

Ithreshold = uint8(Ithreshold);
Ib = imbinarize(Ithreshold);
figure, imshow(Ib);
Ib_temp = Ib;

%Main algorithm:
%Cycle through pixels row-wise
blob_count = 0;
for i = 1:m
    for j = 1:n
        %Once a bright pixel is encountered move down the column and along row in both directions
        if Ib_temp(i,j) == 1
            ymin = i; ymax = i;
            xmin = j; xmax = j;
            y = i;
            x = j;
            %increment y value and check x values until limits of blob are reached.
            while Ib_temp(y,x) == 1
                while Ib_temp(y,x) == 1
                    xmin = x;
                    x = x - 1;
                end
                x = j; %reset x coordinate
                while Ib_temp(y,x) == 1
                    xmax = x;
                    x = x + 1;
                end
                x = j; %reset x coordinate
                ymax = y;
                y = y + 1;
            end

            %Remove blob from Ib and blacken.
            %Add shape to self contained blob
            blob = zeros(size(Ib));
            blob(ymin:ymax,xmin:xmax) = Ib(ymin:ymax,xmin:xmax);

            %Blacken area of original image that contained
            Ib_temp(ymin:ymax,xmin:xmax) = 0;

            %display blob in separate labelled figure and continue.
            blob_count = blob_count + 1;
            figure, imshow(blob);
            title(['Blob ', num2str(blob_count)]);
            
            figure, imshow(Ib_temp);

            %Repeat till image is completely black
        end
    end
end
