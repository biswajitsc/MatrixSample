function [FeatureMatrix,W1,W2] = GenData_StructSVM(n, u, v, k) 

FeatureMatrix = zeros(n,k*u);
[d_i,w1,w2] = GenData1(k*n,u,v);

for class_i = [1:k]
    for i = [n*(class_i-1)+1:n*class_i]
        for j = [1:u]
            i_ = i - n*(class_i-1);
            j_ = j + u*(class_i-1);
            FeatureMatrix(i_,j_) = d_i(i,j);
        end
    end
end
    

W1 = GetProb1(FeatureMatrix);
W2 = GetProb2(FeatureMatrix);