function Solve3(D, y)
% Varies both sample size and Lambda and plots graph.
% Includes y in leverage score computation.

[n, d] = size(D);
lims = [10:100];
lams = logspace(-10, 1, 12);

W1 = GetProb1([D y]);
[~, inds1] = sort(W1);


pd1 = [];

for samples = lims
    
    inds = inds1(n-samples+1:n);

    Dd = [];
    yy = [];

    for i = inds
        Dd = [Dd; D(i,:)];
        yy = [yy; y(i)];
    end
    
    err = 1000;
    
    for lam = lams
        w = (Dd'*Dd + lam * eye(d))^-1 * Dd' *  yy;
        out = D*w - y;
        err = min(err, sqrt(sum(out .* out)/n));
    end
        
    pd1 = [pd1; err];
end



W2 = GetProb2([D y]);
[~, inds2] = sort(W2);

pd2 = [];

for samples = lims
    
    inds = inds2(n-samples+1:n);

    Dd = [];
    yy = [];

    for i = inds
        Dd = [Dd; D(i,:)];
        yy = [yy; y(i)];
    end
    
    err = 1000;
    
    for lam = lams
        w = (Dd'*Dd + lam * eye(d))^-1 * Dd' *  yy;
        out = D*w - y;
        err = min(err, sqrt(sum(out .* out)/n));
    end
    
    pd2 = [pd2; err];
end

[~, its] = size(lims);

bar(lims, pd1-pd2)
        
        
        
        
        