function [training_error,test_error] = Experiments(n,d,k)
X = rand(n,d);
W = rand(d,k);

Labels = X*W;
Y = zeros(n,1);
for i = [1:n]
    [~,inds] = sort(Labels(i,:));
    Y(i,1) = inds(k);
end

[training_error,test_error] = StructSVM(X,Y);

    

