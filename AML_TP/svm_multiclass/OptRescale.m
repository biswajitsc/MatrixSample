function D_proj = OptRescale(A, A_proj)
    P = A*A'; Q = A_proj*A_proj';
    c = sqrt(sum(sum(P.*Q))/sum(sum(Q.*Q)));
    D_proj = c * A_proj;