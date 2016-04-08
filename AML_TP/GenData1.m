function [D, W1, W2] = GenData1(n, u, v)
ind = randsample(u, v);
base = zeros(v, u);

for i = [1:v]
    base(i,ind(i)) = 2*rand(1);
end

D = zeros(n, u);

for i = [1:n]
    D(i,:) = (-ones(1, v) + 2*rand(1, v)) * base;
end
    
A = orth(rand(u, u));

D = D * A';

D = D + normrnd(0, 0.05, n, u);

W1 = GetProb1(D);
W2 = GetProb2(D);
