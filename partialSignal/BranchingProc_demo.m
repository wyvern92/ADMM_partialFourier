% now in this file, we modify our F into function handles
clc;
clear;

format long;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% this is for loading data %%%%%%
load('data.mat');

Asize = size(A);
[m n]  = size(A);
xsize = [n n];
b = mat2vec(B);

% Ind is loaded by default
% X is the target, loaded by default
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = Fmap(Ind, n, m); 

opts.nonorth = 1;

xsize = [n n];
opts.basis.trans = @(x)reshape(ifft2(reshape(x,xsize))*n*n,numel(x),1);
opts.basis.times = @(x)reshape(fft2(reshape(x,xsize)),numel(x),1);

% opts.basis.times = @(x)reshape(fft(x),numel(x),1);
% opts.basis.trans = @(x)reshape(ifft(x),numel(x),1);

opts.maxit = 300;
opts.tol = 1e-2; 
opts.rho = 5; % parameter for the inverse of L1's lambda
% opts.mu = 1e15;  
opts.stepfreq = 1;

tic; 
[x,Out] = yall1_alter(F, b, opts);  
toc;
u = mat2vec(X);
x = real(x); rerr = norm(real(x)-u)/norm(u);

plot(1:numel(x),real(x),'b.',1:numel(u),real(u),'ro');

% plot(1:numel(x),imag(x),'b.');


