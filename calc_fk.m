% function calc_fk: computes the value of the function f(y)

function [fr] = calc_fk(y,D,N,k)
    f = 0;
    for m= 1:N
        for n = 1:(m-1)
            for i = 1:k
                vetm(i) = y(k*m+i-k);
                vetn(i) = y(k*n+i-k); 
            end
            f = f + (norm(vetm-vetn) - D(m,n)).^2;
        end
    end
    fr=f;
end


