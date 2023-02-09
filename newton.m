function [P] = newton(X,Y,epsilon,a,gamma,beta,Maxiterations)
    s = -ones(1,size(X,1))';    %Matrix given
    r =0;                       %Constant given 
    P=[s; r];                   %contructed matrix
    n_vec = zeros(1,Maxiterations); %norm vector
    aks_vec = zeros(1,Maxiterations); %stepsizes vector
    K = length(Y);
    A = [X; -ones(1, K)];
    G=[];

    tic() %start timer
    %The algo referenced in slide 81
    for k = 1:Maxiterations

        v = exp(A'*P)./(1 + exp(A'*P)) - Y';
        g = 1/K * (A*v);
        G = [G g];

        n_vec(k) = norm(g);
        if ( norm(g) <= epsilon )
            break;
        end

        D = 1/K * diag(exp(A'*P)./((1+exp(A'*P)).^2));
        hessian = A*D*A';
        d = -inv(hessian)*g;

        ak = a;
        while(1)
            if( backtrack(P + ak*d , X , Y) < backtrack(P, X, Y) + gamma * g * (ak*d)' )
                break;
            end
            ak = beta * ak;
        end

        aks_vec(k) = ak;
        P = P + ak*d;

    end

    toc() %end timer


    % Auxiliar method to print ak in standard form
    n=1;
    ak_print= zeros(1,k-1);
    while(n~=k)
    ak_print(n)=aks_vec(n);
    n=n+1;
    end

    figure
    for i=1:k
    nG(i)=norm(G(:,i));
    hold on
    end
    plot(1:k, nG(1:k),'LineWidth',1.5);
    set(gca, 'YScale', 'log')
    grid('on')
    xlabel('k')
    ylabel('gradient norm')
    title('$$|| \nabla f(s_k,r_k) ||$$ (Newton Method)', ...
          'fontsize',14,'interpreter','latex')
    xlim([1 k]);

    figure
    stem(1:k-1,ak_print,'filled','LineWidth',1.5);
    xlabel('k')
    title('\alpha_k (Newton method)')
end

