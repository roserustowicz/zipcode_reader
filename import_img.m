function [img] = import_img(filename)
%IMPORT_IMG Summary of this function goes here
%   Detailed explanation goes here
img = imread(filename);
img = rgb2gray(img);

while max(size(img, 1), size(img, 2)) > 1000
    img = imresize(img, 0.5);
end

end

