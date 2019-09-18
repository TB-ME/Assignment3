%Import the image
I = loadTIF('Resources/GreyRectangle.tif');
[m,n,f] = size(I);
figure, imshow(I);


%Rotate the image by 30 degrees

%Create the final Image
rotImage = ones(m,n,3)*255;
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
        x = round(i*cos(rot) + j*sin(rot) + trans_x);
        y = round(-i*sin(rot) + j*cos(rot) + trans_y);
        if x < m && y < n && x > 0 && y > 0
            rotImage(x,y,1:3) = I(i,j,1:3);
        end
    end
end

%Shrink the Image by half
%Create the shrinked array
[m,n,f] = size(img);
shrinkedImg = ones(m/2,n/2,f)*255;

%Scaling the image down
%TODO could create a larger kernel
for i = 1:2:m
    for j = 1:2:n
        shrinkedImg(round(i/2),round(j/2),:) = (img(i,j,:) + img(i+1,j+1,:))/2;
    end
end

%Increase the scale of the image
[m,n,f] = size(img);
enlargedImg = ones(m*2,n*2,f);
%Using Nearest Neighbor other algorithms could be used
for i = 1:m
    for j = 1:n
        enlargedImg(2*i,2*j,:) = img(i,j,:);
        if i < m && j < n
            enlargedImg(2*i+1,2*j,:) = img(i,j,:);
            enlargedImg(2*i,2*j+1,:) = img(i,j,:);
            enlargedImg(2*i+1,2*j+1,:) = img(i,j,:);
        end        
    end
end