function error = find_norm_error(A,A_proj)

dim = size(A);
num = dim(1);
V = A*A';
V_ = A_proj*A_proj';

    diff = (V - V_);
    diff = diff.*diff;
    diff = sum(diff);
    diff = sum(diff);
<<<<<<< HEAD
%     diff = diff/num/num;
%     diff = sqrt(diff);
%     orig_norm = norm(A(i,:));
%     proj_norm = norm(A_proj(i,:));
%     error = error + abs(orig_norm - proj_norm)/orig_norm;
error = diff
=======
    diff = diff/num/num;
    diff = sqrt(diff);
    error = diff;
    
end
>>>>>>> 642b4676edc6ed17a6d83aadb295a11c32ee7232

% error = error/num;