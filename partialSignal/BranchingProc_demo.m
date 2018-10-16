% now in this file, we modify our F into function handles
clc;
clear;

format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% this is for loading data %%%%%%
load('data.mat');

Asize = size(A);
[m n] = size(A);
xsize = [n n];
b = mat2vec(B);
A = conj(A);

% Ind is loaded by default
% X is the target, loaded by default

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = Fmap(Ind, n, m); 

opts.nonorth = 1;
opts.basis = wavelet_basis(xsize); % use wavelet basis for L1
opts.tol = 4*1e-3; 
opts.rho = 1e-1; % parameter for the inverse of L1's lambda

tic; 
[x,Out] = yall1(F, b, opts);  
toc;
u = mat2vec(X);
x = real(x); rerr = norm(x-u)/norm(u);

plot(1:numel(x),real(x),'b.',1:numel(u),real(u),'ro');


