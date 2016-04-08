function A = GenDataSparse(n, u, v, pho)
%pho is the fraction of zero values.

A = GenData2(n, u, v);
zero_entries = floor(pho*n*u);
ind = randsample(n*u, zero_entries);

for it=1:zero_entries
    i = floor(ind(it)/u);
    j = ind(it) - u*i;
    if j == 0
        j = u;
    else
        i = i+1;
    end
    A(i,j) = 0;
end