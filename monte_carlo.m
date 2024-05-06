clear
clc

digits(1000)

[S, n, k] = Node.import_system('test.xlsx');

iterations = 100000; 

disp("**Monte Carlo Simulation**")
tic;
R = monte_carlo_simulation(n, k, S, iterations)
disp("" + k + "-out-of-" + n)
disp("Elapsed time: " + toc + " s")