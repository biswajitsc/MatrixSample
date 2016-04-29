function A_proj =coopting_noise_weighted_sampling(A)

%Assumes A(i,j) to be within -1 to +1

dim = size(A);
A_proj = zeros(dim(1),dim(2));
p = rand(1,1);
d = dim(1); k = dim(2);

for i = [1:d]
    for j = [1:k]
        if p > 0 & A(i,j) > 0 & rand(1,1) < p*square(A(i,j))
            A_proj(i,j) = A(i,j)/(p*square(A(i,j)));
        else
            A_proj(i,j) = 0.0;
        end
    end
end


