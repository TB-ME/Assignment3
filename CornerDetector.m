function [Corners] = CornerDetector(img,m,n,minval)
%Apply  a simple corner detecting algorithm

Corners = zeros(10,2);
numCorners = 1;
for i = 2:m-1
    for j = 2:n-1
         val =          sqrt( (img(i,j) - img(i,j+1))^2 + ... 
                              (img(i,j) - img(i,j-1))^2 + ...
                              (img(i,j) - img(i+1,j))^2 + ...
                              (img(i,j) - img(i-1,j))^2 + ...  
                              (img(i,j) - img(i+1,j+1))^2 + ... 
                              (img(i,j) - img(i+1,j-1))^2 + ...
                              (img(i,j) - img(i-1,j+1))^2 + ...
                              (img(i,j) - img(i-1,j-1))^2 ...
                             );
         
         if val >= minval 
             Corners(numCorners,1) = i;
             Corners(numCorners,2) = j;
             numCorners = numCorners + 1;
         end
    end
end

end

