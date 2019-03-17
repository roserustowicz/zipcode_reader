% given the cropped adress image 
% finds bounding boxes for the digits
% assumes that the zipcode is 5 digits 
% at the bottom right of the image

function digits = find_zipcode_digits(cropped_img)
    % dilating the image a little  
    se = strel('disk',1);
    dilated_img = imdilate(cropped_img,se);
    
    % converting image to black and white
    level = graythresh(dilated_img);
    dilated_img_bw = (dilated_img < level*255 );
    
    % using region props to find bounding boxes
    s = regionprops(dilated_img_bw,'BoundingBox','Centroid');
    
    % selecting the 5 bottom-right regions of reasonable size
    centroids = cat(1, s.Centroid);
    weight = 0.3;
    centroid_flat = weight*centroids(:,1) + centroids(:,2); 
    [~,digit_indices] = maxk(centroid_flat,5);
    
    % reversing order of digit_indices to be from first to last digit
    digit_indices = flipud(digit_indices);
    
    % cropping digits from original image and saving in struct
    digits = cell(5,1);
    for index = 1:5
        digit_index = digit_indices(index);
        bounding_box = round(s(digit_index).BoundingBox);
        pad = 2;
        minc = bounding_box(1)-pad;
        minr = bounding_box(2)-pad;
        maxc = bounding_box(1)+bounding_box(3)-1+pad;
        maxr = bounding_box(2)+bounding_box(4)-1+pad;
        digits{index} = cropped_img(minr:maxr,minc:maxc);
    end
end