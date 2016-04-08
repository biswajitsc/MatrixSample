function U_val = calc_U(v,del_U,A,U)

dim = size(A);
l = dim(1);
I_l = eye(l);

U_val = (v'*mpower((U+del_U)*I_l - A, -2)*v)/(phi_hat(U,A) - phi_hat(U+del_U,A));
U_val = U_val + v'*inv((U+del_U)*I_l - A)*v;

