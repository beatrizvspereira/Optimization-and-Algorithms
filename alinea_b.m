function alinea_b(u,T)

 figure
    plot (0:T-2, u(1,:),'b', 0:T-2, u(2,:),'c')
    xlabel('t time')
    ylabel('u(t)')
    axis([0 80 -40 40]);
    title('Optimal control signal')
    legend('u1(t)','u2(t)')
    grid on

end

