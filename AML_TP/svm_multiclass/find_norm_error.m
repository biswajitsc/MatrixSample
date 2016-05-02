function error = find_norm_error(A,A_proj)

    dim = size(A);
    n = dim(1); m = dim(2);
    
    [U,S,~] = svd(A);
    r = rank(A);
    U = U(:,1:r); S = S(1:r,1:r);
    
    error = norm(A*A'-A_proj*A_proj', 'fro')/norm(U, 'fro')^2/norm(S, 'fro')^2;
end
