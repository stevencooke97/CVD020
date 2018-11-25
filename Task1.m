close all
clear all
clc

Ts = 0.01;
Fs = 1/Ts;

Test1Data = dlmread('Test 1 Data.txt');

Time = Test1Data(:,1);
Disp = Test1Data(:,2);
% plot(Time,Disp);

nfft = length(Disp); % Length of time domain signal
nfft2 = 2^nextpow2(nfft); % Length of signal in power of 2
ff = fft(Disp,nfft2); % Symmetrical, only want one half
ff2 = ff(1:nfft2/2);
xfft = Fs*2*pi()*(0:nfft2/2-1)/nfft2; % Multiply by 2pi to convert from Hz to rad/s

plot(xfft,abs(ff2));
title('Half-power bandwidth method of damping measurement for Test 1');
xlabel('Frequency \omega (rad/s)');
ylabel('Magnitude |H(\omega)|');
xlim([0 100])

[Q] = max(abs(ff2));
Omega = interp1(abs(ff2), xfft, Q, 'PCHIP'); % Check on visual confirmation of Q and corresponding Omega value





