%Loading the images
wd = imread('WhiteDiamond2019.tif');
wd = wd(:,:,1:3);

wr = imread('WhiteRectangle2019.tif');
wr = wr(:,:,1:3);

ws = imread('WhiteSquare2019.tif');
ws = ws(:,:,1:3);

wt = imread('WhiteTriangle2019.tif');
wt = wt(:,:,1:3);

%Convert to intensity
wdI = double(wd(:,:,1)/3 + wd(:,:,2)/3 + wd(:,:,3)/3);
wrI = double(wr(:,:,1)/3 + wr(:,:,2)/3 + wr(:,:,3)/3);
wsI = double(ws(:,:,1)/3 + ws(:,:,2)/3 + ws(:,:,3)/3);
wtI = double(wt(:,:,1)/3 + wt(:,:,2)/3 + wt(:,:,3)/3);
%Run through Laplacian Filter
[m,n] = size(I);

%Filtered Images
WDF = LaplacianFilter(wdI);
WRF = LaplacianFilter(wrI);
WSF = LaplacianFilter(wsI);
WTF = LaplacianFilter(wtI);