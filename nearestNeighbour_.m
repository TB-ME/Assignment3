function [img] = nearestNeighbour_(img,x_max,y_max)
%Uses the nearest neighbour algorithm to sample points to fill in white
%spots
prev_val = 0;
for i = 1:x_max
    for j = 1:y_max
        if img(i,j) == 0
            img(i,j) = prev_val;
            prev_val = 0;
        else
            prev_val = img(i,j);
        end
    end
    prev_val = 0;
end
end

