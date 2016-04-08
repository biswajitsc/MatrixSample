function Solve1(D, y, samples)
% Varies Lambda and plots a graph for both leverage score methods

[n, d] = size(D);

W1 = GetProb1(D) * samples;
[~, inds1] = sort(W1);
inds1 = inds1(n-samples+1:n);

Dd1 = [];
yy1 = [];

for i = inds1
    Dd1 = [Dd1; D(i,:)];
    yy1 = [yy1; y(i)];
end

[sz, ~] = size(Dd1);
fprintf('Type 1 Sample size: %d\n', sz);

pd1 = [];

for i = [-6:0]
    lam = 10^i;
    w1 = (Dd1'*Dd1 + lam * eye(d))^-1 * Dd1' *  yy1;
    out = D*w1 - y;
    err = sqrt(sum(out .* out)/n);
    pd1 = [pd1; i err];
end



W2 = GetProb2(D) * samples;
[~, inds2] = sort(W2);
inds2 = inds2(n-samples+1:n);
Dd2 = [];
yy2 = [];


for i = inds2
    Dd2 = [Dd2; D(i,:)];
    yy2 = [yy2; y(i)];
end

[sz, ~] = size(Dd2);
fprintf('Type 2 Sample size: %d\n', sz);

pd2 = [];

for i = [-6:0]
    lam = 10^i;
    w2 = (Dd2'*Dd2 + lam * eye(d))^-1 * Dd2' *  yy2;
    out = D*w2 - y;
    err = sqrt(sum(out .* out)/n);
    pd2 = [pd2; i err];
end

p1 = plot(pd1(:,1), pd1(:,2), 'ro-', 'DisplayName', 'Type1');
hold on
p2 = plot(pd2(:,1), pd2(:,2), 'bo-', 'DisplayName', 'Type2');
hold off
legend([p1 p2]);