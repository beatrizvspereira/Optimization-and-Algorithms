clc
clear 
close all

%% Gradient method Parameters

epsilon=10^-6;              %Constant given
alpha_hat=1;                %Constant given
gama=10^-4;                 %Constant given
beta=0.5;                   %Constant given

%% Task 2

load ('data1.mat');
[P_G1] = grad(X, Y, epsilon, alpha_hat, gama, beta);

%% Task 3

load ('data2.mat');
[P_G2] = grad(X, Y, epsilon, alpha_hat, gama, beta);

%% Task 4 - data 3

load ('data3.mat');
[P_G3] = grad(X, Y, epsilon, alpha_hat, gama, beta);

%% Task 4 - data 4

load ('data4.mat');
[P_G4] = grad(X, Y, epsilon, alpha_hat, gama, beta);

%% Newton method Parameters

Maxiterations = 15;         %Max iterations number 
epsilon=10^-6;              %Constant given
a=1;                        %Constant given
gamma=10^-4;                %Constant given
beta=0.5;                   %Constant given


%% Task 6 - data 1

load ('data1.mat');
[P_N1] = newton(X,Y,epsilon,a,gamma,beta,Maxiterations);

%% Task 6 - data 2

load ('data2.mat');
[P_N2] = newton(X,Y,epsilon,a,gamma,beta,Maxiterations);

%% Task 6 - data 3

load ('data3.mat');
[P_N3] = newton(X,Y,epsilon,a,gamma,beta,Maxiterations);

%% Task 6 - data 4

load ('data4.mat');
[P_N4] = newton(X,Y,epsilon,a,gamma,beta,Maxiterations);



