% A: array of Node instances
function [R] = higashiyama(n, k, A)
    M = construct_matrix(n, k, A);
    R = calculate_reliability(n, k, M, A);
    %R_op = calculate_reliability_op(n, k, M, A)
end

% Generates matrix of 1's and 0's indicating if reliability for the
% position (cell) R(i,j) is needed to calculate R(n,k).
function [M] = construct_matrix(n, k, A)
    M = zeros(n, k);
    M(n-1, k) = 1;
    M(n, k) = 1;
    if k - A{n}.weight > 0
        M(n-1, k-A{n}.weight) = 1;
    end
    for i = n-1:-1:2
        for j = 1:k
            if M(i, j) == 1
                M(i-1, j) = 1;
                if j - A{i}.weight > 0
                    M(i-1, j-A{i}.weight) = 1;
                end
            end
        end
    end
    return
end

function [r] = calculate_reliability(n, k, M, A)
    R = ones(n + 1, k + 1);
    R(:, 2:end) = 0;

    for i = 2:n+1
        for j = 2:k+1
            if M(i-1, j-1) == 1
                if j - A{i-1}.weight <= 1
                    R(i, j) = sym(A{i-1}.reliability + ...
                        (1 - A{i-1}.reliability) * R(i - 1, j));
                else
                    R(i, j) = sym(A{i-1}.reliability * ...
                        R(i-1, j-A{i-1}.weight) + ...
                        (1 - A{i-1}.reliability) * R(i-1, j));
                end
            end
        end
    end
    r = vpa(R(n+1, k+1));
    return
end

% optimized version
function [r] = calculate_reliability_op(n, k, M, A)
    R = ones(n + 1, k + 1);
    R(:, 2:end) = 0;

    w = [];
    r = [];
    for i = 1:length(A)
        w(end + 1) = A{i}.weight;
        r(end + 1) = A{i}.reliability;
    end

    for i = 2:n+1
        for j = 2:k+1
            if M(i-1, j-1) == 1
                if j - w(i-1) <= 1
                    R(i, j) = sym(r(i-1) + ...
                        (1 - r(i-1)) * R(i - 1, j));
                else
                    R(i, j) = sym(r(i-1) * ...
                        R(i-1, j-w(i-1)) + ...
                        (1 - r(i-1)) * R(i-1, j));
                end
            end
        end
    end
    r = vpa(R(n+1, k+1));
    return
end