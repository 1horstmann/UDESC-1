%C�lculo da For�a Magn�tica Quest�o 02
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

%%
%C�lculo da Indu��o Magn�tica com z=0 Quest�o 06
clc;
close all;
clear all;
%Valores pr� definidos
R=10e-2;
Z=5e-2;
I=1;
u0=4*pi*10^(-7);    %Constante
x=-1:0.05:1;        %Variando x com passo de 0,05
y=-1:0.05:1;        %Variando y com passo de 0,05
z=0;                %Zerando a vari�vel z

n=1;                %N�mero de voltas da h�lice a ser considerado
N=1000;             %N�mero de discretiza��es
dphil=2*pi*n/N;     %Discretizando a vari�vel de integra��o

%Zerando as matrizes e definindo o seu tamanho
phi=zeros(length(x),length(y));
rho=zeros(length(x),length(y));
Bx=zeros(length(x),length(y));
By=zeros(length(x),length(y));
Bz=zeros(length(x),length(y));

%Variando x e y e salvando os valores de indu��o magn�tica em matrizes
for k=1: length(x)
    for h=1: length(y)

Bx1=0;
By1=0;
Bz1=0;
    %Definindo rho e phi em fun��o de k e h
    rho(k,h)=(x(k)^2+y(h)^2)^(1/2);
    phi(k,h)=atan2(x(k),y(h));
%C�lculo da Integral
for j=1:N
    Bx1=Bx1+(z*R*cos(j*dphil)-Z*rho(k,h)*sin(phi(k,h))/(2*pi)+Z*R*(sin(j*dphil)-j*dphil*cos(j*dphil))/(2*pi))/(rho(k,h)^2+R^2-2*rho(k,h)*R*cos(phi(k,h)-j*dphil)+(z-Z*j*dphil/(2*pi))^2)^(3/2)*dphil;
    By1=By1+(z*R*sin(j*dphil)+Z*rho(k,h)*cos(phi(k,h))/(2*pi)-Z*R*(j*dphil*sin(j*dphil)+cos(j*dphil))/(2*pi))/(rho(k,h)^2+R^2-2*rho(k,h)*R*cos(phi(k,h)-j*dphil)+(z-Z*j*dphil/(2*pi))^2)^(3/2)*dphil;
    Bz1=Bz1+(R-rho(k,h)*cos(phi(k,h)-j*dphil))/(rho(k,h)^2+R^2-2*rho(k,h)*R*cos(phi(k,h)-j*dphil)+(z-Z*j*dphil/(2*pi))^2)^(3/2)*dphil; 
end
%Multiplicando o valor da integral pelas constantes
Bx(k,h)=u0*I/(4*pi)*Bx1;
By(k,h)=u0*I/(4*pi)*By1;
Bz(k,h)=u0*I*R/(4*pi)*Bz1;
Bmod(k,h)=(Bx(k,h)^2+By(k,h)^2+Bz(k,h)^2)^(1/2); %C�lculo do m�dulo da Integral
unx(k,h)=Bx(k,h)/Bmod(k,h);                      %C�lculo de Bx unit�rio
uny(k,h)=By(k,h)/Bmod(k,h);                      %C�lculo de By unit�rio
    end
end
%Gerando as superf�cies em figuras separadas
figure(1)
grid on
surf(x,y,Bx),title('Indu��o Magn�tica de Bx');          %Definindo o t�tulo do gr�fico
xlabel('x'), ylabel('y');                               %Definindo nome nos eixos

figure(2)
surf(x,y,By),title('Indu��o Magn�tica de By');          %Definindo o t�tulo do gr�fico
xlabel('x'), ylabel('y');                               %Definindo nome nos eixos

figure(3)
surf(x,y,Bz),title('Indu��o Magn�tica de Bz');          %Definindo o t�tulo do gr�fico
xlabel('x'), ylabel('y');                               %Definindo nome nos eixos

% figure(4)
% surf(x,y,Bmod),title('M�dulo da Indu��o Magn�tica');    %Definindo o t�tulo do gr�fico
% xlabel('x'), ylabel('y');                               %Definindo nome nos eixos

figure(5)
contour(x,y,Bmod) %Contornos equipotenciais
hold on
quiver(x,y,unx,uny) %mapa vetorial
title('Contorno Equipotencial e Mapa Vetorial');        %Definindo o t�tulo do gr�fico
xlabel('x'), ylabel('y');                               %Definindo nome nos eixos

%%
%C�lculo da Indu��o Magn�tica com y=0 Quest�o 06
clc;
close all;
clear all;
%Valores pr� definidos
R=10e-2;
Z=5e-2;
I=1;
u0=4*pi*10^(-7);    %Constante
x=-1:0.1:1;        %Variando x com passo de 0,05
y=0;                %Zerando a vari�vel y
z=-1:0.1:1;        %Variando z com passo de 0,05

n=1;                %N�mero de voltas da h�lice a ser considerado
N=1000;             %N�mero de discretiza��es
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

%%
%C�lculo da Indu��o Magn�tica ao longo do eixo z Quest�o 06
%Como foi pedido a indu��o magn�tica ao longo do eixo z, zerei as vari�veis
%x e y e variei o z, gerando um gr�fico dos pontos de indu��o magn�tica das
%tr�s dire��es (x,y e z) em rela��o ao eixo z. No gr�fico � poss�vel obter
%o valor da indu��o magn�tica em cada ponto.
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
