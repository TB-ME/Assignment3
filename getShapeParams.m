function [centroid,box,angle,Area,perimeter,circularity] = getShapeParams(I)
%Extracts the shape parameters from a image

%Find the boundary box
[m,n] = size(I);

Xmin = n;
Xmax = 0;
Ymin = m;
Ymax = 0;

for y = 1:m
    for x = 1:n
        if I(x,y) == 1
            if Xmin > x
                Xmin = x;
            end
            if Xmax < x
                Xmax = x;
            end
            if Ymin > y
                Ymin = y;
            end
            if Ymax < y
                Ymax = y;
            end
        end
    end
end

box = [Xmin,Ymin;Xmax,Ymax];

%Get moments
[M00,M01,M10,M11,M02,M20] = getMoments(I);
Area = M00;

Xc = M10/M00;
Yc = M01/M00;

centroid = [Xc,Yc];

%Inertia matrix of a blob 
j = [M20 - Xc*M10, M11 - Xc*M01;M11-Xc*M01,M02-Yc*M01];

%Extracts the EigenVector and EigenValues
eigvector = eig(j);
eigvalue = 0;
if eigvector(1) > eigvector(2)
    eigvalue = eigvector(1);
else
    eigvalue = eigvector(2);
end

angle = atan(eigvector(1)/eigvector(2));

%Find the Perimeter
perimeter = getPerimeter(I);

%Calculates the Circularity
circularity = 4*pi*M00/(perimeter*perimeter);
end

