function L_val = calc_L(v,del_L,A,L)

dim = size(A);
l = dim(1);
I_l = eye(l);

L_val = (v'*mpower(A - (L+del_L)*I_l, -2)*v)/(phi(L+del_L,A) - phi(L,A));
L_val = L_val - v'*inv(A - (L+del_L)*I_l)*v;

