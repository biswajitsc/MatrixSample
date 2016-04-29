function error = find_norm_error(A,A_proj)

dim = size(A);
num = dim(1);
V = A*A';
V_ = A_proj*A_proj';

    diff = (V - V_);
    diff = diff.*diff;
    diff = sum(diff);
    diff = sum(diff);
    diff = diff/num/num;
    diff = sqrt(diff);
    error = diff;
    
end

% error = error/num;