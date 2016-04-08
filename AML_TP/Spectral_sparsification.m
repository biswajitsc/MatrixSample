function [S,D] = Spectral_sparsification(V,r) 
% r > l
    

dim = size(V);
l = dim(1);
d = dim(2);

A = zeros(l,l);
S = zeros(d,r);
D = zeros(r,r);

del_L = 1;
del_U = (1 + sqrt(l/r))/(1 - sqrt(l/r));
mark = zeros(d);
for t = [0:r-1]
   L_t = t - sqrt(r*l);
   U_t = del_U*(t + sqrt(l*r));
   picked = -1;
   for i = [1:d]
       v1 = calc_U(V(:,i), del_U, A, U_t);
       v2 = calc_L(V(:,i), del_L, A, L_t);
       if mark(i) == 0 & v1 <= v2
           picked = i;
           break;
       end   
   end
   mark(picked) = 1;
   t_r = 1/(0.5*(v1+v2));
   A = A + t_r*V(:,picked)*V(:,picked)';
   S(picked,t+1) = 1;
   D(t+1,t+1) = 1/sqrt(t_r);
end

D = sqrt( 1/r * (1-sqrt(l/r))) * D;

