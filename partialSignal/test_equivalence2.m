clc;
clear;
A = dftmtx(3);
x = randn(3,3);
Ind = [1 2 3];
Fn = Fmap(Ind,3,3);
b1 = Fn.times(x);
x1 = Fn.trans(b1);

% openvar('x1');
% openvar('x'); % checked: they are equal

A = dftmtx(4);
x = randn(4,4) + 1i*randn(4,4);
Ind = [1 2 ];
Fn = Fmap(Ind,4,2);
b2 = Fn.times(x);
x2 = Fn.trans(b2);

nA = A(Ind,:);
b3 = (nA*(x)*(nA.'));
x3 = (nA)'*(b3)*nA;

Fa = kron(nA,nA);
b4 = Fa*mat2vec(x);
x4 = (b4'*Fa)'; % get from YALL1

openvar('b2');
openvar('b3');
openvar('b4'); % they are equal

openvar('x2');
openvar('x3');
openvar('x4'); %% they are equal
               %  numerically proved that Fmap is equal to kron(A,A) 







