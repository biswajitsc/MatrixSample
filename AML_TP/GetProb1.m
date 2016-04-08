function W1 = GetProb1(D)

[U, S, V] = svd(D);
r = rank(D);

U1 = U(:, 1:r);
W1 = sum((U1.*U1)')';

W1 = W1/sum(W1);