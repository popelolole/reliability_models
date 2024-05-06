clear
clc

digits(1000);

[S, n, k] = Node.import_system('test.xlsx');

W = zeros(n); 
R = zeros(n);

for i = 1:n
    W(i) = S{i}.weight;
    R(i) = S{i}.reliability;
end

combinations = zeros(2^n, n);

initial_combination = zeros(1, n);

tic;

combinations = brute_force_enumeration1(initial_combination, 1, 1, n, combinations);

system_reliability = system_rel(combinations,W,R, n, k)

disp("time elapsed: " + toc + " s");

%calculates system reliability
function system_prob = system_rel(combinations,W,R, n, k)
    system_prob = 0;
    for row = 1:2^n
        sum = 0;
        comb_prob = 1;
        for col = 1:n
            if combinations(row,col) == 1
                sum = sum + W(col);
            end
        end
        if sum >= k
            for col = 1:n
                if combinations(row,col) == 1
                    comb_prob = comb_prob * R(col);
                else
                    comb_prob = comb_prob * (1-R(col));
                end
            end
            system_prob = system_prob + comb_prob;
        end
    end
    system_prob = vpa(system_prob);
    return;
end

%finds all possible combinations
function combinations = brute_force_enumeration1(current_combination, component_index, row_index, n, combinations)
    if component_index > n
        combinations(row_index, :) = current_combination;
    else
        current_combination(component_index) = 1;
        combinations = brute_force_enumeration1(current_combination, component_index + 1, row_index, n, combinations);

        current_combination(component_index) = 0;
        combinations = brute_force_enumeration1(current_combination, component_index + 1, row_index + 2^(component_index-1), n, combinations);
    end
end
