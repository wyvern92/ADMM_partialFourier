function [ret] = vec2mat(vec,col)
%VEC2MAT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
ret = reshape(vec, [numel(vec)/col col]);
end

