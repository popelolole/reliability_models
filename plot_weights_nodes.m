[S, n, k] = Node.import_system('experiment.xlsx');

figure;

num_nodes = 5;

R = zeros(n);
for i = num_nodes:n
    R(i) = higashiyama(i, k, S(1:i));
end

subplot(3, 1, 1);
plot(num_nodes:n, R(num_nodes:n), 'o-');
xlabel('Number of Nodes');
ylabel('System Reliability');
title('Effect of Number of Nodes on System Reliability');

x = num_nodes:n;
y = R(num_nodes:n);

logarithmicModel = fittype('a*log(x) + b', 'coefficients', {'a', 'b'}, 'independent', 'x');
fitResult1 = fit(x', y', logarithmicModel);
disp(fitResult1);

R = zeros(n);
s = S(1:num_nodes);
R(num_nodes) = higashiyama(num_nodes, k, s);
for i = num_nodes + 1:n
    rand_int = randi([1,num_nodes]);
    s{rand_int}.weight = s{rand_int}.weight + 1;
    R(i) = higashiyama(num_nodes, k, s);
end

subplot(3, 1, 2);
plot(num_nodes:n, R(num_nodes:n), 'o-');
xlabel('Total Weight of Nodes');
ylabel('System Reliability');
title('Effect of Weights of Nodes on System Reliability');

x = num_nodes:n;
y = R(num_nodes:n);

fitResult2 = fit(x', y', logarithmicModel);
disp(fitResult2);

R = zeros(n);
s = S(1:num_nodes);
R(num_nodes) = higashiyama(num_nodes, k, s);
for i = num_nodes + 1:n
    rand_int = randi([1,num_nodes]);
    s{rand_int}.reliability = s{rand_int}.reliability + 0.1*s{rand_int}.reliability;
    R(i) = higashiyama(num_nodes, k, s);
end

subplot(3, 1, 3);
plot(num_nodes:n, R(num_nodes:n), 'o-');
xlabel('Node Reliability Additions');
ylabel('System Reliability');
title('Effect of Reliability of Nodes on System Reliability');

x = num_nodes:n;
y = R(num_nodes:n);

exponentialModel = fittype('a*exp(b*x) + c', 'coefficients', {'a', 'b', 'c'}, 'independent', 'x');
fitResult3 = fit(x', y', exponentialModel);
disp(fitResult3);