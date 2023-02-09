function alinea_a(x,w,tau,K)

figure
    p=plot (x(1,:), x(2,:), 'o')
    p.MarkerSize = 4;
    hold on
    for i=1:K
        p=plot (x(1,tau(i)), x(2,tau(i)), 'mo')
        p.MarkerSize = 10;
    end
   
    hold on 
    p=plot(w(1,:),w(2,:),'rs')
    p.MarkerSize = 10;
    grid on
    xlabel('X coordinate')
    ylabel('Y coordinate')
    xlim([0 35]); ylim([-15 15]);
    title('Optimal positions')

end

