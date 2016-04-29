function A_proj = equiv_norm(A,k)

dim = size(A);
d = dim(2);
R = zeros(d,k);
for i = [1:d]
    for j = [1:k]
        R(i,j) = normrnd(0,1);
    end
end
A_proj = (1/sqrt(k)) * A * R;

