% A: array of Node instances
function [R] = mps(A,n,k)
    tic;
    S = find_minimal_path_sets(A,n,k);
    elapsedTime = toc;

    s_length = zeros(10);

    %%% just for display
    for i = 1:length(S)
        Z = S{i};
        s_length(length(Z)) = s_length(length(Z)) + 1;
        disp("Set {")
        for j = 1:length(Z)
            z = Z{j};
            disp("x" + z.index + " - weight: " + z.weight + " - r: " + z.reliability)
        end
        disp("}")
    end

    disp("Total num of mps: " + length(S));

    for i = 1:length(s_length)
        disp(i + ": " + s_length(i))
    end
    %%%
        
    % At this point we have R = P(S{1} u S{2} u ... u S{n})
    % So reliability is calculated using some method, in this case sum of
    % disjoint products (sdp).
    
    disp("Elapsed time for finding mps algorithm: " + elapsedTime + " s")

    tic;
    R = sdp_method(S);
    disp("Elapsed time for sdp method: " + toc + " s")
end

function [r] = sdp_method(S)
     r = 0;
    for i = 1:length(S)
        inner_expression = {};
        for j = 1:i - 1
            inner_expression = Node.union(inner_expression, ...
                {Node.diff(S{j}, S{i})});
        end
        r = sym(r + prob(S{i}) * (probC(inner_expression)));
    end
    r = vpa(r);
end

function result = prob(s)
    result = 1;
    for i = 1:length(s)
        S = s{i};
        if isa(S, 'cell')
            for m = 1:length(S)
                result = sym(result * S{m}.reliability);
            end
        else
            result = sym(result * S.reliability);
        end
    end
end

function result = probC(s)
    result = 1;
    for i = 1:length(s)
        S = s{i};
        if isa(S, 'cell')
            p = 1;
            for m = 1:length(S)
                p = sym(p * S{m}.reliability);
            end
            result = sym(result * (1 - p));
        else
            result = sym(result * (1 - S.reliability));
        end
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