function [resized_img] = resize_img(img)
%RESIZE_IMG Resize an image to the desired shape

resized_img = imresize(img,[400 800]);
%figure; imshow(resized_img, []); title('Resized Image')

end

