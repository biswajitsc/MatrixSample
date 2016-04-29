function error = find_norm_error(A,A_proj)

    dim = size(A);
    n = dim(1); m = dim(2);
    
    V = A*A';
    V_ = A_proj*A_proj';

    diff = (V - V_);
    diff = diff.*diff;
    diff = sum(diff);
    diff = sum(diff);
    diff = diff/n/m;
    diff = sqrt(diff);
    error = diff;
end