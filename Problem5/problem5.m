%Import image
WhiteMix = imread('WhiteMix2019.tif');

I = double(WhiteMix(:,:,1)/3+WhiteMix(:,:,2)/3+WhiteMix(:,:,3)/3);

%Apply Filter

%Follow Line 

%Crop out shape

%Add shape to self contatined blob

%Repeat till image is completely black