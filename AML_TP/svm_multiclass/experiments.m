function [Errors, Ranks] = experiments(datatype, N, D, K, v, pho, t, rper, batch)
%     
    train_error_CW = zeros(batch,1);
    train_error_ABSS = zeros(batch,1);
    train_error_SS = zeros(batch,1);
    train_error_PCA = zeros(batch,1);
    train_error_LS = zeros(batch,1);
    train_error = zeros(batch,1);
    test_error = zeros(batch,1);
    test_error_LS = zeros(batch,1);
    test_error_PCA = zeros(batch,1);
    test_error_CW = zeros(batch,1);
    test_error_ABSS = zeros(batch,1);
    test_error_SS = zeros(batch,1);
    
    r = ceil(D*rper);

    for iter = [1:batch]
        
        if strcmp(datatype, 'dense')
            data = GenData2(N, D, v);
        elseif strcmp(datatype, 'sparse')
            data = GenDataSparse(N, D, v, pho);
        end
        Y = labels(data, N, D, K);
    
        disp('Original matrix...\n');
           [train_error(iter, 1), test_error(iter, 1)] = BinarySVM(data, Y, 0.8);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error(iter, 1), iter, test_error(iter, 1));
           disp(str);
           
        disp('For PCA ...\n');
           data_proj = computePCA(data, r);
           [train_error_PCA(iter, 1), test_error_PCA(iter, 1)] = BinarySVM(data_proj, Y, 0.8);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error_PCA(iter, 1), iter, test_error_PCA(iter, 1));
           disp(str);
           
           
        disp('For Clarkson Woodruff...\n');
           [data_proj, ~ , ~] = ClarksonWoodruff(data', r);
           data_proj = data_proj';
           [train_error_CW(iter, 1), test_error_CW(iter, 1)] = BinarySVM(data_proj, Y, 0.8);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error_CW(iter, 1), iter, test_error_CW(iter, 1));
           disp(str);
        
%         disp('For Approximate BSS...\n');
%            [S, Diag] = ApproximateBSS(data, t, r);
%            data_proj = data * S * Diag;
%            [train_error_ABSS(iter, 1), test_error_ABSS(iter, 1)] = BinarySVM(data_proj, Y, 0.8);
%            str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error_ABSS(iter, 1), iter, test_error_ABSS(iter, 1));
%            disp(str);
%         
%         disp('For Spectral Sparsification...\n');
%            [~, sig, V] = svd(data);
%            rankv = rank(sig);
%            V = V(:,1:rankv);
%            [S, Diag] = Spectral_sparsification(V', r);
%            data_proj = data * S * Diag;    
%            [train_error_SS(iter,1), test_error_SS(iter,1)] = BinarySVM(data_proj, Y, 0.8);
%            str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error_SS(iter, 1), iter, test_error_SS(iter, 1));
%            disp(str);
%            
        train_error_ABSS(iter, 1) = 100.0;
        test_error_ABSS(iter,1) = 100.0;
        train_error_SS(iter, 1) = 100.0;
        test_error_SS(iter,1) = 100.0;
              
        disp('For Leverage Sampling...\n');
           data_proj = LeverageSampling(data, r);
           [train_error_LS(iter, 1), test_error_LS(iter, 1)] = BinarySVM(data_proj, Y, 0.8);
           str = sprintf('Train error for iteration %d : %f\nTest error for iteration %d : %f\n', iter, train_error_LS(iter, 1), iter, test_error_LS(iter, 1));
           disp(str);
    end
    
    Ranks = evaluateRanking(test_error_CW, test_error_ABSS, test_error_SS, test_error_PCA, test_error_LS, batch, 5);
%     evaluateHistogram(test_error_CW, test_error_ABSS, test_error_SS);


Errors = [mean(test_error) var(test_error)
    mean(test_error_PCA) var(test_error_PCA)
    mean(test_error_LS) var(test_error_LS)
    mean(test_error_CW) var(test_error_CW)
    mean(test_error_SS) var(test_error_SS)
    mean(test_error_ABSS) var(test_error_ABSS)
    ];



                
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


function [rank] = evaluateRanking(test_error_CW, test_error_ABSS, test_error_SS, test_error_PCA, test_error_LS, batch, num_methods)
    rank = zeros(num_methods);
    
    for iter = 1:batch
        [~,inds] = sort([test_error_CW(iter,1), test_error_ABSS(iter, 1), test_error_SS(iter,1), test_error_PCA(iter, 1), test_error_LS(iter, 1)]);
        for i = 1:num_methods
            rank(i,inds(i)) = rank(i, inds(i))+1;
        end
  
    end
    
    disp(rank);
    
end