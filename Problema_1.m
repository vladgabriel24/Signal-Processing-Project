% Analiza = varierea unor parametrii ca sa vedem cum se comporta graficele
% Cand avem un semnal periodic, NU schimbam perioada (T)

% Cerinte:
% 
% 1. Pentru  semnale  de  tipul x(t)=u(t+alfa)-u(t-alfa),  
% calculati y(t)=x(t)*x(t), z(t)=y(t)*x(t), q(t)=z(t)*x(t).
% Analizati toate semnalele implicate (timp, frecventa, comparatii).


%-------------------------------------------------------------------------%

clc             % sterge command window
close all       % inchide toate figurile
clear all       % sterge tot ce este in memorie/workspace
format long     % output format
        
%Fs >= 2*Fmax   
Fs = 1000;      % in Hz Frecventa de esantionare
Ts = 1/Fs;      % in s  Perioada de esantionare

%time interval - vector de timpi
%variam amplitudinea => suportul convolutiei
xS=10;               % Limita stanga
xD=10;               % Limita dreapta
tx=(-xS: Ts: xD);    % Time interval timp - pas / Domeniul semnalului


%----- Functia Initiala -----%


%x(t)=u(t+alfa)-u(t-alfa)
%u(t) - semnal treapta
%alfa - intarziere (altereaza punctul pe Ox)

alfa=2;
x=(tx>=-alfa)-(tx>=alfa);


%----- Calcul Convolutie -----%


%Convolutie y
y=conv(x,x);            % Length(y) = Length(x) + Length(x) - 1 
yS=xS+xS;
yD=xD+xD;
ty=(-yS: Ts: yD);

%Convolutie z
z=conv(y,x);            % Length(z) = Length(y) + Length(x) - 1
zS=yS+xS;
zD=yD+xD;
tz=(-zS: Ts: zD);

%Convolutie q
q=conv(z,x);            % Length(q) = Length(z) + Length(x) - 1 
qS=zS+xS;
qD=zD+xD;
tq=(-qS: Ts: qD);


%----- Analiza in Spectru si Faza -----%


%--- Analia x ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_X = length(tx) * 15;   %15 nu are anumita semnificatie, nr intreg > 1
X = fft(x, Nfft_X);         %perioada = Fs pentru ca Fft ia valori de la 0      
X = fftshift(X);            %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_X = Fs/Nfft_X;
F_X = (-Fs/2 : pas_X : Fs/2 - pas_X);

%Afisaj
figure
subplot(3,1,1)
plot(tx,x)
grid
title("Semnal Initial x")
ylabel('x(t)')
xlabel('t')

subplot(3,1,2)
plot(F_X,abs(X))
grid
title("Analiza Amplitudine-Frecventa")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(3,1,3)
plot(F_X, angle(X))
grid
title("Analiza Faza-Frecventa")
ylabel('Faza [radiani]')
xlabel('Frecventa')


%--- Analia y ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_Y = length(ty) * 15;   %15 nu are anumita semnificatie, nr intreg > 1
Y = fft(y, Nfft_Y);         %perioada = Fs       
Y = fftshift(Y);            %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_Y = Fs/Nfft_Y;
F_Y = (-Fs/2 : pas_Y : Fs/2 - pas_Y);

%Afisaj
figure
subplot(3,1,1)
plot(ty,y)
grid
title("Semnal Initial y")
ylabel('y(t)')
xlabel('t')

subplot(3,1,2)
plot(F_Y,abs(Y))
grid
title("Analiza Amplitudine-Frecventa")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(3,1,3)
plot(F_Y, angle(Y))
grid
title("Analiza Faza-Frecventa")
ylabel('Faza [radiani]')
xlabel('Frecventa')


%--- Analia z ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_Z = length(tz) * 15;   %15 nu are anumita semnificatie, nr intreg > 1
Z = fft(z, Nfft_Z);         %perioada = Fs       
Z = fftshift(Z);            %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_Z = Fs/Nfft_Z;
F_Z = (-Fs/2 : pas_Z : Fs/2 - pas_Z);

%Afisaj
figure
subplot(3,1,1)
plot(tz,z)
grid
title("Semnal Initial z")
ylabel('z(t)')
xlabel('t')

subplot(3,1,2)
plot(F_Z,abs(Z))
grid
title("Analiza Amplitudine-Frecventa")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(3,1,3)
plot(F_Z, angle(Z))
grid
title("Analiza Faza-Frecventa")
ylabel('Faza [radiani]')
xlabel('Frecventa')


%--- Analia q ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_Q = length(tq) * 15;   %15 nu are anumita semnificatie, nr intreg > 1
Q = fft(q, Nfft_Q);         %perioada = Fs       
Q = fftshift(Q);            %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_Q = Fs/Nfft_Q;
F_Q = (-Fs/2 : pas_Q : Fs/2 - pas_Q);

%Afisaj
figure
subplot(3,1,1)
plot(tq,q)
grid
title("Semnal Initial q")
ylabel('q(t)')
xlabel('t')

subplot(3,1,2)
plot(F_Q,abs(Q))
grid
title("Analiza Amplitudine-Frecventa")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(3,1,3)
plot(F_Q, angle(Q))
grid
title("Analiza Faza-Frecventa")
ylabel('Faza [radiani]')
xlabel('Frecventa')


%----- Afisaj Toate -----%

%--- Semnale Initiale ---%

figure
subplot(2,1,1)
hold on
plot(tx, x*100000, 'r')
plot(ty, y*100, 'g')
plot(tz, z/10, 'b')
plot(tq, q/10000, 'm')
title("Analiza Semnale Amplitudine-Timp")
legend('x(t)','y(t)','z(t)','q(t)')
ylabel('Amplitudine')
xlabel('Timp')
grid


%--- Analize Amplitudine-Frecventa ---%
subplot(2,1,2)
plot(F_X,abs(X),'r')
plot(F_Y,abs(Y),'g')
plot(F_Z,abs(Z),'b')
plot(F_Q,abs(Q),'m')
title("Analiza Semnale Amplitudine-Frecventa")
ylabel('Amplitudine')
xlabel('Frecventa')
grid




%--- Fourier ---%



%----- Explicatii Ajutatoare -----%

%Convolutie arie comuna intre cele doua
%rectpuls lucreaza pe jumatate => 0.5 incepe de la 0
%subplot(m,n,p) divides the current figure into an m-by-n grid and creates axes in the position specified by p
%hold on retains plots in the current axes so that new plots added to the axes do not delete existing plots
%theta = angle(z) returns the phase angle in the interval [-?,?] for each element of a complex array z
%Regula Suporturilor supp{z} = [-(ty+tx), (ty+tx)] pentru z(t)=conv(y,x)
%Avem Fs/2-pas1_fft pentrut ca este deschis la dreapta ciclul sare peste Fs/2 la ultima iteratie


%------ Varianta Heaviside -------%

% syms L
% assume(-2<L<2)
% H1 = heaviside(L)
% H2 = heaviside(-L)
% 
% H3 = H1-H2
% 
% hold on
% subplot(2,1,1)
% fplot(H1)
% subplot(2,1,2)
% fplot(H2)
% subplot(2,1,3)
% fplot(H3)

