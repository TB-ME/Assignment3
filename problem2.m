%Import the image
I = imread('cameraman.tif');
[m,n,f] = size(I);
figure, imshow(I);


%Rotate the image by 30 degrees

%Create the final Image
rotImage = zeros(m,n,1);
%Variable for rotation
rot = pi/8;

%Get the location of ceneter of the image
center_x = m/2;
center_y = n/2;

mid_x = center_x*cos(rot) + center_y*sin(rot);
mid_y = -center_x*sin(rot) + center_y*cos(rot);

trans_x = center_x - mid_x;
trans_y = center_y - mid_y;

for i = 1:m
    for j = 1:n
        pixel_matrix = [i,j,1];
        
        x = floor(i*cos(rot) + j*sin(rot) + trans_x);
        y = floor(-i*sin(rot) + j*cos(rot) + trans_y);
        if x < m && y < n && x > 0 && y > 0
            rotImage(x,y,1) = im2double(I(i,j,1));
        end
    end
end

%Use Nearest Neighbour to remove black spots 
rotImage = nearestNeighbour_(rotImage,m,n);
figure, imshow(rotImage);

%Shrink the Image by half
%Create the shrinked array
[m,n,f] = size(I);
shrinkedImg = zeros(m/2,n/2);

%Scaling the image down using a kernel size of 2
for i = 1:2:m
    for j = 1:2:n
        shrinkedImg(round(i/2),round(j/2)) = im2double((I(i,j)/4 + I(i+1,j))/4 + I(i+1,j+1)/4 + I(i,j+1)/4);
    end
end
figure, imshow(shrinkedImg);

%Increase the scale of the image
[m,n,f] = size(I);
sf = 2
enlargedImg = zeros(m*sf,n*sf);
%Using Nearest Neighbor other algorithms could be used
for i = 1:m
    for j = 1:n
        enlargedImg(sf*i,sf*j) = im2double(I(i,j));
        %Added because nn is only looking at one line atm
        enlargedImg(sf*i+1,sf*j) = im2double(I(i,j));     
    end
end
enlargedImg = nearestNeighbour_(enlargedImg,m*sf,n*sf);

figure, imshow(enlargedImg);