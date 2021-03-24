clc;
clear all;
close all;

%Dimens�es do problema
Lx = 0.1; Ly = 0.1; Lz = 0.1;
Nx = 40; Ny = 40; Nz = 40;
dx = Lx/Nx; dy = Ly/Ny; dz = Lz/Nz;
Vo = 1;
N=150; M=150;

%Condi��es de contorno
Vx = 0; Vy = 0; Vz = 0;
VxNx = 0; VyNy = 0; VzNx = 0; VzNy = 0;
VzNxNy = 0;
Vx1Nz = Vo/2; Vx2Nz = -Vo/2;

%Inicializa matriz de potencial
for i=1:Nx
    for j=1:Ny
        for k=1:Nz
            V(i,j,k) = Vo;
        end
    end
end

%Inicializa vari�veis auxiliares
Va=V;
varmax=1;
ct=0;
tol=1e-6;

%Calcula potencial por m�todo iterativo de Gauss-Seidel
while varmax>tol
   ct=ct+1;
   varmax=0;
   for i=1:Nx
       for j=1:Ny
           for k=1:Nz
               %Acrescenta potencial V(i-1,j)
                if i>1
                    V(i,j,k)=dy^2*dz^2*V(i-1,j,k);
                else
                    V(i,j,k)=dy^2*dz^2*Vx;
                end
                %Acrescenta potencial V(i+1,j,k)
                if i<Nx
                    V(i,j,k)=V(i,j,k)+dy^2*dz^2*V(i+1,j,k);
                else
                    V(i,j,k)=V(i,j,k)+dy^2*dz^2*VxNx;
                end
                %Acrescenta potencial V(i,j-1,k)
                if j>1
                    V(i,j,k)=V(i,j,k)+dx^2*dz^2*V(i,j-1,k);
                else
                    V(i,j,k)=V(i,j,k)+dx^2*dz^2*Vy;
                end
                %Acrescenta potencial V(i,j+1,k)
                if j<Ny
                    V(i,j,k)=V(i,j,k)+dx^2*dz^2*V(i,j+1,k);
                else
                    V(i,j,k)=V(i,j,k)+dx^2*dz^2*VyNy;
                end
                %Acrescenta potencial V(i,j,k-1)
                if k>1
                    V(i,j,k)=V(i,j,k)+dx^2*dy^2*V(i,j,k-1);
                else
                    V(i,j,k)=V(i,j,k)+dx^2*dy^2*Vz;
                end
                %Acrescenta potencial V(i,j,k+1)
                if k<Nz
                    V(i,j,k)=V(i,j,k)+dx^2*dy^2*V(i,j,k+1);
                else
                    if (i<Nx/2 && j<Ny/2)
                        V(i,j,k)=V(i,j,k)+dx^2*dy^2*Vx1Nz;
                    end
                    if (i>Nx/2 && j<Ny/2)
                        V(i,j,k)=V(i,j,k)+dx^2*dy^2*Vx2Nz;
                    end
                    if (i<Nx/2 && j>Ny/2)
                        V(i,j,k)=V(i,j,k)+dx^2*dy^2*Vx2Nz;
                    end
                    if (i>Nx/2 && j>Ny/2)
                        V(i,j,k)=V(i,j,k)+dx^2*dy^2*Vx1Nz;
                    end
                end
             %Potencial na posi��o (i,j,k)
             V(i,j,k)=V(i,j,k)/(2*(dy^2*dz^2+dx^2*dz^2+dx^2*dy^2));
            %Varia��o do potencial entre duas itera��es sucessivas
            dif=abs(V(i,j,k)-Va(i,j,k));
            if dif>varmax
               varmax=dif;
            end
         end
      end
   end
   %Atualiza matriz anterior
   Va=V;
   Var(ct)=varmax;
end
%Define eixos
for i=1:Nx
   x(i)=dx+(i-1)*(Lx-2*dx)/(Nx-1);
end

for j=1:Ny
   y(j)=dy+(j-1)*(Ly-2*dy)/(Ny-1);
