% Cerinte:
% 
%25. Multiplexare în frecven?? cu MA. 
%Semnale modulatoare: 3 dreptunghiuri neperiodice diferite. 
%Analiz? (timp, frecven??), compara?ii.

%-------------------------------------------------------------------------%


clc             % sterge command window
close all       % inchide toate figurile
clear all       % sterge tot ce este in memorie/workspace
format long     % output format

%------ Teorie ------%

% % Modulatie in Amplitudine
% % Ap - amplitudine semnal purtator
% % Fp - frecventa semnal purtator
% % kA - constanta de modulatie
% % Am - amplitudine semnal modulator
% % Fm - frecventa semnal modulator

% % xMA(t) = [Ap + kA*xm(t)]* cos(2*pi*Fp*t); - formula semnal modulat


%------ Functii initiale ------%

%Fs >= 2*Fmax   
%Fs = 1000;      % in Hz Frecventa de esantionare
%Ts = 1/Fs;      % in s  Timp de esantionare

%time interval - vector de timpi
%variam amplitudinea => suportul convolutiei


%--- Generare Semnal ---%

Fp_1=1;         % frecventa semnal purtator 1
Tp_1=1/Fp_1;    % perioada semnalului purtator 1
Ap_1=0.1;       % amplitudine semnal purtator1

Fp_2=2;         % frecventa semnal purtator 2
Tp_2=1/Fp_2;    % perioada semnalului purtator 2
Ap_2=0.2;       % amplitudine semnal purtator 2

Fp_3=3;         % frecventa semnal purtator 3
Tp_3=1/Fp_3;    % perioada semnalului purtator 3
Ap_3=0.3;       % amplitudine semnal purtator 3

F = 0.25;       % semnal modulator
T = 1/F;        % perioada semnal modulator

Fs=50*F;        % frecventa de esantionare (cel putin de 2 ori mai mare decat Fmax) Fs>=2*Fmax
Ts=1/Fs;        % timp de esantionare

xS=10;               % Limita stanga
xD=10;               % Limita dreapta
tx=(-xS: Ts: xD);    % Time interval timp - pas / Domeniul semnalului


%x(t)=u(t+alfa)-u(t-alfa)
%u(t) - semnal treapta
%alfa - intarziere (altereaza punctul pe Ox)

%----- Semnale  -----%
alfa = 2;
x_1=(tx>=-alfa)-(tx>=alfa);         %Semnale Modulatoare
x_2=2*(tx>=-alfa)-2*(tx>=alfa);
x_3=3*(tx>=-alfa)-3*(tx>=alfa);


xp_1 = Ap_1 * sin(2*pi*Fp_1*tx);                       % Semnal Purtator 1
xp_2 = Ap_2 * cos(2*pi*Fp_2*tx);                       % Semnal Purtator 2
xp_3 = Ap_3 * (sin(2*pi*Fp_3*tx)+cos(2*pi*Fp_3*tx));   % Semnal Purtator 3



%----- Semnale  Modulate -----%    INTREBAM
kA=0.1;                                             % Grad de Modulatie
xMA_1 = (Ap_1 + kA * x_1) .* sin(2*pi*Fp_1*tx);     % Semnale Modulate
xMA_2 = (Ap_2 + kA * x_2) .* cos(2*pi*Fp_2*tx);     
xMA_3 = (Ap_3 + kA * x_3) .* (sin(2*pi*Fp_3*tx)+cos(2*pi*Fp_3*tx));     


%----- Analiza Timp si Frecventa -----%


%--- Analiza x_1 ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_XMA_1 = length(tx) * 15;           %15 nu are anumita semnificatie, nr intreg > 1
XMA_1 = fft(xMA_1, Nfft_XMA_1);         %perioada = Fs pentru ca Fft ia valori de la 0      
XMA_1 = fftshift(XMA_1);                %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_XMA_1 = Fs/Nfft_XMA_1;
F_XMA_1 = (-Fs/2 : pas_XMA_1 : Fs/2 - pas_XMA_1);


%--- Analiza x_2 ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_XMA_2 = length(tx) * 15;           %15 nu are anumita semnificatie, nr intreg > 1
XMA_2 = fft(xMA_2, Nfft_XMA_2);         %perioada = Fs pentru ca Fft ia valori de la 0      
XMA_2 = fftshift(XMA_2);                %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_XMA_2 = Fs/Nfft_XMA_2;
F_XMA_2 = (-Fs/2 : pas_XMA_2 : Fs/2 - pas_XMA_2);


%--- Analiza x_3 ---%

%Se va calcula transformata Fourier in mai multe puncte in frecventa decat nr de puncte din timp
Nfft_XMA_3 = length(tx) * 15;           %15 nu are anumita semnificatie, nr intreg > 1
XMA_3 = fft(xMA_3, Nfft_XMA_3);         %perioada = Fs pentru ca Fft ia valori de la 0      
XMA_3 = fftshift(XMA_3);                %repozitionam pentru intervalul [-Fs/2:Fs/2]

pas_XMA_3 = Fs/Nfft_XMA_3;
F_XMA_3 = (-Fs/2 : pas_XMA_3 : Fs/2 - pas_XMA_3);


%--- Analiza Multiplexare ---%
xMA_Multiplexare = xMA_1+xMA_2+xMA_3;

Nfft_XMA_Multiplexare = length(tx) * 15;
XMA_Multiplexare = fft(xMA_Multiplexare, Nfft_XMA_Multiplexare);
XMA_Multiplexare = fftshift(XMA_Multiplexare);

pas_XMA_Multiplexare = Fs/Nfft_XMA_Multiplexare;
F_XMA_Multiplexare = (-Fs/2 : pas_XMA_Multiplexare : Fs/2 - pas_XMA_Multiplexare);


%----- Afisaj -----%


%--- Semnale Modulate ---%
figure
subplot(4,1,1)
plot(tx,xMA_1,'r')
title("Semnal XMA1")
subplot(4,1,2)
plot(tx,xMA_2,'g')
title("Semnal XMA2")
subplot(4,1,3)
plot(tx,xMA_3,'b')
title("Semnal XMA3")
subplot(4,1,4)
plot(tx, xMA_1+xMA_2+xMA_3);        %Multiplexare
title("Multiplexare")


%--- Analiza Frecventa ---%
figure
subplot(4,1,1)
plot(F_XMA_1,abs(XMA_1))
grid
title("Analiza Frecventa XMA1")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(4,1,2)
plot(F_XMA_2,abs(XMA_2))
grid
title("Analiza Frecventa XMA2")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(4,1,3)
plot(F_XMA_3,abs(XMA_3))
grid
title("Analiza Frecventa XMA3")
ylabel('Amplitudine')
xlabel('Frecventa')

subplot(4,1,4)
plot(F_XMA_Multiplexare,abs(XMA_Multiplexare))
grid
title("Analiza Frecventa XMA_Multiplexare")
ylabel('Amplitudine')
xlabel('Frecventa')



%--- Semnale Initiale ---%
figure 
hold on
plot(tx,x_1,'r')
plot(tx,x_2,'g')
plot(tx,x_3,'b')
title("Semnale Initiale")
