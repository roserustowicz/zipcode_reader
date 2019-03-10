function [outer_edge_img] = get_outer_edge(img)
%GET_OUTER_EDGE Extracts the outer envelope edge from the input image

% First blur the image with a 5x5 gaussian filter 
blurred_img = imgaussfilt(img, 1.0); 
%figure; imshow(blurred_img, []); title('Blurred img')

% Run edge detection over the image
edges = edge(blurred_img);
%figure; imshow(edges); title('All edges')

% Define the largest boundary as the outline of the envelope
[B,~,~,~] = bwboundaries(edges);
largest_boundary = 0;
for k=1:length(B)
  boundary = B{k};
  num_boundary = size(boundary, 1);
  if num_boundary > largest_boundary
      largest_boundary = num_boundary;
      max_index = k;
  end
end

% Plot the outer edge in the image plane
outer_edge = B{max_index};
outer_edge_img = zeros(size(img, 1), size(img, 2));
for pt_idx = 1:size(outer_edge, 1)
    outer_edge_img(outer_edge(pt_idx, 1), outer_edge(pt_idx, 2)) = 1;
end

se = strel('square', 7);
outer_edge_img = imdilate(outer_edge_img,se);
outer_edge_img = imgaussfilt(outer_edge_img, 2.0); 
se = strel('disk', 5);
outer_edge_img = imerode(outer_edge_img,se);
%figure; imshow(outer_edge_img, []); title('Outer edge')

end

