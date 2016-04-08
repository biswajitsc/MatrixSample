function A_proj =coopting_noise_uniform_sampling(A)

%Assumes A(i,j) to be within -1 to +1

dim = size(A);
A_proj = zeros(dim[1],dim[2]);
p = rand(1,1);
for i = [1:d]
    for j = [1:k]
        if p > 0 & rand(1,1) < p
            A_proj(i,j) = A(i,j)/p;
        else
            A_proj(i,j) = 0.0;
        end
    end
end

