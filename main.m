% Main script for zipcode reader
clear all; close all; clc;

fnames = [dir(fullfile('samples', '*.jpg')) ; dir(fullfile('samples', '*.png'))];

for fname = 1:size(fnames, 1)
    cur_fname = strcat('samples/' , fnames(fname).name);
    [img, formatted_img] = format_envelope(cur_fname);
    figure; 
    subplot(2, 1, 1); imshow(img); title('Original Image')
    subplot(2, 1, 2); imshow(formatted_img); title('Formatted Image')
    
end







