clear
%clc

digits(1000);

[S, n, k] = Node.import_system('base1.xlsx');

S = Node.sortByWeight(S);
MPS = find_minimal_path_sets(S,n,k);
disp("Total num of mps: " + length(MPS));

s_length = zeros(10);
for i = 1:length(MPS)
    s_length(length(MPS{i})) = s_length(length(MPS{i})) + 1;
end

for i = 1:length(s_length)
    disp(i + ": " + s_length(i))
end
tic;
R = higashiyama(n, k, S)
disp("" + k + "-out-of-" + n)
disp("Elapsed time: " + toc + " s")