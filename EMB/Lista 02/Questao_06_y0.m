%C�lculo da Indu��o Magn�tica com y=0
clc;
close all;
clear all;
%Valores pr� definidos
R=10e-2;
Z=5e-2;
I=1;
u0=4*pi*10^(-7);    %Constante
x=-1:0.05:1;        %Variando x com passo de 0,05
y=0;                %Zerando a vari�vel y
z=-1:0.05:1;        %Variando z com passo de 0,05

n=5;                %N�mero de voltas da h�lice a ser considerado
N=5000;             %N�mero de discretiza��es
dphil=2*pi*n/N;     %Discretizando a vari�vel de integra��o
phi=0;

%Zerando as matrizes e definindo o seu tamanho
rho=zeros(length(x),1);
Bx=zeros(length(x),length(z));
By=zeros(length(x),length(z));
Bz=zeros(length(x),length(z));

%Variando x e z e salvando os valores de indu��o magn�tica em matrizes
for k=1: length(x)
    for h=1: length(z)

Bx1=0;
By1=0;
Bz1=0;
    %Definindo rho e phi em fun��o de k e h
    rho(k)=abs(x(k));                  %Como y=0, rho se resume a x
    %C�lculo da Integral
for j=1:N
    Bx1=Bx1+(z(h)*R*cos(j*dphil)-Z*rho(k)*sin(phi)/(2*pi)+Z*R*(sin(j*dphil)-j*dphil*cos(j*dphil))/(2*pi))/(rho(k)^2+R^2-2*R*rho(k)*cos(phi-j*dphil)+(z(h)-(Z*j*dphil)/(2*pi))^2)^(3/2)*dphil;
    By1=By1+(z(h)*R*sin(j*dphil)+Z*rho(k)*cos(phi)/(2*pi)-Z*R*(j*dphil*sin(j*dphil)+cos(j*dphil))/(2*pi))/(rho(k)^2+R^2-2*R*rho(k)*cos(phi-j*dphil)+(z(h)-(Z*j*dphil)/(2*pi))^2)^(3/2)*dphil;
    Bz1=Bz1+(R-rho(k)*cos(phi-j*dphil))/(rho(k)^2+R^2-2*R*rho(k)*cos(phi-j*dphil)+(z(h)-(Z*j*dphil)/(2*pi))^2)^(3/2)*dphil;
end
%Multiplicando o valor da integral pelas constantes
Bx(k,h)=u0*I/(4*pi)*Bx1;
By(k,h)=u0*I/(4*pi)*By1;
Bz(k,h)=u0*I*R/(4*pi)*Bz1;
Bmod(k,h)=(Bx(k,h)^2+By(k,h)^2+Bz(k,h)^2)^(1/2); %C�lculo do m�dulo da Integral
unx(k,h)=Bx(k,h)/Bmod(k,h);                      %C�lculo de Bx unit�rio
unz(k,h)=Bz(k,h)/Bmod(k,h);                      %C�lculo de Bz unit�rio
    end
end
%Gerando as superf�cies em figuras separadas
figure(1)
grid on
surf(x,z,Bx),title('Indu��o Magn�tica de Bx');
xlabel('x'), ylabel('z');

figure(2)
surf(x,z,By),title('Indu��o Magn�tica de By');
xlabel('x'), ylabel('z');

figure(3)
surf(x,z,Bz),title('Indu��o Magn�tica de Bz');
xlabel('x'), ylabel('z');
figure(4)
surf(x,z,Bmod),title('M�dulo da Indu��o Magn�tica');
xlabel('x'), ylabel('z');

figure(5)
contour(x,z,Bmod) %Contornos equipotenciais
hold on
quiver(x,z,unx,unz) %mapa vetorial
title('Contorno Equipotencial e Mapa Vetorial');
xlabel('x'), ylabel('z');
