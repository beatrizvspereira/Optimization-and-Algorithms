function [P] = grad(X, Y, epsilon, alpha_hat, gama, beta)
    s=-ones(1, size(X,1));
    r=0;
    K=size(X,2);       
    k=0;

    P=[s r];
    actual_x = [X;-ones(1,size(X,2))];
    g=ones(size(actual_x,1));

    G=[];

    tic()

    while norm(g) > epsilon
        g=(1/K)*(sum(actual_x.*(exp(P*actual_x)./(1+exp(P*actual_x))),2)- sum(actual_x.*Y,2));
        G=[G g];
        d=-g;
        alpha=alpha_hat;

        lr=log_regression(P,actual_x,Y);
        while log_regression(P+alpha*d',actual_x,Y)>lr+gama*g'*(alpha*d)
            alpha=beta*alpha;
        end
        P=P+alpha*d';
        k=k+1;

    end

    toc()


    figure
    for i=1:K
        if Y(i)==0
            plot(X(1,i), X(2,i), 'or', 'LineWidth',1)
        end
        if Y(i)==1
            plot(X(1,i), X(2,i), 'ob', 'LineWidth',1)
        end
        hold on
    end


    x1=-1.5:0.1:5.5;
    x2 = P(3)/P(2) -(P(1)/P(2))*x1;
    hold on 
    plot(x1,x2,'--g', 'LineWidth',1.5)
    xlabel('x_1')
    ylabel('x_2')
    ylim([-4 8])
    xlim([-4 8])



    figure
    for i=1:k
        plot(i, norm(G(:,i)), '.b')
        hold on
    end
    set(gca, 'YScale', 'log')
    grid('on')
    xlabel('k')
    ylabel('gradient norm')
    title('$$||\nabla f(s_k,r_k)||$$ (Gradient Method)', ...
          'fontsize',14,'interpreter','latex')

end

