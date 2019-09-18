function [I] = loadTIF(path)
I = im2double(imread(path));
I = I(:,:,1:3);
end

