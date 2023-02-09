% function LM: application of the LM method 
% input variables: yk - initial y
%                   D - distance matrix
%                   N - number of datapoints
%                   k - target space dimensionality
%                   e - parameter epsilon of LM method
% output variables: y - vector with the estimates of the low dimension 
%                       positions
%                   cost - vector with the value of the cost along
%                          iterations
%                   gf_norm - vector with the norm of the gradient of the 
%                             cost function along iterations

function [y,cost,gf_norm] = LM(yk,D,N,k,e)
    
    I = eye(k*N);
    lambda = 1;
    eps = e*k;
    
    gfnm = calc_gfnm(yk,N,k);
    fk = calc_fk(yk,D,N,k);
    [gf, fnm] = calc_gf(yk,gfnm,D,N,k);
    count = 1;

    
    while (norm(gf) > eps)

        A = vertcat(gfnm,sqrt(lambda).*I);
        b = vertcat(((gfnm*yk)-fnm),sqrt(lambda).*yk);
        
        yktest =(A'*A)\(A'*b);

        if calc_fk(yktest,D,N,k) < fk
            yk = yktest;
            lambda = 0.7 * lambda;
            
            gfnm = calc_gfnm(yk,N,k);
            fk = calc_fk(yk,D,N,k);
            [gf, fnm] = calc_gf(yk,gfnm,D,N,k);
            cost(count) = fk;
            gf_norm(count)=norm(gf);
            count = count + 1;           
        else
            lambda =  2 * lambda;
        end
        
    end
    
    y = yk;
end

