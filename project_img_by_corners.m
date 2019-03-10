function [projected_img] = project_img_by_corners(img, outer_edge_img)
%PROJECT_IMG_BY_CORNERS Finds the outermost corners in an image and 
% reprojects the image to the full spatial extent of the image space

% Find the corners in the outer edge image
corners = detectHarrisFeatures(outer_edge_img);
corner_locs = round(corners.Location);

if numel(unique(corner_locs)) > 4
    corner_locs = get_4_corners(corner_locs);
end

% Project the image so that the corners take up the whole image

% Define desired locations as the image boundaries
desired_locs = [[1, 1]; [1, size(img, 1)]; [size(img, 2), 1]; [size(img, 2), size(img, 1)]];

% Define the transformation matrix for the projection
tform = fitgeotrans(corner_locs, desired_locs, 'projective');

projected_img = imwarp(img,tform);
projected_outer_edges = imwarp(outer_edge_img, tform);
%figure; imshow(projected_outer_edges, []); title('Projected outer edge')

% Find new corners and crop image to corners
new_corners = detectHarrisFeatures(projected_outer_edges);
new_corner_locs = round(new_corners.Location);

min_row = min(new_corner_locs(:, 2));
max_row = max(new_corner_locs(:, 2));
min_col = min(new_corner_locs(:, 1));
max_col = max(new_corner_locs(:, 1));

projected_img = projected_img(min_row:max_row, min_col:max_col);
%figure; imshow(projected_img, []); title('Cropped projected image')

end

