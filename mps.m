% A: array of Node instances
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
        
    % At this point we have R = P(S{1} u S{2} u ... u S{n})
    % So reliability is calculated using some method, in this case sum of
    % disjoint products (sdp).

    R = sdp_method(S);
end

function [S] = find_minimal_path_sets(A,n,k)
    S = {};
    for i = 1:n
        if A{i}.weight >= k
            S{end + 1} = A(i);
        else
            tot = A{i}.weight;
            Sx = A(i);
            for j = i+1:n
                tot = tot + A{j}.weight;
                Sx{end + 1} = A{j};
                if tot >= k
                    S{end + 1} = Sx;
                    Sx = Sx(1:end-1);
                    tot = tot - A{j}.weight;
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
        r = sym(r + prob(S{i}) * (probC(inner_expression)));
    end
    r = vpa(r);
end

function result = prob(s)
    result = 1;
    for i = 1:length(s)
        result = sym(result * s{i}.reliability);
    end
end

function result = probC(s)
    result = 1;
    for i = 1:length(s)
        result = sym(result * (1 - s{i}.reliability));
    end
    
    %result = 1;
    %for i = 1:length(s)
    %    S = s{i}
    %    p = 1;
    %    for j = 1:length(S)
    %        S(j)
    %        p = p * S(j).reliability;
    %    end
    %    result = result * (1 - p);
    %end
end