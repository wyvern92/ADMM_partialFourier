function [ret] = vec2mat(vec,col)
%VEC2MAT 此处显示有关此函数的摘要
%   此处显示详细说明
ret = reshape(vec, [numel(vec)/col col]);
end

