function [train_error, test_error] = BinarySVM(X,Y,split)
        dim = size(X);
        num = dim(1);
        train_num = floor(split*num);
        X_train = X(1:train_num,:);
        Y_train = Y(1:train_num);
        X_test = X(train_num+1:end,:);
        Y_test = Y(train_num+1:end);
        
        svmStruct = svmtrain(X_train,Y_train);
        out_train = svmclassify(svmStruct,X_train);
        out_test = svmclassify(svmStruct,X_test);
        
        train_error = 0.0;
        test_error = 0.0;
        
        for i = [1:size(Y_train)]
            if Y_train(i) ~= out_train(i)
                train_error = train_error + 1.0;
            end
        end
        train_error = train_error/train_num;
        
        for i = [1:size(Y_test)]
            if Y_test(i) ~= out_test(i)
                test_error = test_error + 1.0;
            end
        end
        test_error = test_error/(num - train_num);
