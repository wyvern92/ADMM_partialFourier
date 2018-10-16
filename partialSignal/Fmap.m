function [F] = Fmap(indices, n, m)
% F: a structure containing 2 fields times and trans
%  
F.times = @(x) F_fast(x, indices, n, m);
F.trans = @(y) F_fast_inv(y, indices, n, m);

% function for Ax
function y = F_fast(x,indices, n, m)
    % vector to matrix : only n*n accepted
    x = x(:);
    N = length(x); % this is for the size of signal
    mat = fft2(reshape(x, [n, n])); % get F(u) by ASA' ,i.e. use ifft to approximate ASA'
    y = reshape(mat(indices, indices), m*m, 1); % get the required subset of the mat
end

% function for A'y
function x = F_fast_inv(y, indices, n, m)
    % y here is a matrix , vectorize it to m*m
    invS = zeros(n, n);
    invS(indices, indices) = reshape(y, [m m]);
    x = mat2vec((ifft2(invS.')).'*n*n);    
end
end

