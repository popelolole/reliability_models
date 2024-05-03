%% WORK IN PROGRESS %%

clc

A = {Node(2, 6, 0.8), Node(3, 4, 0.7), Node(1, 2, 0.6)};
B = {Node(1, 20, 0.5), Node(2, 17,0.6), Node(3, 15, 0.4), Node(4, 14, 0.8), Node(5, 12, 0.5), Node(6, 10, 0.4)};
% , Node(5, 12, 0.5), Node(6, 10, 0.4), Node(7, 7, 0.6), Node(8, 5, 0.8), Node(9, 3, 0.5), Node(10, 2, 0.3)
N = [Node(1, 2, 0.7)];

digits(1000);

[S, n, k] = Node.import_system('test.xlsx');

S = Node.sortByWeight(S);

%R = mps(A,3,5)
% r = mps(A, 3, 8);
r = mps(S, n, k)
%r = mps(B, 4, 30)