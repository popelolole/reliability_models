function brute_force_enumeration()
    clear
    clc
    W = [222,632,412,532,222,222,262,242,252,222,222,262,242,522,222,222,622,422,522,222,555,888];

    RI = [0.6,0.8,0.7,0.6,0.8,0.7,0.5,0.4,0.9,0.2,0.6,0.8,0.7,0.6,0.8,0.7,0.5,0.4,0.9,0.2,0.5,0.8];

    n = 22; %22 klar på ca 50s
    k = 1500;

    combinations = zeros(2^n, n);

    initial_combination = zeros(1, n);

    brute_force_enumeration(initial_combination, 1, 1);

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
                    comb_prob = comb_prob * RI(col);
                else
                    comb_prob = comb_prob * (1-RI(col));
                end
            end
            system_prob = system_prob + comb_prob;
        end
    end
    system_reliability = system_prob

    function brute_force_enumeration(current_combination, component_index, row_index)
        if component_index > n
            combinations(row_index, :) = current_combination;
        else
            current_combination(component_index) = 1;
            brute_force_enumeration(current_combination, component_index + 1, row_index);

            current_combination(component_index) = 0;
            brute_force_enumeration(current_combination, component_index + 1, row_index + 2^(component_index-1));
        end
    end
end
