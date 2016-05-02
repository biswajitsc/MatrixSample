function A_proj = computePCA(A, r)
[~, A_proj] = pca(A, 'NumComponents', r);

% [~, A_proj] = princomp(A);
% A_proj = A_proj(:,1:r)