end

for k=1:Nz
    z(k)=dz+(k-1)*(Lz-2*dz)/(Nz-1);
end

for i=1:Nx
    for j=1:Ny
        VD(i,j)=V(i,j,Nz);
    end
end

%Gr�fico de superf�cie
figure(1)
surf(x,y,VD);
xlabel('x(m)');
ylabel('y(m)');
zlabel('V(V)');
title('Distribui��o de Potencial El�trico - Num�rico');
colorbar;

%C�lculo do Campo El�trico
% j=Ny/4;
% for i=1:Nx
%    for k=1:Nz
%       if i<Nx
%          Ex(i,j,k)=(V(i,j,k)-V(i+1,j,k))/dx;
%       else
%          Ex(i,j,k)=(V(i,j,k)-VxNx)/dx;
%       end
% 		if k<Nz
%          Ez(i,j,k)=(V(i,j,k)-V(i,j,k+1))/dz;
%       else
%           Ez(i,j,k)=(V(i,j,k)-VyNy)/dz;
%       end
%       unx(i,j,k)=Ex(i,j,k)/sqrt(Ex(i,j,k)^2+Ez(i,j,k)^2);
%       unz(i,j,k)=Ez(i,j,k)/sqrt(Ex(i,j,k)^2+Ez(i,j,k)^2);
%    end
% end
% 
% for i=1:Nx
%     for k=1:Ny
%         Vxz(i,k)=V(i,Ny/4,k);
%     end
% end
% 
% figure(2)
% contour(x,z,Vxz);
% hold on
% quiver(x,z,unz,unx);
% hold off
% xlabel('x(m)');
% ylabel('z(m)');
% title('Linhas Equipotenciais');
% colorbar;

%C�lculo Anal�tico %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dxa=Lx/(Nx-1); dya=Ly/(Ny-1);
for i=1:Nx
    xa(i)=(i-1)*dxa;
end
for j=1:Ny
    ya(j)=(j-1)*dya;
end

for i=1:Nx
    for j=1:Ny
        Va(i,j)=0;
        for n=1:N
            for m=1:M
                %Definindo Knm
                Knm1=(1-cos(n*pi/2))*(1-cos(m*pi/2));
                Knm2=(cos(n*pi)-cos(n*pi/2))*(1-cos(m*pi/2));
                Knm3=(1-cos(n*pi/2))*(cos(m*pi)-cos(m*pi/2));
                Knm4=(cos(n*pi)-cos(n*pi/2))*(cos(m*pi)-cos(m*pi/2));
                Knm=2*Vo/(n*m*pi^2)*(Knm1+Knm2+Knm3+Knm4);
                Va(i,j)=Va(i,j)+Knm*(sin(n*pi*xa(i)/Lx)*sin(m*pi*ya(j)/Ly));
            end
        end
    end
end

figure(3);
surf(xa,ya,Va);
xlabel('x (m)');
ylabel('y (m)');
zlabel('V (V)');
title('Distribui��o do Pot�ncial El�trico - Anal�tico');
colorbar;

%Compara��o com modelo anal�tico
% Potencial no eixo x;
j=10;
for i=1:Nx
   Veixox(i)=VD(i,j);
%    Vteixox(i)=0;
   Vteixox(i)= Va(i,j);
end

%Potencial no eixo y;
i=10;
for j=1:Ny
   Veixoy(j)=VD(i,j);
%    Vteixoy(j)=0;
   Vteixoy(j)= Va(i,j);
end

figure(4)
subplot(2,1,1)
plot(x,Veixox,'k-',x,Vteixox,'ro');
xlabel('x(m)');
ylabel('V(V)');
title('Potencial El�trico ao longo do eixo j=10');
grid on;
legend('Num�rico','Anal�tico');
subplot(2,1,2)
plot(y,Veixoy,'k-',y,Vteixoy,'ro');
xlabel('y(m)');
ylabel('V(V)');
title('Potencial El�trico ao longo do eixo i=10');
grid on;
legend('Num�rico','Anal�tico');
