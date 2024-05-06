clear
%clc

digits(1000);

[S, n, k] = Node.import_system('test.xlsx');

tic;
R = higashiyama(n, k, S)
disp("" + k + "-out-of-" + n)
disp("Elapsed time: " + toc + " s")