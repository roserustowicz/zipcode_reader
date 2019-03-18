%{ Script for cross correlation, matched filtering example
%}

main_img = double(imread('../project_data/cropped_samples/sample_03.jpg'));
template = double(imread('../project_data/numerical_kernels/kernels_avg/avg_kernel_0.png'));
templateA = imresize(template, [size(main_img, 2)/8, size(main_img, 2)/8]);
templateB = main_img(73:96, 190:203);

correlation = normxcorr2(templateA, main_img);
figure; imagesc(correlation)

[ypeak, xpeak] = find(correlation==max(correlation(:)));

%yoffSet1 = round(ypeak-size(templateA,1)/2);
%yoffSet2 = round(ypeak+size(templateA,1)/2);
%xoffSet1 = round(xpeak-size(templateA,2)/2);
%xoffSet2 = round(xpeak+size(templateA,2)/2);

%correlation(yoffSet1:yoffSet2, xoffSet1:xoffSet2) = 1;
figure; imagesc(correlation);

figure; imagesc(main_img)
figure; imagesc(templateA)