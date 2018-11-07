clc;
clear;

n = 100;
N = n*n;

m = floor(0.8*n);
k = floor(.001*N);
fprintf('\nSize [n,m,k] = [%i,%i,%i]\n',n,m,k);

% A = randn(m,n) + 1i*randn(m,n);

% when using DFT matrix
% the prediction is all 0? 
% Observe an intereseting pattern: for complex signals, detection is good ;
% when using real signals, DFT matrix will not be a good choice?
% need to explore more in the future.

A = dftmtx(n); 
picks = randperm(n); 
picks = picks(1:m);
A = A(picks,:);

F = kron(A,A); % construct a case using kronecker product

xs = zeros(N,1); 
p = randperm(N); 
xs(p(1:k)) = randn(k,1) + 1i*rand(k,1);
% xs(p(1:k)) = 2*(rand(k,1) > 0.5) - 1;

sigma = 0.005;
b = F*(xs) + sigma*randn(m*m,1); 

rho = 1e-30;

% kronecker 
disp('--- YALL1 with kronecker ---');
opts.tol = 1e-3; 
opts.rho = rho;
opts.nonorth = 1;
% opts.mu = 1e3;

% try different basis
xsize = [n n];
opts.basis.trans = @(x)reshape(ifft2(reshape(x,xsize))*n*n,numel(xs),1);
opts.basis.times = @(x)reshape(fft2(reshape(x,xsize)),numel(xs),1);

tic; [x1,Out] = yall1(kron(A,A), b, opts); toc

% fft2d

disp('--- yall1 with fft2d ---');
F = Fmap(picks, n, m); % using FFT2d
tic; x2 = yall1(F, b, opts); toc

dx12 = norm(x1-x2)/norm(x1);
fprintf('Diff. of the two: %6.4e\n\n',dx12)
figure(1);
set(gca,'fontsize',18)
plot(1:N,real(x1),'bo',1:N,real(x2),'r.',1:N,real(xs),'k*');
legend('Kronecker','FFT2','Exact');
figure(2);
plot(1:N,imag(x1),'bo',1:N,imag(x2),'r.',1:N,imag(xs),'k*');
legend('Kronecker','FFT2','Exact');





