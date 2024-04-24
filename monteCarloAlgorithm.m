clear
clc

W = [2,6,4];

RI = [0.6,0.8,0.7];

k = 5;

n = 3;

j = 100000; 

r = monteCarlo_algorithm(W,RI,k,n,j)

function result = monteCarlo_algorithm(W,RI,k,n,j)
    up = 0;
    down = 0;
    for i = 1:j
        sum = 0;
        for a = 1:n
            randNum = rand();
            if randNum <= RI(a)
                sum = sum + W(a);
            end
        end
        if sum < k
            down = down + 1;
        else
            up = up + 1;
        end
    end
    f = down/up
    result = up/j
    d = down
    u = up
end
