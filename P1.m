clc
clear
close all

%% Data - fist parte

A=[1 0 0.1 0; 0 1 0 0.1; 0 0 0.9 0; 0 0 0 0.9];
B=[0 0; 0 0; 0.1 0; 0 0.1];

E=[1 0 0 0; 0 1 0 0];
T=80+1;
pinitial=[0; 5];
pfinal=[15; -15];
K=6;
w=[10 20 30 30 20 10; 10 10 10 0 0 -10];
tau=[10 25 30 40 50 60]+1;
Umax=100;
lambda=[10^-3 10^-2 10^-1 10^0 10 10^2 10^3];


%% Task 1 

clearvars x u

cvx_begin quiet 
    variable x(4,T); 
    variable u(2,T-1);
    F1=0;
    F2=0;
    
    for i=1:6
        F1= F1 + square_pos(norm(x(1:2,tau(i))-w(:,i)));
    end
    
    for t=2:T-1
        F2 = F2 + square_pos(norm(u(:,t)-u(:,t-1)));
    end
    
    minimize(F1 + lambda(7)*F2)
    
    subject to
        x(:,1) == [pinitial; 0; 0];
        x(:,T) == [pfinal; 0; 0];
        
        for i=1:T-1
            norm(u(:,i))<=Umax;
        end
        
        for j=1:T-1
            x(:,j+1)==A*x(:,j) + B*u(:,j);
        end
       
cvx_end


%% Task 2

clearvars x u 

cvx_begin quiet 
    variable x(4,T); 
    variable u(2,T-1);
    F1=0;
    F2=0;
    
    for i=1:6
        F1= F1 + square_pos(norm(x(1:2,tau(i))-w(:,i)));
    end
    
    for t=2:T-1
        F2 = F2 + norm(u(:,t)-u(:,t-1));
    end
    
    minimize(F1 + lambda(7)*F2)
    
    subject to
        x(:,1) == [pinitial; 0; 0];
        x(:,T) == [pfinal; 0; 0];
        
        for i=1:T-1
            norm(u(:,i))<=Umax;
        end
        
        for j=1:T-1
            x(:,j+1)==A*x(:,j) + B*u(:,j);
        end
       
cvx_end


%% Task 3

clearvars x u

cvx_begin quiet 
    variable x(4,T); 
    variable u(2,T-1);
    F1=0;
    F2=0;
    
    for i=1:6
        F1= F1 + square_pos(norm(x(1:2,tau(i))-w(:,i)));
    end
    
    for t=2:T-1
        F2 = F2 + norm(u(:,t)-u(:,t-1),1);
    end
    
    minimize(F1 + lambda(1)*F2)
    
    subject to
        x(:,1) == [pinitial; 0; 0];
        x(:,T) == [pfinal; 0; 0];
        
        for i=1:T-1
            norm(u(:,i))<=Umax;
        end
        
        for j=1:T-1
            x(:,j+1)==A*x(:,j) + B*u(:,j);
        end
       
cvx_end

%% (a)

alinea_a(x,w,tau,K);

%% (b)
    
alinea_b(u,T);
    
%% (c)

count=alinea_c(u,T);

%% (d)

m_dev = alinea_d(x, w, K, tau);

%% Data - second parte 

K=5;

k=[1 2 3 4 5];

t_k=[0 10 15 30 45]+1;

c_k=[0.6332 -0.0054 2.3322 4.4526 6.1752; -3.2012 -1.7104 -0.7620 3.1001 4.2391];

R_k=[2.2727 0.7281 1.3851 1.8191 1.0895];

xx=[6; 10];

tx=81;

V=zeros(2,81);

%% 2.2 Distance from a critical point

cvx_begin quiet 
variable p0(2,1)
variable v(2,1)
F1=0;
F2=0;

for t=0:80
    p(1,t+1)=p0(1)+(t*v(1))/10;
    p(2,t+1)=p0(2)+(t*v(2))/10;
end

F1=norm(xx-p(:,tx));

minimize(F1)

subject to
    for i=1:K
        norm(p(:,t_k(i))-c_k(:,i)) <= R_k(i);
    end

cvx_end

d=norm(xx-p(:,tx));

%% 2.2 Distance from a critical point - Plot

figure;
 axis([-6 12 -6 12])
 axis square
 viscircles(c_k',R_k,'Color','b');
 
 hold on;
 
 for i=1:K
 a=plot(p(1,t_k(i)),p(2,t_k(i)),'rs','LineWidth',1.5)
 a.MarkerSize = 10;
 hold on; 
 text(c_k(1,i),c_k(2,i),num2str(i), 'HorizontalAlignment','center', 'VerticalAlignment','middle')
 end
 
 a=plot(p(1,tx),p(2,tx),'rs','LineWidth',1.5);
 a.MarkerSize = 10;
 
 plot(xx(1),xx(2),'k.','MarkerSize',20);
 text(xx(1),xx(2),'x*','HorizontalAlignment','left', 'VerticalAlignment','top')
 
%% 2.3 Smallest enclosing rectangle

% procura x menor (esquerda)
clearvars p0 v p

cvx_begin quiet 
variable p0(2,1)
variable v(2,1)


for t=0:80
    p(1,t+1)=p0(1)+(t*v(1))/10;
    p(2,t+1)=p0(2)+(t*v(2))/10;
end

minimize(p(1,tx))

subject to
    for i=1:K
        norm(p(:,t_k(i))-c_k(:,i)) <= R_k(i);
    end
 
cvx_end

a_1=p(1,tx);

% procura x maior (direita)
clearvars p0 v p
cvx_begin quiet 
variable p0(2,1)
variable v(2,1)


for t=0:80
    p(1,t+1)=p0(1)+(t*v(1))/10;
    p(2,t+1)=p0(2)+(t*v(2))/10;
end

maximize(p(1,tx))

subject to
    for i=1:K
        norm(p(:,t_k(i))-c_k(:,i)) <= R_k(i);
    end

cvx_end

a_2=p(1,tx);

% procura y menor (para baixo)
clearvars p0 v p
cvx_begin quiet 
variable p0(2,1)
variable v(2,1)


for t=0:80
    p(1,t+1)=p0(1)+(t*v(1))/10;
    p(2,t+1)=p0(2)+(t*v(2))/10;
end

minimize(p(2,tx))

subject to
    for i=1:K
        norm(p(:,t_k(i))-c_k(:,i)) <= R_k(i);
    end

cvx_end

b_1=p(2,tx);

% procura y maior (para cima)
clearvars p0 v p
cvx_begin quiet 
variable p0(2,1)
variable v(2,1)

for t=0:80
    p(1,t+1)=p0(1)+(t*v(1))/10;
    p(2,t+1)=p0(2)+(t*v(2))/10;
end

maximize(p(2,tx))

subject to
    for i=1:K
        norm(p(:,t_k(i))-c_k(:,i)) <= R_k(i);
    end

cvx_end

b_2=p(2,tx);

%% 2.3 Smallest enclosing rectangle - plot
figure();
 axis([-6 15 -6 15])
  set(gca,'XTick',[-5:5:15])
  set(gca,'YTick',[-5:5:15])
 axis square
 viscircles(c_k',R_k,'Color','b');
 hold on;
 
 for i=1:K
 text(c_k(1,i),c_k(2,i),num2str(i), 'HorizontalAlignment',...
     'center', 'VerticalAlignment','middle')
 end

 rectangle('Position',[a_1 b_1 a_2-a_1 b_2-b_1],'EdgeColor','r');
