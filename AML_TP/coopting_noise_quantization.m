function A_proj = coopting_noise_quantization(A)

%Assumes A(i,j) to be within -1 to +1

dim = size(A);
A_proj = zeros(dim[1],dim[2]);
for i = [1:d]
    for j = [1:k]
        if rand(1,1) < (1+A(i,j))/2
            A_proj(i,j) = 1.0;
        else
            A_proj(i,j) = -1.0;
        end
    end
end


