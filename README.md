# MatrixSample
Matrix Sampling Algorithms

## Updates:
  * All recent work is being done in the svm_multiclass folder.
  * svm_multiclass/Experiments_Data_BinarySVM.csv contains the test errors for all the methods.
    where NT denotes no change in datamatrix and M-NT denotes Mean test error on NT method and V-NT denotes variance of test     error on NT method. Similarly CW denotes Clarkson Woodruff method and M-CW and V-CW denote the mean and variance in CW       method respectively.
  * For now methods SS and ABSS have not been run. So, M-SS and M-ABSS have been kept 100.0.
  * svm_multiclass/Experiments_Data_Norm.csv contains the error in the norm of the original vector and the projected vector. Here also the header denote the same thing as in svm_multiclass/Experiments_Data_BinarySVM.csv. Also, SS and ABSS have not been run and kept at 100.0 for now.
  * PlotWrapper_Norm() is used for obtaining svm_multiclass/Experiments_Data_Norm.csv. It calls experiments_norm.m which calls find_norm_error.m. Fix these 3 files if you want to change some thing for norm error things.
  
