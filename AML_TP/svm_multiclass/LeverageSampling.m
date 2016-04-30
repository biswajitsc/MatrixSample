function D_proj = LeverageSampling(D, r)

[U, S, V] = svd(D);
rankv = rank(S);
V = V(:,1:rankv);

W = V.*V;
W = sum(W,2);
W = W/sum(W);

dim = size(D);
n = dim(1);
d = dim(2);

D_proj = [];
for i = [1:d]
    if rand(1) < min(1, r*W(i))
        D_proj = [D_proj D(:,i)/sqrt(W(i))];
    end
end

P = D*D'; Q = D_proj*D_proj';
c = sum(sum(P.*Q))/sum(sum(Q.*Q));

D_proj = c * D_proj;