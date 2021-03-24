%C�lculo da For�a Magn�tica
clc;
close all;
clear all;
%Valores pr� definidos
R1=10*10^-2;
R2=15*10^-2;
i=1;
d=7*10^-2;
u0=4*pi*10^-7;                  %Constante
k=((-u0*i^2*R1*R2)/(4*pi));     %C�lculo da constante que multiplicar� a Integral

N=1000;                         %N�mero de discretiza��es
dtheta=(2*pi)/N;                %Discretizando a vari�vel de Integra��o
dphi=(2*pi)/N;                  %Discretizando a vari�vel de Integra��o

Fx1=0;
Fy1=0;
Fz1=0;
%C�lculo da Integral
for i=1: N
    for j=1: N
     Fx1=Fx1+(cos(j*dphi)*(R1-R2*cos(i*dtheta-j*dphi))/(R1^2+R2^2+d^2-2*R1*R2*cos(i*dtheta-j*dphi))^(3/2))*dtheta*dphi;
     Fy1=Fy1+((sin(j*dphi)*(R1-R2*cos(i*dtheta-j*dphi)))/(R1^2+R2^2+d^2-2*R1*R2*cos(i*dtheta-j*dphi))^(3/2))*dtheta*dphi;
     Fz1=Fz1+((cos(i*dtheta-j*dphi))/(R1^2+R2^2+d^2-2*R1*R2*cos(i*dtheta-j*dphi))^(3/2))*dtheta*dphi;
    end
end
%Valor final da for�a
%Multiplicando a Integral pela constante calculada anteriormente
Fx=k*Fx1
Fy=k*Fy1
Fz=-k*d*Fz1
