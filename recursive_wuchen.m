%Weights = [2, 6, 4];
%P = [0.6, 0.8, 0.7];
%Reliability = reliability(3, 5, Weights, P)

% M matrix, n & k integers, W array of weights
function [M] = higashiyama(n, k, W)
    M = zeros(n, k);
    M(n-1, k) = 1;
    M(n, k) = 1;
    if k - W(n) > 0
        M(n-1, k-W(n)) = 1;
    end
    for i = n-1:-1:2
        for j = 1:k
            if M(i, j) == 1
                M(i-1, j) = 1;
                if j - W(i) > 0
                    M(i-1, j-W(i)) = 1;
                end
            end
        end
    end
    return
end

% P = array of reliability index for each node
function [r] = wu_chen(n, k, M, W, P)
    R = ones(n + 1, k + 1);
    R(:, 2:end) = 0;
    for i = 2:n+1
        for j = 2:k+1
            if M(i-1, j-1) == 1
                if j - W(i-1) <= 1
                    R(i, j) = P(i-1) + (1 - P(i-1)) * R(i - 1, j);
                else
                    R(i, j) = (P(i-1) * R(i-1, j-W(i-1)) ...
                                + (1-P(i-1)) * R(i-1, j));
                end
            end
        end
    end
    r = R(n+1, k+1);
    return
end

function [r] = reliability(n, k, W, P)
    M = higashiyama(n, k, W);
    r = wu_chen(n, k, M, W, P);
end