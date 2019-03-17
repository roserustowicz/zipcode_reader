% Main script for zipcode reader
clear all; close all; clc;

fnames = [dir(fullfile('../project_data/samples', '*.jpg')) ; dir(fullfile('../project_data/samples', '*.png'))];

for fname = 2:size(fnames, 1)
    % orienting and cropping envelope
    cur_fname = strcat('../project_data/samples/' , fnames(fname).name);
    [img, formatted_img] = format_envelope(cur_fname);
    
    % locating address
    cropped_img = find_bounding_box(formatted_img);
    
    figure; 
    subplot(3, 1, 1); imshow(img); title('Original Image')
    subplot(3, 1, 2); imshow(formatted_img); title('Formatted Image')
    subplot(3, 1, 3); imshow(cropped_img); title('Cropped Image')
    
    % locating zip code numbers
    digits = find_zipcode_digits(cropped_img);
    figure()
    hold on
    for i = 1:5
        subplot(1,5,i)
        imshow(digits{i})
    end 

end







