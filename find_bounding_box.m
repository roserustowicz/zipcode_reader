function cropped_img = find_bounding_box(formatted_img)
    % dilating image
    se = strel('disk',15);
    opened_img = imopen(formatted_img,se);
    opened_img_bw = (opened_img<200);

    % using region props to find bounding boxes 
    s = regionprops(opened_img_bw,'BoundingBox','Centroid');
    
    % finding lowest centroid of reasonable size
    lowest_centroid = -1;
    index = -1;
    for iter = 1:length(s)
        if( s(iter).Centroid(2) > lowest_centroid && s(iter).BoundingBox(3) > 100  && s(iter).BoundingBox(4) > 50 )
            index = iter;
            lowest_centroid = s(iter).Centroid(2);
        end
    end
    
    if(index~=-1)
        bounding_box = round(s(index).BoundingBox);
        % crop original img to lowest bounding box
        minc = bounding_box(1);
        minr = bounding_box(2);
        maxc = bounding_box(1)+bounding_box(3)-1;
        maxr = bounding_box(2)+bounding_box(4)-1;
        cropped_img = formatted_img(minr:maxr,minc:maxc);
    else
        cropped_img = formatted_img;
    end
    
end