%{ 
Create average kernels for typed values 0 - 9 digits from the 
Kaggle "English Typed Alphabets and Numbers Dataset". Each digit 
has 1,016 examples. 
%}

for num = 0:9
    fnames = dir(fullfile(strcat('../project_data/numerical_kernels/kernels_', num2str(num)), '*.png'));
    
    count = 0;
    img = zeros(128, 128);
    for fname = 1:size(fnames, 1)
        cur_fname = strcat(strcat('../project_data/numerical_kernels/kernels_', num2str(num), '/') , fnames(fname).name);
        cur_img = double(imread(cur_fname));
        img = img + cur_img;
        count = count + 1;
    end
    
    avg_img = img / count;
    
    figure; imshow(avg_img, [])
    imwrite(uint8(avg_img), strcat('avg_kernel_', num2str(num), '.png'))
end