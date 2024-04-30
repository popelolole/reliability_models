clear
clc

A = [Node(1, 2, 0.6), Node(2, 6, 0.8), Node(3, 4, 0.7)];
B = [Node(1, 20, 0.5), Node(2, 17,0.6), Node(3, 15, 0.4), Node(4, 14, 0.8), Node(5, 12, 0.5), Node(6, 10, 0.4)];

digits(1000)

N = [Node(1, 2, 0.7)];
S = [struct('index', 1, 'weight', 2, 'reliability', 0.7)];

for i = 1:10
    N(i) = Node(i, 8, 0.5);
end

iterations = 10000000; 

%r = monte_carlo_simulation(3, 5, A, iterations)
%r = monte_carlo_simulation(5, 30, B, iterations)
R = monte_carlo_simulation(10, 20, S, iterations)
%R = monte_carlo_simulation(100, 200, N, iterations)

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
    disp(sys_up)
    result = vpa(sys_up/iterations);
end