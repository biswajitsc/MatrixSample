function [S,D] = ApproximateBSS(X,t,r)
dim = size(X);
p = dim(1);
d = dim(2);

G = normrnd(0,1.0,t,p);
X_hat = G*X;

[U,Sig,V] = svd(X_hat);

[S,D] = Spectral_sparsification(V',r);
