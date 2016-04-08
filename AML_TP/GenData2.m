function [D, W1, W2] = GenData2(n, u, v)

[U, S, V] = svd(rand(n,u));

ind = randsample(u, u-v);
for i=1:v
    it = ind(i);
    S(it,it) = 0.0;
end

D = U * S * V';
D = D + normrnd(0, 0.05, n, u);

W1 = GetProb1(D);
W2 = GetProb2(D);