A = {Node(1, 2, 0.6), Node(2, 6, 0.8), Node(3, 4, 0.7)};
B = {Node(1, 20, 0.5), Node(2, 17,0.6), Node(3, 15, 0.4), Node(4, 14, 0.8), Node(5, 12, 0.5), Node(6, 10, 0.4)};


oldDigits = digits(1000);

N = {};

for i = 1:100
    N{i} = Node(i, 4, 0.5);
end

disp(A)

R = higashiyama(3,8,A)
R = higashiyama(5, 30, B)
%R = higashiyama(100, 200, N)

%W = [1, 3, 2, 2, 5, 3, 7, 3, 10, 4]
%P = [1.0, 0.9, 0.8, 0.8, 0.7, 0.7, 0.6, 0.5, 0.5, 0.3]

%R = reliability(10, 12, W, P)


% A: array of Node instances
function [R] = higashiyama(n, k, A)
    M = construct_matrix(n, k, A);
    R = calculate_reliability(n, k, M, A);
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

    w = [];
    r = [];
    for i = 1:length(A)
        w(end + 1) = A{i}.weight;
        r(end + 1) = A{i}.reliability;
    end

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

