clc;
clear;

[S, n, k] = Node.import_system('base1.xlsx');

figure(1);

work = 15;
cost_of_decrease_k = 2;

R1 = zeros(work + 1, 1);
s = S;
R1(1) = higashiyama(n, k, s);
for i = n + 1:n+work
    s{end + 1} = Node(i, 1, 0.7);
    R1(i-n + 1) = higashiyama(i, k, s);
end

figure(1)
plot(0:work, R1, 'b');
xlabel('Cost of Work');
ylabel('System Reliability');
title('Effect of Number of Nodes on System Reliability');

R2 = zeros(work + 1, 1);
s = S;
R2(1) = R1(1);
for i = 2:work + 1
    rand_int = 1;
    %rand_int = randi([1,n]);
    s{rand_int}.weight = s{rand_int}.weight + 1;
    R2(i) = higashiyama(n, k, s);
end

figure(2)
plot(0:work, R2, 'r');
xlabel('Weights added');
ylabel('System Reliability');
title('Effect of Weights of Nodes on System Reliability');

R3 = zeros(work + 1, 1);
new_k = k;
R3(1) = R1(1);
for i = 2:work + 1
    if mod(i, cost_of_decrease_k) ==  0 
        if new_k ~= 1
            new_k = new_k - 1;
        end
    end
    R3(i) = higashiyama(n, new_k, S);
end

figure(3)
plot(0:work, R3, 'g');
xlabel('Cost of Work');
ylabel('System Reliability');
title('Effect of Decrease of k on System Reliability');

R4 = zeros(work + 1, 1);
s = S;
R4(1) = R1(1);
%m = 2;
for i = 2:work + 1
    %rand_int = 1;

    rand_int = randi([1,n]);

    %s{rand_int}.reliability = s{rand_int}.reliability + 1/2*(1/s{rand_int}.weight)*(1-s{rand_int}.reliability);
    
    %s1 = s;
    %s1{rand_int}.reliability = s1{rand_int}.reliability + 0.1*(1-s1{rand_int}.reliability);
    %r1 = higashiyama(n, k, s1);
    %s2 = s;
    %s2{m}.reliability = s2{m}.reliability + 0.1*(1-s2{m}.reliability);
    %r2 = higashiyama(n, k, s2);
    %if r2 > r1
    %    rand_int = m;
    %    m = m + 1;
    %end
    
    s{rand_int}.reliability = s{rand_int}.reliability + 0.1*(1-s{rand_int}.reliability);
    R4(i) = higashiyama(n, k, s);
end

figure(4)
plot(0:work, R4, 'y');
xlabel('Cost of Work');
ylabel('System Reliability');
title('Effect of Reliability of Nodes on System Reliability');

figure(5);
plot(0:work, R1, 'b');
hold on
plot(0:work, R2, 'r');
plot(0:work, R3, 'g');
plot(0:work, R4, 'y');
hold off
xlabel('Cost of Work');
ylabel('System Reliability');
title('Reliability-per-work');
legend('Adding Nodes', 'Adding Weight', 'Decreasing k', 'Increasing RI')

