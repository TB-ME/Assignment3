function [Corners] = CornerDetector(img,m,n)
%Apply Harris Corner Detector
Corners = zeros(10,2);

%Applying Convolutions
Ix = zeros(m,n);
Iy = zeros(m,n);

for i = 2:m-1
    for j = 2:n-1
        Ix(i,j) = img(i+1,j) - img(i-1,j);
        Iy(i,j) = img(i,j+1) - img(i,j-1);
    end
end

%Square and Cross Multiply
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

%Apply Guassian Filter
tIx2 = zeros(m,n);
tIy2 = zeros(m,n);
tIxy = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1
        
        valx = 0;
        valy = 0;
        valxy = 0;
        for h = -1:1
            for k = -1:1
                if (h == -1 || h == 1) && (k == -1 || k == 1)
                    valx = valx + Ix2(i+h,j+k)/16;
                    valy =  valy + Iy2(i+h,j+k)/16;
                    valxy = valxy + Ixy(i+h,j+k)/16;
                elseif h == 0 && (k == -1 || k == 1)
                    valx = valx + Ix2(i+h,j+k)/8;
                    valy =  valy + Iy2(i+h,j+k)/8;
                    valxy = valxy + Ixy(i+h,j+k)/8;
                elseif (h == -1 || h == 1) && k == 0
                    valx = valx + Ix2(i+h,j+k)/8;
                    valy =  valy + Iy2(i+h,j+k)/8;
                    valxy = valxy + Ixy(i+h,j+k)/8;
                elseif h == 0 && k == 0
                    valx = valx + Ix2(i+h,j+k)/4;
                    valy =  valy + Iy2(i+h,j+k)/4;
                    valxy = valxy + Ixy(i+h,j+k)/4;
                end
            end
        end
        tIx2(i,j) = valx;
        tIy2(i,j) = valy;
        tIxy(i,j) = valxy;
    end
end

Ix2 = tIx2;
Iy2 = tIy2;
Ixy = tIxy;

Ir = zeros(m,n);
thresh = 0;
k = 0.04;

%Estimating the Eigen Value
R = Ix2.*Iy2 - Ixy.^2 - k*(Ix2+Iy2).^2;

%Filter Matrix by only keep max in a kernel of 3x3
for i = 2:m-1
    for j = 2:n-1
        
        %Finding Max Val
        max_val = 0;
        for h = -1:1
            for k = -1:1
                if max_val < R(i+h,j+k)
                    max_val = R(i+h,j+k);
                end
            end
        end
        
        %Removing Non Max Vals
        covered = 0;
        for h = -1:1
            for k = -1:1
                if R(i+h,j+k) == max_val && covered == 0
                    covered = 1;
                else
                    R(i+h,j+k) = 0;
                end
            end
        end
        
    end
end

itr = 0;
count = 0;
min_corners = 3;
max_corners = 10;
thresh = 1;

%Finding the threshold for the values
while (count < min_corners || count > max_corners) && itr < 20
    if count < min_corners
        thresh = thresh*0.8;
    elseif count > max_corners
        thresh = thresh*1.2;
    end
    Rtemp = (R>thresh);
    count = sum(sum(Rtemp));
    itr = itr + 1;
end

%Finding the locations of corners
corners = find(Rtemp);
for i = 1:size(corners,1)
    Corners(i,1) = mod(corners(i),m);
    Corners(i,2) = floor(corners(i)/m);
end

end

