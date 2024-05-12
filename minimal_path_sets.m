%% WORK IN PROGRESS %%

clc

A = {Node(2, 6, 0.8), Node(3, 4, 0.7), Node(1, 2, 0.6)};
B = {Node(1, 20, 0.5), Node(2, 17,0.6), Node(3, 15, 0.4), Node(4, 14, 0.8), Node(5, 12, 0.5), Node(6, 10, 0.4)};
% , Node(5, 12, 0.5), Node(6, 10, 0.4), Node(7, 7, 0.6), Node(8, 5, 0.8), Node(9, 3, 0.5), Node(10, 2, 0.3)
N = [Node(1, 2, 0.7)];

digits(1000);

[S, n, k] = Node.import_system('base2.xlsx');

S = Node.sortByWeight(S);

%R = mps(A,3,5)
% r = mps(A, 3, 8);
tic;
r = mps(S, n, k)
%MPS = find_minimal_path_sets(S,n,k);
elapsedTime = toc;

%disp("Total num of mps: " + length(MPS));

%s_length = zeros(10);
%for i = 1:length(MPS)
%    s_length(length(MPS{i})) = s_length(length(MPS{i})) + 1;
%end

%for i = 1:length(s_length)
%    disp(i + ": " + s_length(i))
%end

disp("Elapsed time: " + elapsedTime + " s")

%r = mps(B, 4, 30)