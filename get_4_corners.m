function [new_corner_locs] = get_4_corners(corner_locs)
%GET_4_CORNERS Gets the relevant four corners from a list of corners

[~, min_row_idx] = min(corner_locs(:, 1));
[~, max_row_idx] = max(corner_locs(:, 1));
[~, min_col_idx] = min(corner_locs(:, 2));
[~, max_col_idx] = max(corner_locs(:, 2));

new_corner_locs = zeros(4, 2);
if corner_locs(min_row_idx, 2) < corner_locs(max_row_idx, 2)
    % the image is right leaning
    % upper left has min row
    new_corner_locs(1, :) = corner_locs(min_row_idx, :);
    % upper right has max col
    new_corner_locs(2, :) = corner_locs(max_col_idx, :);
    % lower left has min col
    new_corner_locs(3, :) = corner_locs(min_col_idx, :);
    % lower right has max row
    new_corner_locs(4, :) = corner_locs(max_row_idx, :);
    
else
    % the image is left leaning
    % upper left has min col
    new_corner_locs(1, :) = corner_locs(min_col_idx, :);
    % upper right has min row
    new_corner_locs(2, :) = corner_locs(min_row_idx, :);
    % lower left has max row
    new_corner_locs(3, :) = corner_locs(max_row_idx, :);
    % lower right has max col
    new_corner_locs(4, :) = corner_locs(max_col_idx, :);
    
end

end

