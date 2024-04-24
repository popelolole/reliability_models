A = [Node(2, 6, 0.8), Node(3, 4, 0.7), Node(1, 2, 0.6)];

R = mps(A,3,5)

function [R] = mps(A,n,k)
    S = find_minimal_path_sets(A,n,k);
    
    %%% just for display
    for i = 1:length(S)
        Z = S{i};
        disp("Set {")
        for j = 1:length(Z)
            z = Z{j};
            disp("x" + z.index + " - weight: " + z.weight + " - r: " + z.reliability)
        end
        disp("}")
    end
    %%%
        
    % which method is used here is optional
    R = sdp_method(S);
end

function [S] = find_minimal_path_sets(A,n,k)
    S = {};
    for i = 1:n
        if A(i).weight >= k
            S{end + 1} = {A(i)};
        else
            tot = A(i).weight;
            Sx = {A(i)};
            for j = i+1:n
                tot = tot + A(j).weight;
                Sx{end + 1} = A(j);
                if tot >= k
                    S{end + 1} = Sx;
                    Sx = Sx(1:end-1);
                    tot = tot - A(j).weight;
                end
            end
        end
    end
end

function [r] = sdp_method(S)
    r = 0;
    for i = 1:length(S)
        inner_expression = {};
        for j = 1:i - 1
            inner_expression = Node.union(inner_expression, ...
                Node.diff(S{j}, S{i}));
        end
        r = r + prob(S{i}) * (probC(inner_expression));
    end
end

function result = prob(s)
    result = 1;
    for i = 1:length(s)
        result = result * s{i}.reliability;
    end
end

function result = probC(s)
    result = 1;
    for i = 1:length(s)
        result = result * (1 - s{i}.reliability);
    end
end