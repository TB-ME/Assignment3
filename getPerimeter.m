function [perimeter] = getPerimeter(I)
%Get the perimeter of the shape
[m,n] = size(I);
perimeter = 0;
temp = zeros(m,n);

%Apply a Edge Filter
for i = 2:m-1
    for j = 2:n-1
        val = 4*I(i,j) - I(i+1,j) - I(i-1,j)- I(i,j+1)- I(i,j-1);
        if val > 0
            temp(i,j) = 1;
        end
    end
end

perimeter = sum(sum(temp));

%{
%Find the start of the shape
X = 0;
Y = 0;

for i = 2:m-1
    for j = 2:n-1         
       if temp(i,j) > 0
           StartY = i;
           StartX = j;
           break;
       end
    end
end

notlooped = 1;
dir = 1;
prev_dir = 1;
X = StartX;
Y = StartY;

%Following the perimeter


while notlooped   
    if dir == 1
        if temp(Y,X + 1) > 0
            perimeter = perimeter + 1;
            X = X + 1; 
            
        else
            dir = 2;
        end
    elseif dir == 2
        if temp(Y+1,X) > 0
            perimeter = perimeter + 1;
            Y = Y + 1; 
            
        else
            dir = 3;
        end
    elseif dir == 3
        if temp(Y,X - 1) > 0
            perimeter = perimeter + 1;
            X = X - 1; 
            
        else
            dir = 4;
        end
    elseif dir == 4
        if temp(Y-1,X) > 0
            perimeter = perimeter + 1;
            Y = Y - 1; 
            
        else
            dir = 1;
        end
    end
    
    if X == StartX && Y == StartY
        break;
    end
end
%}
end

