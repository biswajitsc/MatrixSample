filename = 'Experiments_Data_StructSVM_Train_New2.csv';
M = csvread(filename);
num_methods = 3;
offset = 7;
Y = M(:,offset:offset+2*num_methods - 1);
disp(Y);
X = [0.2:0.1:1.0];

figure 

C = ['b','g','r'];

for i = [1:num_methods]
    plot(X,Y(:,i),C(i));
    hold on;
end

xlabel('Sampling fraction');
ylabel('Percentage Error');
legend('PCA','Clarkson Woodruff','Leverage Sampling','Location','northwest');