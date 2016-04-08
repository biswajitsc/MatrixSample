function [training_error,test_error] = Experiments_StructSVM(n,d,k)
X = rand(n,d);
W = rand(d,k);

Labels = X*W;
Y = zeros(n,1);
for i = [1:n]
    [~,inds] = sort(Labels(i,:));
    Y(i,1) = inds(k);
    if rand < 0.1 
        Y(i,1) = ceil(k*rand);
    end
end

r = floor(0.7*d);
[S,D] = Spectral_sparsification(X,r);
X_proj = X * S * D;
Y_proj = Y;


%X_proj = X;
%Y_proj = Y;


[training_error,test_error] = StructSVM(X_proj,Y_proj);

    

