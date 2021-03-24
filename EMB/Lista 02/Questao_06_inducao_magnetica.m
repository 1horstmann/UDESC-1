%C�lculo da Indu��o Magn�tica ao longo do eixo z
clc;
close all;
clear all;
%Valores pr� definidos
R=10e-2;
Z=5e-2;
I=1;
u0=4*pi*10^(-7);     %Constante
x=0;                 %Zerando a vari�vel x
y=0;                 %Zerando a vari�vel y
z=-1:0.01:1;         %Variando z com passo de 1m

n=1;                 %N�mero de voltas da h�lice a ser considerado
N=1000;              %N�mero de discretiza��es
dphil=2*pi*n/N;      %Discretizando a vari�vel de integra��o

%Zerando rho e phi
rho=0;
phi=0;

%Variando z e salvando o valor de indu��o magn�tica em um vetor
for h=1: length(z)
    Bx1=0;
    By1=0;
    Bz1=0;
%C�lculo da Integral    
for j=1:N
    Bx1=Bx1+(z(h)*R*cos(j*dphil)+Z*R*(sin(j*dphil)-j*dphil*cos(j*dphil))/(2*pi))/(R^2+(z(h)-Z*j*dphil/(2*pi))^2)^(3/2)*dphil;
    By1=By1+(z(h)*R*sin(j*dphil)-Z*R*(j*dphil*sin(j*dphil)+cos(j*dphil))/(2*pi))/(R^2+(z(h)-Z*j*dphil/(2*pi))^2)^(3/2)*dphil;
    Bz1=Bz1+(R)/(R^2+(z(h)-Z*j*dphil/(2*pi))^2)^(3/2)*dphil;
end
%Multiplicando o valor da integral pelas constantes
Bx(h)=u0*I/(4*pi)*Bx1;
By(h)=u0*I/(4*pi)*By1;
Bz(h)=u0*I*R/(4*pi)*Bz1;
Bmod(h)=(Bx(h)^2+By(h)^2+Bz(h)^2)^(1/2);
end
%Gerando os gr�ficos em figuras seperadas
figure(1)
plot(z,Bx);grid on
title('Indu��o ao longo de z de Bx');   %Definindo o t�tulo do gr�fico
xlabel('z'); ylabel('Bx');              %Definindo nome nos eixos

figure(2)
plot(z,By);grid on
title('Indu��o ao longo de z de By');   %Definindo o t�tulo do gr�fico
xlabel('z'); ylabel('By');              %Definindo nome nos eixos

figure(3)
plot(z,Bz);grid on
title('Indu��o ao longo de z de Bz');   %Definindo o t�tulo do gr�fico
xlabel('z'); ylabel('Bz');              %Definindo nome nos eixos
