%% Algorithm for plotting base2system %%

clear
clc

digits(1000);

[S, n, k] = Node.import_system('base2.xlsx');
tic;

[R,nrOfTimes] = base2SystemReliability(S,n,k,50) %50 iterationer tar ca 2150 vilket är mkt men för illustrering.
R_numeric = [];
nrOfTimes_numeric = [];

for i = 1:numel(R)  %convert from cell to numeric array for plotting.
    R_numeric(i) = R{i};
end

for i = 1:numel(nrOfTimes)  %convert from cell to numeric array for plotting.
    nrOfTimes_numeric(i) = nrOfTimes{i};
end

figure(1);
plot(1:numel(R_numeric), R_numeric, '-o');

xlabel('Number of Iterations');
ylabel('System Reliability');   
title('System Reliability for Base2');

figure(2);
bar(nrOfTimes_numeric);

xlabel('Nodes');
ylabel('Weight added');
title('Amount of times a weight is added');

disp("" + k + "-out-of-" + n)
disp("Elapsed time: " + toc + " s")

function [reliabilityGraph, nrOfTimes] = base2SystemReliability(S, n, k, iter)
    reliability = {};
    reliabilityGraph = {higashiyama(n,k,S)};
    nrOfTimes = cell(1, n);
    for i = 1:numel(nrOfTimes)
        nrOfTimes{i} = 0;
    end

    for i=2:iter+1 %add desired nrOfIterations
        for m=1:n 
            S{m}.weight = S{m}.weight + 1;
            reliability{m} = higashiyama(n,k,S);
            S{m}.weight = S{m}.weight - 1;
        end
        
        Stemp = S;
        newNode = Node(S{end}.index+1,1,S{1}.reliability); %new node with weight 1.
        Stemp{end + 1} = newNode;
        newNodeSysRel = higashiyama(n+1,k,Stemp);
        
        %find index for the best reliability
        maxReliability = max(cellfun(@max,reliability));
        for a=1:n 
            if(reliability{a}==maxReliability)
                maxIndex = a;
                break;
            end
        end
        if(newNodeSysRel>=reliability{maxIndex}) %check if new node is better
            S{end+1} = newNode;
            nrOfTimes{end+1} = 1;
            n = n + 1;
            reliabilityGraph{i} = newNodeSysRel;
        else                                    %or not
            nrOfTimes{maxIndex} = nrOfTimes{maxIndex} + 1;  
            reliabilityGraph{i} = reliability{maxIndex};
            S{maxIndex}.weight = S{maxIndex}.weight + 1;
        end
        T = nrOfTimes
    end
end