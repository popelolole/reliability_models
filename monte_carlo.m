clear
clc

A = [Node(1, 2, 0.6), Node(2, 6, 0.8), Node(3, 4, 0.7)];

iterations = 100000000; 

r = monte_carlo_simulation(3, 5, A, iterations)

function result = monte_carlo_simulation(n,k,A,iterations)
    sys_up = 0;

    % Put weights and RIs in arrays for calculations in simulation loop, 
    % because it significantly(!) optimizes time complexity. 
    w = [];
    r = [];
    for i = 1:length(A)
        w(end + 1) = A(i).weight;
        r(end + 1) = A(i).reliability;
    end

    for i = 1:iterations
        sum = 0;
        for j = 1:n
            rand_num = rand();
            if rand_num <= r(j)
                sum = sum + w(j);
            end
        end
        if sum >= k
            sys_up = sys_up + 1;
        end
    end
    result = sys_up/iterations;
end