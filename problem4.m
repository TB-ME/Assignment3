whiteCircle = imread('WhiteCircle2019.tif');
imshow(whiteCircle);

%Get the intensity of the image 
I = double(whiteCircle(:,:,1)/3 + whiteCircle(:,:,2)/3 + whiteCircle(:,:,3)/3);

%Find the centre of the shape
[m,n] = size(I);

M10 = 0;
M01 = 0;
M00 = 0;

%Max and Min Vals
maxX = 0;
maxY = 0;
minX = m;
minY = n;

%Calculating the Area
area = 0;
for i = 1:m
    for j = 1:n
        %Find the centre of the shape
        M10 = M10 + i*I(i,j)/255;
        M01 = M01 + j*I(i,j)/255;
        M00 = M00 + I(i,j)/255;
        
        %Find the max and mins
        if I(i,j) == 255 && i > maxX
            maxX = i;
        end
        if I(i,j) == 255 && j > maxY
            maxY = j;
        end
        if I(i,j) == 255 && i < minX
            minX = i;
        end
        if I(i,j) == 255 && i < minY
            minY=j;
        end
        
        %Calculating the Area
        if I(i,j) == 255
            area = area + 1;
        end
    end
end

%Calculating the centre
Xc = M10/M00;
Yc = M01/M00;

%Central Moment
u20 = (M10/M00)*M10 - Xc*M10;
u11 = (M10/M00)*M01 - Xc*M01;
u02 = (M01/M00)*M01 - Yc*M01;

%Finding the EIGEN Values
J = [u20 u11;u11 u02];
EIG = eig(J);
[V,D,W] = eig(J);

%Finding Major Axis and Angle
MA = 2*sqrt(EIG(1)/M00);
ANG = atan(V(1)/V(2));

%Finding Circularity 
%Calculating Perimeter
%TODO can be optimised 
IFiltered = LaplacianFilter(I);
%Count the perimeter
p = 0;
for i = 1:m
    for j = 1:n
        if IFiltered(i,j) >= 258
            p = p + 1;
        end
    end
end

Circ = double(4*pi*M00/(p^2));
imshow(IFiltered);


