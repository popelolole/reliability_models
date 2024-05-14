clc;
clear;

S = {Node(1, 1, 0.7), Node(2, 1, 0.7), Node(3, 1, 0.7)};

weights_to_distribute = 9;
k = 6;

R = [];
O = {};
MPS = {};

x = 0;
for i = 0:weights_to_distribute
    for j = 0:weights_to_distribute
        for m = 0:weights_to_distribute
            if i + j + m == weights_to_distribute
                x = x + 1;
                s = S;
                s{1}.weight = s{1}.weight + m;
                s{2}.weight = s{2}.weight + j;
                s{3}.weight = s{3}.weight + i;
                R(end + 1) = higashiyama(3, k, s);
                sx = Node.sortByWeight(s);
                MPS{end + 1} = find_minimal_path_sets(sx, 3, k);
                O{end + 1} = {i, j, m};
            end
        end
    end
end

for j = 1:length(MPS)
    disp("Index " + j + ": ")
    disp("Total num of mps: " + length(MPS{j}));
    mps = MPS{j};
    s_length = zeros(3);
    for i = 1:length(mps)
        s_length(length(mps{i})) = s_length(length(mps{i})) + 1;
    end
    
    for i = 1:length(s_length)
        disp(i + ": " + s_length(i))
    end
end

disp(R);
maxValue = max(R);
maxIndices = find(R == maxValue);
disp("Best combinations: {")
for i = 1:length(maxIndices)
    disp("Index " + maxIndices(i) + ": ")
    disp(O{maxIndices(i)})
end
disp("}");
disp("with " + length(maxIndices) + " best combinations")

for a = 1:length(maxIndices)
    j = maxIndices(a);
    disp("Index " + j + ": ")
    disp("Total num of mps: " + length(MPS{j}));
    mps = MPS{j};
    s_length = zeros(3);
    for i = 1:length(mps)
        s_length(length(mps{i})) = s_length(length(mps{i})) + 1;
    end
    
    for i = 1:length(s_length)
        disp(i + ": " + s_length(i))
    end
end
