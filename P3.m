clear 
clc
load data_opt.csv
d_size = size(data_opt);

for i = 1: d_size(1)
    for j = i: d_size(1)
        D(i,j) = norm(data_opt(i,:)-data_opt(j,:));
        D(j,i) = D(i,j);
    end
end
save("D.mat","D");

%Verification
D(2,3);
D(4,5);

%Largest distance between datapoints
[M,I]=max(D(:));
[I_row, I_col] = ind2sub(size(D),I);

load yinit2.csv
load yinit3.csv

%% task 3 - init2

N = d_size(1);
k = 2;
[y,cost] = LM(yinit2,D,N,k,1e-2);

%Plot of the low dimension positions 
figure()
yplot = (reshape(y, [2 200]))';
plot(yplot(:,1),yplot(:,2),'.','MarkerSize',15);
axis([-32 32 -45 45])
grid on
%Plot of the cost function
figure()
semilogy(0:length(cost)-1,cost,'.-','MarkerSize',15)
title('Cost function')
grid on

%% task 3 - init3

N = d_size(1);
k = 3;
[y,cost] = LM(yinit3,D,N,k,1e-2);


figure()
yplot = (reshape(y, [3 200]))';
plot3(yplot(:,1),yplot(:,2),yplot(:,3),'.','MarkerSize',15);
grid on
%axis equal

figure()
semilogy(0:length(cost)-1,cost,'.-','MarkerSize',15)
grid on

%% task 4 
clear
clc

load dataProj.csv
d_size = size(dataProj);


for i = 1: d_size(1)
    for j = i: d_size(1)
        D(i,j) = norm(dataProj(i,:)-dataProj(j,:));
        D(j,i) = D(i,j);
    end
end

%%  task 4 - init
close all

k = 2;
N = d_size(1);


for i = 1:3
    
    yinit4 = 1000*rand([k*N,1])-500;
    [y,cost] = LM(yinit4,D,N,k,1e-4);

    figure(2)
    yplot = (reshape(y, [2 N]))';
    plot(yplot(:,1),yplot(:,2),'.','MarkerSize',15);
    axis equal
    hold on
   
    figure(1)
    semilogy(0:length(cost)-1,cost,'.-','MarkerSize',15);
    hold on
end