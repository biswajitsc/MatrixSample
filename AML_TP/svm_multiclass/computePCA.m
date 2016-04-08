function A_proj = computePCA(A, r)
[~, A_proj] = pca(A, 'NumComponents', r);