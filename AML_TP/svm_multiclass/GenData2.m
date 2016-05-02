function D = GenData2(n, u, v)

[U, S, V] = svd(rand(n,u));

disp(size(U));
disp(size(S));
disp(size(V));

cr = min(n,u);
ind = randsample(cr, cr-v);
for i=1:(cr-v)
    it = ind(i);
    S(it,it) = 0.0;
end

D = U * S * V';
% D = D + normrnd(0, 0.01, n, u);
