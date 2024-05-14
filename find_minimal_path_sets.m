function [S] = find_minimal_path_sets(A,n,k)
    
    current_path = {};
    minimal_paths = {};

    S = backtrack(A, current_path, minimal_paths, 0, 0);

    function minimal_paths = backtrack(A, current_path, minimal_paths, ...
            tot, index)
        if tot >= k
            minimal_paths{end + 1} = current_path;
            return;
        elseif index > n
            return;
        end

        index = index + 1;
        for i = index:n
            current_path{end + 1} = A{i};
            tot = tot + A{i}.weight;
            minimal_paths = backtrack(A, current_path, minimal_paths, ...
                tot, i);
            tot = tot - A{i}.weight;
            current_path = current_path(1:end-1);
        end
    end
end