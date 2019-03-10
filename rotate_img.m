function [rotated_img_final] = rotate_img(projected_img)
%ROTATE_IMG Rotate the image such that the return address is in the 
% upper left and the stamp is in the upper right. We assume the envelope 
% has both a return address and postage stamp in the two upper corners, 
% and look for the rotation that yields the highest signal there.

rotated_img_final = 0;

[nrows, ncols] = size(projected_img);
npix = round(min(nrows, ncols)/4);

thetas = [0, 1, 2, 3]; % thetas * 90

for theta_idx = 1:numel(thetas)
    rotated_img = rot90(projected_img, thetas(theta_idx));

    upper_left = rotated_img(1:npix, 1:npix);
    upper_left = sum(upper_left(:));
    upper_right = rotated_img(1:npix, size(rotated_img, 2)-npix:end);
    upper_right = sum(upper_right(:));
    lower_right = rotated_img(size(rotated_img, 1)-npix:end, size(rotated_img, 2)-npix:end);
    lower_right = sum(lower_right(:));
    lower_left = rotated_img(size(rotated_img, 1)-npix:end, 1:npix);
    lower_left = sum(lower_left(:));
        
    if upper_left < lower_right && upper_left < lower_left && upper_right < lower_right && upper_right < lower_left
        rotated_img_final = rotated_img;
        break
    end
end

if rotated_img_final == 0       
    disp('There was an error with image rotation.')
end
%figure; imshow(final_img, []); title('Rotated Image')

end

