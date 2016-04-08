function error = find_norm_error(A,A_proj)
error = 0.0;
dim = size(A);
num = dim(1);
for i = [1:num]
    orig_norm = norm(A(i,:));
    proj_norm = norm(A_proj(i,:));
    error = error + abs(orig_norm - proj_norm)/orig_norm;
end

error = error/num;