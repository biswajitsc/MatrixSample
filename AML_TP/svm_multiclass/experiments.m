function [Errors, Ranks] = experiments(datatype, N, D, K, v, pho, t, rper, batch)
%   
    num_methods = 4;
    train_error = zeros(num_methods,batch,1);
    test_error = zeros(num_methods,batch,1);
    
    r = ceil(D*rper);
    
    for iter = [1:batch]   
        method_iter = 0;
        
        if strcmp(datatype, 'dense')
            data = GenData2(N, D, v);
        elseif strcmp(datatype, 'sparse')
            data = GenDataSparse(N, D, v, pho);
        end
        
        Y = labels(data, N, D, K);
    
        disp('Original matrix...\n');
           [train_error(method_iter+1, iter, 1), test_error(method_iter+1, iter, 1)] = StructSVM(data, Y);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error(method_iter+1, iter, 1), iter, test_error(method_iter+1, iter, 1));
           disp(str);
           
        method_iter = mod(method_iter + 1, num_methods);
        
        disp('For PCA ...\n');
           data_proj = computePCA(data, r);
           [train_error(method_iter+1, iter, 1), test_error(method_iter+1, iter, 1)] = StructSVM(data_proj, Y);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error(method_iter+1, iter, 1), iter, test_error(method_iter+1, iter, 1));
           disp(str);
           
        method_iter = mod(method_iter + 1, num_methods);
        
        disp('For Clarkson Woodruff...\n');
           [data_proj, ~ , ~] = ClarksonWoodruff(data', r);
           data_proj = data_proj';
           [train_error(method_iter+1, iter, 1), test_error(method_iter+1, iter, 1)] = StructSVM(data_proj, Y);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error(method_iter+1, iter, 1), iter, test_error(method_iter+1, iter, 1));
           disp(str);
        
        method_iter = mod(method_iter + 1, num_methods);
                   
        disp('For Leverage Sampling...\n');
           data_proj = LeverageSampling(data, r);
           [train_error(method_iter+1, iter, 1), test_error(method_iter+1, iter, 1)] = StructSVM(data_proj, Y);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error(method_iter+1, iter, 1), iter, test_error(method_iter+1, iter, 1));
           disp(str);
        
        method_iter = mod(method_iter + 1, num_methods);
        
    end
    
    Ranks = evaluateRanking(train_error, batch, num_methods);

    Errors = zeros(num_methods,2);
    for i = [1:num_methods]
        Errors(i,1) = mean(train_error(i,:,1));
        Errors(i,2) = var(train_error(i,:,1));
        disp(train_error(i,:,1));
    end
        
% % Errors = [mean(test_error) var(test_error)
%     mean(test_error_PCA) var(test_error_PCA)
%     mean(test_error_LS) var(test_error_LS)
%     mean(test_error_CW) var(test_error_CW)
%     mean(test_error_SS) var(test_error_SS)
%     mean(test_error_ABSS) var(test_error_ABSS)
%     ];

end
           

function[Y] = labels(X, N, D, K)
 
    W = rand(D, K);    
    Labels = X*W;
    Y = zeros(N,1);
    for i = [1:N]
        [~,inds] = sort(Labels(i,:));
        Y(i,1) = inds(K);
        if rand < 0.1 
            Y(i,1) = ceil(K*rand);
        end
    end
end


function [rank] = evaluateRanking(test_error, batch, num_methods)
    rank = zeros(num_methods);
    for iter = 1:batch
        temp_error = zeros(1,num_methods);
        for i=[1:num_methods]
            temp_error(1,i) = test_error(i,iter,1);
        end
        [~,inds] = sort(temp_error);
        for i = 1:num_methods
            rank(i,inds(i)) = rank(i, inds(i))+1;
        end
  
    end
    
    disp(rank);    
end