function [outer_edge_img] = get_outer_edge(img, sample_name)
%GET_OUTER_EDGE Extracts the outer envelope edge from the input image

% First blur the image with a 5x5 gaussian filter 
blurred_img = imgaussfilt(img, 1.0); 
%figure; imshow(blurred_img, []); title('Blurred img')
%saveas(gcf, strcat(sample_name, '_02_blurred_img.jpg'))

% Run edge detection over the image
edges = edge(blurred_img);
%figure; imshow(edges); title('All edges')
%saveas(gcf, strcat(sample_name, '_03_edge_detection.jpg'))

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
%figure; imshow(outer_edge_img); title('Outer edge image')
%saveas(gcf, strcat(sample_name, '_04_initial_outer_edge.jpg'))

se = strel('square', 7);
outer_edge_img = imdilate(outer_edge_img,se);
%figure; imshow(outer_edge_img); title('Dilated image')
%saveas(gcf, strcat(sample_name, '_05_dilated_outer_edge.jpg'))

outer_edge_img = imgaussfilt(outer_edge_img, 2.0); 
%figure; imshow(outer_edge_img); title('Blurred Dilated image')
%saveas(gcf, strcat(sample_name, '_06_blurred_dilated_outer_edge.jpg'))

se = strel('disk', 5);
outer_edge_img = imerode(outer_edge_img,se);
%figure; imshow(outer_edge_img); title('Eroded Blurred Dilated image')
%saveas(gcf, strcat(sample_name, '_07_eroded_blurred_dilated_outer_edge.jpg'))

end

