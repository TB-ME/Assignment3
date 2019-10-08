function [M00,M01,M10,M11,M02,M20] = getMoments(I)
%Detects: Centroid, Bounding Boxes, Major Axes, Angle, Area, Perimeter and
%cirularity

%Moments
M00 = 0;
M01 = 0;
M10 = 0;
M11 = 0;
M20 = 0;
M02 = 0;

[m,n] = size(I);

for y = 2:m-1
    for x = 2:n-1
        M00 = M00 + I(x,y);
        M01 = M01 + y*I(x,y);
        M10 = M10 + x*I(x,y);
        M11 = M11 + x*y*I(x,y);
        M20 = M20 + x*x*I(x,y);
        M02 = M02 + y*y*I(x,y);
       
    end
end
end

