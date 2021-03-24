%C�lculo da Indu��o Magn�tica ao longo do eixo z
clc;
close all;
clear all;
%Valores pr� definidos
R=10e-2;
Z=5e-2;
I=1;
u0=4*pi*10^(-7);     %Constante
x=-1:0.1:1;         %Zerando a vari�vel x
y=-1:0.1:1;         %Zerando a vari�vel y
z=-1:0.1:1;        %Variando z com passo de 1m

n=1;                 %N�mero de voltas da h�lice a ser considerado
N=1000;              %N�mero de discretiza��es
dphil=2*pi*n/N;      %Discretizando a vari�vel de integra��o

for i=1: length(x)
    for j=1: length(y)
for k=1: length(z)
    Bx1=0;
    By1=0;
    Bz1=0;
    
    rho(i,j)=(x(i)^2+y(j)^2)^(1/2);
    phi(i,j)=atan2(x(i),y(j));

%C�lculo da Integral    
for h=1:N
    Bx1=Bx1+(z(k)*R*cos(h*dphil)-Z*rho(i,j)*sin(h*dphil)/(2*pi)+Z*R*(sin(h*dphil)-h*dphil*cos(h*dphil))/(2*pi))/(rho(i,j)^2+R^2-2*R*rho(i,j)*cos(phi(i,j)-h*dphil)+(z(k)-Z*h*dphil/(2*pi))^2)^(3/2)*h*dphil;
    By1=By1+(z(k)*R*sin(h*dphil)+Z*rho(i,j)*cos(phi(i,j))/(2*pi)-Z*R*(h*dphil*sin(h*dphil)+cos(h*dphil))/(2*pi))/(rho(i,j)^2+R^2-2*R*rho(i,j)*cos(phi(i,j)-h*dphil)+(z(k)-Z*h*dphil/(2*pi))^2)^(3/2)*h*dphil;
    Bz1=Bz1+(R-rho(i,j)*cos(phi(i,j)-h*dphil))/(rho(i,j)^2+R^2-2*R*rho(i,j)*cos(phi(i,j)-h*dphil)+(z(k)-Z*h*dphil/(2*pi))^2)^(3/2)*h*dphil;
end
%Multiplicando o valor da integral pelas constantes
Bx(i,j,k)=u0*I/(4*pi)*Bx1;
By(i,j,k)=u0*I/(4*pi)*By1;
Bz(i,j,k)=u0*I*R/(4*pi)*Bz1;
Bmod(i,j,k)=(Bx(i,j,k)^2+By(i,j,k)^2+Bz(i,j,k)^2)^(1/2);
end
    end
end
%Gerando os gr�ficos em figuras seperadas
figure(1)
plot(z,Bz(i,j,k));grid on