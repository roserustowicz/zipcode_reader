function cropped_img = find_bounding_box(formatted_img)
    % opening image
    se = strel('disk',15);
    opened_img = imopen(formatted_img,se);
    
    % converting image to black and white
    level = graythresh(opened_img);
    opened_img_bw = (opened_img < level*255 );
    %opened_img_bw = (opened_img<200);

    % using region props to find bounding boxes 
    s = regionprops(opened_img_bw,'BoundingBox','Centroid');
    
    % finding lowest centroid of reasonable size
    lowest_centroid = -1;
    index = -1;
    min_width = 100;
    min_height = 50;
    for iter = 1:length(s)
        if( s(iter).Centroid(2) > lowest_centroid && s(iter).BoundingBox(3) > min_width && s(iter).BoundingBox(4) > min_height )
            index = iter;
            lowest_centroid = s(iter).Centroid(2);
        end
    end
    
    if(index~=-1)
        bounding_box = round(s(index).BoundingBox);
        % crop original img to lowest bounding box
        pad = 5;
        minc = bounding_box(1)-pad;
        minr = bounding_box(2)-pad;
        maxc = bounding_box(1)+bounding_box(3)-1+pad;
        maxr = bounding_box(2)+bounding_box(4)-1+pad;
        cropped_img = formatted_img(minr:maxr,minc:maxc);
    else
        cropped_img = formatted_img;
    end
    
end