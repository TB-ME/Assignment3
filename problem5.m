%Pseudocode (draft):
%Input image and binarise
%Scan through line by line until a desired pixel is found
%Check in every direction until undesired pixel is found and record the max and min location values and store
%Calculate centre of the blob and label object
%If centre is the same as another blob discard as blob has already been detected

%Import image
WhiteMix = loadTIF('Resources/WhiteMix2019.tif');

%convert image to greyscale
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

%Apply Filter

%Follow Line

%Crop out shape
    %First find the boundary box that contains the image and then move that to its own image.
    %Blob? = zeros(size(Ib));
    %Blob?(xmin:xmax,ymin:ymax) = Ib(xmin:xmax,ymin:ymax);
    %Ib(xmin:xmax,ymin:ymax) = 0

%Add shape to self contained blob

%Repeat till image is completely black