function [A_proj,phi,D] = ClarksonWoodruff(A,t)

dim = size(A);
n = dim(1);
d = dim(2);

h = t*rand(1,n);
phi = zeros(t,n);
for i = [1:n]
    phi(ceil(h(i)),i) = 1;
end

D = zeros(n,n);
for i = [1:n]
    if rand < 0.5
        D(i,i) = 1;
    else
        D(i,i) = -1;
    end
end


A_proj = phi * D * A;