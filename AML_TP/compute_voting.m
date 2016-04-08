function x = compute_voting(A)

error = 0.001;
x = rand(d,1);
x_temp = x + 500;
while abs(max(x - x_temp)) > error
    x = x_temp;
    y = A*x;
    x_temp = A'*y/norm(A'*y);

x = x_temp;    



