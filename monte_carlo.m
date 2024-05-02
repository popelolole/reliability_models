clear
clc

digits(1000)

[S, n, k] = Node.import_system('test.xlsx');

iterations = 10000000; 

disp("**Monte Carlo Simulation**")
tic;
R = monte_carlo_simulation(n, k, S, iterations)
disp("" + k + "-out-of-" + n)
disp("Elapsed time: " + toc + " s")

function result = monte_carlo_simulation(n,k,A,iterations)
    sys_up = 0;

    % Put weights and RIs in arrays for calculations in simulation loop, 
    % because it significantly(!) optimizes time complexity. 
    w = [];
    r = [];
    for i = 1:length(A)
        w(end + 1) = A{i}.weight;
        r(end + 1) = A{i}.reliability;
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
    disp(sys_up)
    result = vpa(sys_up/iterations);
end

