W = [0.8, 2.5, 1.8, 1.4, 1.7, 1.5, 2.4, 3, 2.7, 3.4];

RI = [1.0, 0.9, 0.8, 0.8, 0.7, 0.7, 0.6, 0.5, 0.5, 0.3];

k = 12;

n = 10;

system_reliability = uncertain_algorithm(W, RI, k, n)

function result = uncertain_algorithm(W, RI, k, n)
    for j = 1:n
        sum = 0;
        for i = 1:n
            sum = sum + W(i) * theorem2(RI(j),RI(i));
        end
        if sum >= k
            result = RI(j);
            return;
        end
    end
end

function result = theorem2(RIj, RIi)
    if RIj <= RIi
        result = 1;
    else
        result = 0;
    end
end

