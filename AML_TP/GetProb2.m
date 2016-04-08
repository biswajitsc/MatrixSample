function W2 = GetProb2(D)

[U, S, V] = svd(D);
r = rank(D);

U2 = U * S;
U2 = U2(:, 1:r);
W2 = sum((U2.*U2)')';

W2 = W2/sum(W2);