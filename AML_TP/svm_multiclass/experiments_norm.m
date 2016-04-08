function [Errors, Ranks] = experiments_norm(datatype, N, D, K, v, pho, t, rper, batch)
%     
    test_error_LS = zeros(batch,1);
    test_error_PCA = zeros(batch,1);
    test_error_CW = zeros(batch,1);
    test_error_ABSS = zeros(batch,1);
    test_error_SS = zeros(batch,1);
    test_error = zeros(batch,1);
    
    r = ceil(D*rper);

    for iter = [1:batch]
        
        if strcmp(datatype, 'dense')
            data = GenData2(N, D, v);
        elseif strcmp(datatype, 'sparse')
            data = GenDataSparse(N, D, v, pho);
        end
        
        test_error(iter,1) = 0.0;
        
        disp('For PCA ...\n');
           data_proj = computePCA(data, r);
           test_error_PCA(iter, 1) = find_norm_error(data,data_proj);
           str = sprintf('Test error for iteration %d : %f\n', iter, test_error_PCA(iter, 1));
           disp(str);
           
           
        disp('For Clarkson Woodruff...\n');
           [data_proj, ~ , ~] = ClarksonWoodruff(data', r);
           data_proj = data_proj';
           test_error_CW(iter, 1) = find_norm_error(data,data_proj);
           str = sprintf('Test error for iteration %d : %f\n', iter, test_error_CW(iter, 1));
           disp(str);
        
%         disp('For Approximate BSS...\n');
%            [S, Diag] = ApproximateBSS(data, t, r);
%            data_proj = data * S * Diag;
%            test_error_BSS(iter, 1) = find_norm_error(data,data_proj);
%            str = sprintf('Test error for iteration %d : %f\n', iter, test_error_BSS(iter, 1));
%            disp(str);
%         
%         disp('For Spectral Sparsification...\n');
%            [~, sig, V] = svd(data);
%            rankv = rank(sig);
%            V = V(:,1:rankv);
%            [S, Diag] = Spectral_sparsification(V', r);
%            data_proj = data * S * Diag;    
%            test_error_ABSS(iter, 1) = find_norm_error(data,data_proj);
%            str = sprintf('Test error for iteration %d : %f\n', iter, test_error_ABSS(iter, 1));
%            disp(str);
%            
        test_error_ABSS(iter,1) = 100.0;
        test_error_SS(iter,1) = 100.0;
              
        disp('For Leverage Sampling...\n');
           data_proj = LeverageSampling(data, r);
           test_error_LS(iter, 1) = find_norm_error(data,data_proj);
           str = sprintf('Test error for iteration %d : %f\n', iter, test_error_LS(iter, 1));
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