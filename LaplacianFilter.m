function [Laplacian] = LaplacianFilter(I)
%Laplacian Filter runs an Intensity image through a laplacian filter
[m,n] = size(I);
Laplacian = zeros(m,n);
for i = 2:m-1
    for j = 2:n-1 
        val = -1*I(i-1,j-1)-1*I(i-1,j)-1*I(i-1,j+1) ...
                         -1*I(i,j-1)+8*I(i,j)-1*I(i,j+1) ...
                         -1*I(i+1,j-1)-1*I(i+1,j)-1*I(i+1,j+1);
       if val > 1
           Laplacian(i,j) = 1;
    end
end
end

