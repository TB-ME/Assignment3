%Pseudocode (draft):
%Input image and binarise
%Scan through line by line until a desired pixel is found
%Check in every direction until undesired pixel is found and record the max and min location values and store
%Extract blob to new image, label figure and overwrite previous image
%Repeat until image has been completely scanned

%Import image
%WhiteMix = loadTIF('Resources/WhiteMix2019.tif');
WhiteMix = imread('Resources/WhiteMix2019.tif');
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
Ib = double(Ib);
%figure, imshow(Ib);

%Main algorithm:
%Cycle through pixels row-wise
blob_count = 2; %Start at 2 to differentiate from other blobs.

for i = 1:m
    for j = 1:n
        %Once a bright pixel is encountered move down the column and along row in both directions
        if Ib(i,j) == 1
            ymin = i; ymax = i;
            xmin = j; xmax = j;
            y = i;
            x = j;

            %increment y value and check x values until limits of blob are reached.
            while Ib(y,x) == 1
                while Ib(y,x) == 1
                    if xmin >= x
                        xmin = x;
                    end
                    x = x - 1;
                end
                x = j; %reset x coordinate
                while Ib(y,x) == 1
                    if xmax <= x
                        xmax = x;
                    end
                    x = x + 1;
                end
                x = j; %reset x coordinate
                ymax = y;
                y = y + 1;
            end

            %Remove blob from Ib and blacken.
            %Add shape to self contained blob
            blob = zeros([m,n]);
            blob(ymin:ymax,xmin:xmax) = Ib(ymin:ymax,xmin:xmax);

            %Label each blob with a number
            for c = ymin:ymax
                for d = xmin:xmax
                    if blob(c,d) == 1
                        blob(c,d) = blob_count;
                    end
                end
            end

            %display blob in separate labelled figure and continue.
            figure, imshow(blob);
            title(['Blob ', num2str(blob_count)]);
            blob_count = blob_count + 1;

            %Overwrite area of original image that contained blob
            Ib(ymin:ymax,xmin:xmax) = blob(ymin:ymax,xmin:xmax);

            %Repeat till image is completely black
        end
    end
end

%Display final result (should look unchanged but array will confirm each blob is labelled correctly)
figure, imshow(Ib);
title('Final labelled image');