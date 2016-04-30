filename = 'Experiments_Data_StructSVM_Achlioptas_Train_New.csv';
M = csvread(filename);
num_methods = 6;
offset = 7;
Y = M(:,offset:offset+2*num_methods - 1);
disp(Y);
X = [0.2:0.1:0.4];

set(groot,'defaultAxesColorOrder',[1 0 0;0 1 0;0 0 1],'defaultAxesLineStyleOrder','-|--|:')
%   
% for i = [1:num_methods]
%     plot(X,Y(:,i));
%     hold on;
% end
figure
hold off
plot(X,Y);
hold on;
xlabel('Sampling fraction');
ylabel('Percentage Error');
% legend('PCA','Clarkson Woodruff','Leverage Sampling','Location','northwest');
hold off;
set(groot,'defaultAxesLineStyleOrder','remove')
set(groot,'defaultAxesColorOrder','remove')
