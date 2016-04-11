function A_proj = compute_low_rank_approx(A,k)

dim = size(A);
A_temp = zeros(dim[1],dim[2]);
X_subspace = zeros(dim[2],k);
for i = [1:k]
    x = compute_voting(A - A_temp);
    X_subspace(i,:) = x; 
    A_temp = A_temp + A * x * x';
end

A_proj = A * X_subspace;

    



