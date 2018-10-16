% test solver for complex BP
clc;
clear;
close all;

format long;

opts.nonorth = 1;
n = 40;
m = floor(n/4); 
k = floor(m/2);
fprintf('\nSize [n,m,k] = [%i,%i,%i]\n',n,m,k);

xsize = [n n];
N = prod(xsize);

% generate xs of sparse signal
xs = zeros(N,1);
p = randperm(N); 
p = p(1:k);
xs(p) = randn(k,1) + 1i*randn(k,1);

% generate partial DFT data
p = randperm(n);
picks = sort(p(1:m)); picks(1) = 1;
perm = 1:n; % column permutations allowable

A = dftmtx(n);     % using DFT matrix will lead to different b's 
% A = randn(n,n);  % if this is real matrix then everything is okay.
A = A(picks,:);
F = kron(A,A); % get F
[r,c] = size(F);

% F(U)
vec_b1 = F*xs;

% get S
% WARNING: 
% The prime operator ' in matlab is actually an alias to ctranspose, 
% which does not only convert rows to columns, 
% or columns to rows of ordinary matrices or vectors,but also calculates the complex conjugate, 
% i.e. changes the sign of the imaginary part.
S = vec2mat(xs, n);
ASAT = A*S*(A.');
vec_b2 = mat2vec(ASAT.');

Fm = Fmap(picks, n, m);
vec_b3 = Fm.times(xs);

openvar('vec_b1');
openvar('vec_b2');
openvar('vec_b3'); % successful!! All three times are equivalent.

% vec_x1 = F.'*vec_b1;
% vec_x2 = (A')*(ASAT)*A; % this is not simple transpose? Conjugate transpose
% vec_x3 = Fm.trans(vec_b3); % successful. All three trans are equivalent
% 
% openvar('vec_x1');
% openvar('vec_x2');
% openvar('vec_x3');

% but why they are not equal to xs?
% openvar('xs');









