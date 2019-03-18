% Main script for zipcode reader
clear all; close all; clc;
kernel_dir = '../project_data/numerical_kernels/kernels_avg';
fnames = [dir(fullfile('../project_data/samples', '*.jpg')) ; dir(fullfile('../project_data/samples', '*.png'))];

for fname = 22:(size(fnames, 1))
    % project, rotate, and crop envelope
    cur_fname = strcat('../project_data/samples/' , fnames(fname).name);
    cur_sample = fnames(fname).name(1:end-4);
    [img, formatted_img] = format_envelope(cur_fname, cur_sample);
    
    % locate receiver's address
    cropped_img = find_bounding_box(formatted_img);
    %figure; imshow(cropped_img, []); title('Cropped Address')
    %saveas(gcf, strcat(cur_sample, '_12_cropped_address.jpg'))
    
    figure; 
    subplot(3, 1, 1); imshow(img); title('Original Image')
    subplot(3, 1, 2); imshow(formatted_img); title('Formatted Image')
    subplot(3, 1, 3); imshow(cropped_img); title('Cropped Image')
    %saveas(gcf, strcat(cur_sample, '_13_comparison_plot.jpg'))
    
    % locate the five zip code numbers and show prediction
    digits = find_zipcode_digits(cropped_img);
    figure()
    hold on
    for i = 1:5
        digit = pad_digit(digits{i});
        digit = imresize(digit,[128 128]);
        trans = transcribe_digit(digit, kernel_dir, cur_sample, i);
        
        subplot(1,5,i)
        imshow(digit)
        title(trans)
        %saveas(gcf, strcat(cur_sample, '_14_prediction_plot.jpg'))
    end 
end







