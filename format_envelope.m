function [img, formatted_img] = format_envelope(filename, sample_name)
%FORMAT_ENVELOPE Includes all necessary steps to read in, format, and  
%  write an envelope sample

% Read in image
img = import_img(filename);
%figure; imshow(img, []); title('Original Sample')
%saveas(gcf, strcat(sample_name, '_01_original_sample.jpg'))

% Find outermost lines on envelope
outer_edge_img = get_outer_edge(img, sample_name);

% Find the corners and project image to rectangle of img size
projected_img = project_img_by_corners(img, outer_edge_img, sample_name);

% Rotate the image
rotated_img = rotate_img(projected_img);
%figure; imshow(rotated_img, []); title('Rotated Image')
%saveas(gcf, strcat(sample_name, '_10_rotated_image.jpg'))

% Resize the image
formatted_img = resize_img(rotated_img);
%figure; imshow(formatted_img, []); title('Resized Image')
%saveas(gcf, strcat(sample_name, '_11_resized_image.jpg'))

% Save the formatted image
if contains(filename, 'jpg')
    out_fname = strrep(filename, '.jpg', '_formatted.jpg');
    out_fname = strrep(out_fname, 'samples', 'formatted_samples');
elseif contains(filename, 'png')
    out_fname = strrep(filename, '.png', '_formatted.png');
    out_fname = strrep(out_fname, 'samples', 'formatted_samples');
end
%imwrite(formatted_img, out_fname);

end

