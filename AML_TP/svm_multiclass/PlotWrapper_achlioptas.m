function [] = PlotWrapper_achlioptas()
    % M = ['N', 'D', 'K', 'v', 'rho', 't', 'rper', 'batch'];
    for rper = [0.8:0.1:0.8]
        for N = [200]
            for D = [1000]
                K = 5;
                v = D;
                pho = 0.7;
                t = 128;
                batch = 10;
                str = sprintf('N = %d   D = %d   v = %d', N, D, v);
                disp(str);
                [E, R] = experiments_achlioptas('dense', N, D, K, v, pho, t, rper, batch);
                dim = size(E);
                n = dim(1);
                M = [N, D, K, rper, myreshape(E), myreshape(R)];
%                 M = [N, D, K, v, pho, t, rper, batch, myreshape(E), myreshape(R)];
                disp(myreshape(E));
                disp(myreshape(R));
                dlmwrite('Experiments_Data_StructSVM_Achlioptas_Train_New.csv',M,'delimiter',',','-append');
%                 break
            end
%             break
        end
%         break
    end
end

function Y = myreshape(X)
    dim = size(X);
    Y = reshape(X', [1, dim(1)*dim(2)]);
end