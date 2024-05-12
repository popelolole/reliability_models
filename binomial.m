clear
%clc

digits(1000);

[S, n, k] = Node.import_system('base1.xlsx');

% Binomial distribution works for k-out-of-n systems with statistically
% identical nodes

sum = 0;
for i = k:n
    C = nchoosek(n, i);
    sum = sym(sum) + C * S{1}.reliability^i * (1 - S{1}.reliability)^(n-i);
end

R = vpa(sum)
disp("" + k + "-out-of-" + n)