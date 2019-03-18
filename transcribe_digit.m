function [transcription] = transcribe_digit(digit, kernel_dir, cur_sample, i)
% TRANSCRIBE_DIGIT measures correlation between a digit and 
% all average template kernels. 

max_score = 0;
corr_scores = zeros(1, 10);
fnames = dir(fullfile(kernel_dir, '*.png'));
for fname_idx = 1:size(fnames)

    cur_fname = strcat(kernel_dir, '/', fnames(fname_idx).name);
    cur_kernel = double(imread(cur_fname));
    
    % get correlation score
    corr_scores(fname_idx) = corr2(cur_kernel, digit);
    if corr_scores(fname_idx) > max_score
        % save maxium score as the transcribed value
        transcription = fname_idx - 1;
        max_score = corr_scores(fname_idx);
    end
    
end
        
%figure;
%subplot(1, 2, 1);
%[~, max_idx] = max(corr_scores);
%cur_fname = strcat(kernel_dir, '/', fnames(max_idx).name);
%cur_kernel = double(imread(cur_fname));
%imshow(cur_kernel, [])
%subplot(1, 2, 2);
%imshow(digit, [])
%saveas(gcf, strcat(cur_sample, '_15_', num2str(i), '_pred_vs_maxscore.jpg'))

%figure; plot(0:9, corr_scores); title('Correlation scores across filters')
%saveas(gcf, strcat(cur_sample, '_16_', num2str(i), '_corr_scores.jpg'))

end