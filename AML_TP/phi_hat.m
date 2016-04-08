function phi_val = phi_hat(U,A)
lambda = eig(A);
dim = size(A);
l = dim(1);

phi_val = 0;
for i = [1:l]
   phi_val = phi_val + 1/(U - lambda(i)); 
end
    