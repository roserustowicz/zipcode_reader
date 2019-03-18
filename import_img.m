function [img] = import_img(filename)
%IMPORT_IMG Reads in and preprocesses an image

% Read in image
img = imread(filename);
% Convert to grayscale
img = rgb2gray(img);

% Resize
while max(size(img, 1), size(img, 2)) > 1000
    img = imresize(img, 0.5);
end

end

