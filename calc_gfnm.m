% function gfnm: returns a matrix of dimension (N*(N-1))/2 x (k*N) 
% with each of the gradients of the fnm(y) functions.

function gfnm = calc_gfnm(y,N,k)
    % number of lines correponds to the total number of fnm functions and 
    % number of columns corresponds to the dimension of each gradient
    gfnm = zeros((N*(N-1))/2,k*N); 
    count=1;
    for m= 1:N
        for n = 1:(m-1)
            for i = 1:k
                vetm(i) = y(k*m+i-k);
                vetn(i) = y(k*n+i-k); 
            end
            norma_nm = norm(vetn-vetm);
            aux = (vetm-vetn)./norma_nm; 
            for i = 1:k
                gfnm(count,k*m+i-k) = aux(i); % dfnm/dm 
                gfnm(count,k*n+i-k) = - aux(i); % dfnm/dn
            end
            count=count+1;
        end
    end
end