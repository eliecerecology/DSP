% Small intro to spectrum analysis, noise and distortion in MATLAB/Octave
% By Jacques Berg
%
% If you are using Octave, you need to install (needed only the first time) and
% load signal processing package
%   pkg install -forge signal
%   pkg load signal

% First we add noise to the signal
SNR = 50;
SSS = 662;                   % dB, signal-to-noise ratio (SNR)
Fs = 8000;                 % sampling frequency, just for fun it is half of the CD standard 44,1 kHz
tt = 0:(1/8000):2;
tt = tt(1:4096);            % time vector for one second duration (now real second instead of sample index)
signal = sin(2*pi*662*tt);      % sinusoidal signal with a frequency of 440Hz (Middle A, the standard for musical pitch)
sound(signal)
plot(tt, signal);

nvar = var(signal)/10^(SNR/10);
plot(tt, nvar)
sound(signal, Fs)

% question n2

y = fft(signal);
L = 4096;
P2 = abs(y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


pwelch(signal, 1024, 0.5, 1024, Fs, 'dB')
%because it is in logarithmic scale and the signal start from 0, so no noise at time 0,
% and increases until reach the amplitude at -0.15 which is equivalent to amplitude one.

%  Now we simulate the distortion caused by clipping
% Clipping is done by first amplifying the signal tentimes (10x) and then limiting to the range [-1,1]

ssnn = signal + randn(size(signal))  + 2; % SNR = 50 dB
ssn  = min(1,max(-1,ssnn));             % limit to [-1,1] to prevent distortion in sound() function
ssn10 = ssn*10;                         % amplified, noisy sinusoidal signal
sound(ssn,Fs)
ssn10( ssn10 > 1 ) = 1;                 % upper limit clipping
ssn10( ssn10 <-1 ) =-1;                 % lower limit clipping
%sound(ssn10,Fs)
%sound(ssn,Fs)
%sound(ssn10,Fs)

% then the spectra of the clipped signal
pwelch(ssn10,1024,0.5,1024,Fs,'dB')
grid; hold off

%main difference is we added some random noise using function randn(size(signal)) and added 2

% Question 4:

SNR = 50;
SSS = 662;                  
Fs = 8000;                 
tt = 0:(1/8000):2;
tt = tt(1:4096); 

% time vector for one second duration (now real second instead of sample index)
t = 0:1/Fs:1;
y = chirp (t, 100, 1, 200, "linear");
sound(y,Fs);
specgram (y);

% deacrese amplitude
%signal amplitude decreases exponentially with time constant of 0.2 s
% maximum amplitude is 1

d = 0:1/5:1; % 1/5 == 0.2
y = 1.*exp(-d).* chirp (t, 100, 1, 200, "linear");
sound(y,Fs);

% add white noise with standard deviation of 0.02
%genrating noise
a = 0;
b = 0.02;
white_noise = (b-a).*rand(length(t),1) + a

y = 1.*exp(-t).* chirp (t, 100, 1, 200, "linear") + white_noise;
sound(y)

% sampling rate is SSS*10 s-1
https://octave.sourceforge.io/signal/function/chirp.html