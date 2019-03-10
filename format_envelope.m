function [img, formatted_img] = format_envelope(filename)
%FORMAT_ENVELOPE Includes all necessary steps to read in, format, and  
%  write an envelope sample

% Read in image
img = import_img(filename);
%figure; imshow(img, []); title('Original Sample')

% Find outermost lines on envelope
outer_edge_img = get_outer_edge(img);
%figure; imshow(outer_edge_img, []); title('Outer Edge')

% Find the corners and project image to rectangle of img size
projected_img = project_img_by_corners(img, outer_edge_img);
%figure; imshow(projected_img, []); title('Projected Image')

% Rotate the image
rotated_img = rotate_img(projected_img);
%figure; imshow(rotated_img, []); title('Rotated Image')

% Resize the image
formatted_img = resize_img(rotated_img);
%figure; imshow(formatted_img, []); title('Resized Image')

% Save the formatted image
if contains(filename, 'jpg')
    out_fname = strrep(filename, '.jpg', '_formatted.jpg');
    out_fname = strrep(out_fname, 'samples', 'formatted_samples');
elseif contains(filename, 'png')
    out_fname = strrep(filename, '.png', '_formatted.png');
    out_fname = strrep(out_fname, 'samples', 'formatted_samples');
end
imwrite(formatted_img, out_fname);

end

