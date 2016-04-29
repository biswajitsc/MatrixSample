function x = compute_voting(A)

error = 0.001;
dim = size(A);
x = rand(dim(2),1);
x_temp = x + 500;
while abs(max(x - x_temp)) > error
    x = x_temp;
    y = A*x;
    x_temp = A'*y/norm(A'*y);
end

x = x_temp;    



