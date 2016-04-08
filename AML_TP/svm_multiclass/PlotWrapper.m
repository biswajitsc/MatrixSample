function [] = PlotWrapper()
    % M = ['N', 'D', 'K', 'v', 'rho', 't', 'rper', 'batch'];
    for vper = [1.0:0.2:1.0]
        for N = [300:100:400]
            for D = [400:200:1000]
                K = 2;
                v = ceil(vper * D);
                pho = 0.7;
                t = 128;
                rper = 0.8;
                batch = 20;
                str = sprintf('N = %d   D = %d   vper = %d', N, D, vper);
                disp(str);
                [E, R] = experiments('dense', N, D, K, v, pho, t, rper, batch);
                dim = size(E);
                n = dim(1);
                M = [N, D, K, v, pho, t, rper, batch, myreshape(E), myreshape(R)];
                disp(myreshape(E));
                disp(myreshape(R));
                dlmwrite('Experiments_Data_BinarySVM.csv',M,'delimiter',',','-append');
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