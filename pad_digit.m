function [digit] = pad_digit(digit)
%PAD_DIGIT to a square

% add vertical padding first
pad_size = 1;
digit = padarray(digit, [pad_size, 0], 255, 'pre');
digit = padarray(digit, [pad_size, 0], 255, 'post');

[nrows, ncols] = size(digit);

num_to_pad = abs(ncols - nrows);
nfront_pad = floor(num_to_pad/2);
nend_pad = ceil(num_to_pad/2);

if nrows < ncols
    digit = padarray(digit,[nfront_pad, 0], 255,'pre');
    digit = padarray(digit,[nend_pad, 0], 255,'post');
elseif ncols < nrows
    digit = padarray(digit,[0, nfront_pad], 255,'pre');
    digit = padarray(digit,[0, nend_pad], 255,'post');
end


end

