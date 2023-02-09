% function calc_gf: compute gradient of f(y) and the values of fnm
%                   functions
% output variables: gf - vector with dimension k*N with the full gradient
%                        of f(y)
%                   fnm - vector with dimension (N*(N-1))/2 with the value
%                         for each function fnm(y)

function [gf, fnm] = calc_gf(y,gfnm,D,N,k)
fnm = zeros((N*(N-1))/2,1);
gf = zeros(1,k*N);
count=1;

    for m= 1:N
     for n = 1:(m-1)
            for i = 1:k
                vetm(i) = y(k*m+i-k);
                vetn(i) = y(k*n+i-k); 
            end
            norma_nm = norm(vetn-vetm);
            fnm(count,1)=(norma_nm - D(n,m));
            aux =(2.*fnm(count).*[gfnm(count,k*n+1-k:k*n)...
                  gfnm(count,k*m+1-k:k*m)]); 
            gf(1,k*n-k+1:k*n)=gf(1,k*n-k+1:k*n)+aux(1:k); % df/dyn
            gf(1,k*m-k+1:k*m)=gf(1,k*m-k+1:k*m)+aux(k+1:2*k); % df/dym
            count=count+1;
     end
    end
 
end