function error = find_norm_error(A,A_proj)
error = 0.0;
dim = size(A);
num = dim(1);
V = A*A';
V_ = A_proj*A_proj';

    diff = (V - V_)./V;
    diff = diff.*diff;
    diff = sum(diff);
    diff = sum(diff);
    diff = diff/num/num;
    diff = sqrt(diff);
%     orig_norm = norm(A(i,:));
%     proj_norm = norm(A_proj(i,:));
%     error = error + abs(orig_norm - proj_norm)/orig_norm;
error = diff

% error = error/num;