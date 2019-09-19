%Pseudocode (draft):
%Input image and binarise
%Scan through line by line until a desired pixel is found
%Check in every direction until undesired pixel is found and record the max and min location values and store
%Extract blob to new image, remove blob from previous image and label figure
%Repeat until image has been completely scanned

%Import image
WhiteMix = loadTIF('Resources/WhiteMixComplex2019.tif');
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
figure, imshow(I);
Ib_temp = I;

%Main algorithm:
%Cycle through pixels row-wise
blob_count = 0;
%Blobs are getting overwritten, creating a variable array so store them all
%for displaying later
blob_array = I;
for i = 1:m
    for j = 1:n
        %Once a bright pixel is encountered move down the column and along row in both directions
        if Ib_temp(i,j) == 1
            ymin = i; ymax = i;
            xmin = j; xmax = j;
            y = i;
            x = j;
            
            %cropping out the blob
            blob = zeros(m,n);
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
                %Get blob
                blob(y,xmin:xmax) = I(y,xmin:xmax);
                %Blacken blob
                Ib_temp(y,xmin:xmax) = 0;
                
                %Check if any vertical pixels have been missed
                for x_vert = xmin:xmax
                    y_vert = y-1;
                    while Ib_temp(y_vert,x_vert) == 1
                        blob(y_vert,x_vert) = I(y_vert,x_vert);
                        Ib_temp(y_vert,x_vert) = 0;
                        y_vert = y_vert - 1;
                    end
                end
                
                %Itr params
                x = j; %reset x coordinate
                ymax = y;
                y = y + 1;
            end

            %display blob in separate labelled figure and continue.
            blob_count = blob_count + 1;
            
            %Store blobs in array
            [mb,nb,fb] = size(blob_array);
            blob_array_temp = blob_array;
            blob_array = zeros(mb,nb,fb + 1);
            blob_array(:,:,1:fb) = blob_array_temp;
            blob_array(:,:,fb+1) = blob;

            %Repeat till image is completely black
        end
    end
end
