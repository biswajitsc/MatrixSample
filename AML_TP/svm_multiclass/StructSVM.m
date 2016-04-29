function [sample_error, training_error, testing_error] = StructSVM(Xsample, Ysample, Xtrain, Ytrain, Xtest, Ytest)

%% Using the StructSVM function
% Takes input the data matrix X (Nxd) matrix
% The corresponding labels Y (Nx1) matrix
% Split into train, validate and test, and output the corresponding testing
% error for the same
% Uses SVM_Light with Struct SVM for multi-class class classification.
% Run from the script from the same folder where you build it.

%% Split and test
	sample_data_X = Xsample;
	sample_data_Y = Ysample;
    
	train_data_X = Xtrain;
	train_data_Y = Ytrain;

	testing_data_X = Xtest;
	testing_data_Y = Ytest;
    
    write_to_file(sample_data_X, sample_data_Y, 'data/sample.dat');
	write_to_file(train_data_X, train_data_Y, 'data/train.dat');
	write_to_file(testing_data_X, testing_data_Y, 'data/test.dat');

	! ./svm_multiclass_learn -c 0.1 data/sample.dat data/model 
    ! ./svm_multiclass_classify data/sample.dat data/model data/predictions
	
	fileID = fopen('output.txt','r');
	formatSpec = '%f';
	sample_error = fscanf(fileID,formatSpec);
    
	! ./svm_multiclass_classify data/train.dat data/model data/predictions
	
	fileID = fopen('output.txt','r');
	formatSpec = '%f';
	training_error = fscanf(fileID,formatSpec);

	! ./svm_multiclass_classify data/test.dat data/model data/predictions

	fileID = fopen('output.txt','r');
	formatSpec = '%f';
	testing_error = fscanf(fileID,formatSpec);

end

function [] = write_to_file(X, Y, filename)
	dim = size(X);
	N = dim(1);
	d = dim(2);
    disp(N);
	fileID = fopen(filename,'w');
	for example = [1:N]
		fprintf(fileID, '%d', Y(example));
		for dim = [1:d]
			fprintf(fileID,' %d:%f', dim, X(example, dim) );
		end
		fprintf(fileID,'\n');
	end
	fclose(fileID);
end