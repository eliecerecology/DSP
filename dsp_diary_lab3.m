% Small intro to spectrum analysis, noise and distortion in MATLAB/Octave
% By Jacques Berg
%
% If you are using Octave, you need to install (needed only the first time) and
% load signal processing package
%   pkg install -forge signal
%   pkg load signal

% First we add noise to the signal
SNR = 40;                   % dB, signal-to-noise ratio (SNR)
Fs = 22050;                 % sampling frequency, just for fun it is half of the CD standard 44,1 kHz
tt = 0:(1/Fs):1;            % time vector for one second duration (now real second instead of sample index)
ss = sin(2*pi*440*tt);      % sinusoidal signal with a frequency of 440Hz (Middle A, the standard for musical pitch)
sound(ss,Fs)

% SNR = 10log(Psignal/Pnoise)
% 10^(SNR/10)=log(Psignal/Pnoise)
% Pnoise = Psignal/10^(SNR/10)

% Variance of the signal is the power of the signal (if zero mean signal)
var(ss)
nvar = var(ss)/10^(SNR/10);
ssnn = ss + randn(size(ss))*sqrt(nvar); % SNR = 40 dB
ssn  = min(1,max(-1,ssnn));             % limit to [-1,1] to prevent distortion in sound() function

sound(ssn,Fs)                           % signal and the noise
sound(randn(size(ss))*sqrt(nvar),Fs)    % just the noise for a comparision

% let's evaluate the spectra of the signal
figure(1); clf; hold on
pwelch(ssn,1024,0.5,1024,Fs,'dB')

% Now we simulate the distortion caused by clipping
% Clipping is done by first amplifying the signal tentimes (10x) and then limiting to the range [-1,1]
ssn10 = ssn*10;                         % amplified, noisy sinusoidal signal
sound(ssn,Fs)
ssn10( ssn10 > 1 ) = 1;                 % upper limit clipping
ssn10( ssn10 <-1 ) =-1;                 % lower limit clipping
sound(ssn10,Fs)
sound(ssn,Fs)
sound(ssn10,Fs)
std(ssn10)

% then the spectra of the clipped signal
pwelch(ssn10,1024,0.5,1024,Fs,'dB')
grid; hold off

% let's get a new sound sample (from the Windows sounds)
[fname,fpath] = uigetfile('c:\windows\Media\*.wav');
[yy, Fs] = audioread([fpath, fname]);
[fpath, fname]
sound(yy,Fs)

% and then the spectrogram ...
figure(2); specgram(yy(:,1),512,Fs)

