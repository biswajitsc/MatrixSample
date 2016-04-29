function A_proj = coopting_noise_plusminusAij(A)

dim = size(A);
A_proj = zeros(dim(1),dim(2));
n = dim(1);
d = dim(2);
for i = [1:n]
    for j = [1:d]
        if rand(1,1) < 0.5
            A_proj(i,j) = 2*A(i,j);
        end
    end
end


