% Eliecer Diaz
% 1706220
% LAB 3

% Problem 1: Generate a sine wave sample with
% Sample length 2^12 samples
SNR = 50;
SSS = 662;                 
Fs = 8000;                 
tt = 0:(1/8000):2;
tt = tt(1:4096);            
signal = sin(2*pi*662*tt);    
sound(signal)
plot(tt, signal);

figure(1), clf
plot(time, signal,'ks-','linewidth',2,'markerfacecolor','w')
xlabel('Time (sec.)'), ylabel('Amplitude')
title('A sine wave.')

%SNR = 10*log10(Psignal/Pnoise) ????

% Question 2:
% Use Fourier Transformation to generate the power spectrum of the previous sample:
% Use frequency [0-Fn] in horizontal axis % WHAT IS Fn??
% Use desibels in vertical axis
fourTime = (0:pnts-1)/pnts;
fCoefs   = zeros(size(signal));

for fi=1:pnts
    
    % create complex sine wave
    csw = exp(-1i*2*pi*(fi-1)*fourTime );
    
    % compute dot product between sine wave and signal
    fCoefs(fi) = sum( signal.*csw ) / pnts;
    % these are called the Fourier coefficients
end


% extract amplitudes
ampls = 2*abs(fCoefs);

% compute frequencies vector
hz = linspace(0,srate/2,floor(pnts/2)+1);

figure(1), clf
subplot(211)
plot(time,signal,'k','linew',2)
xlabel('Time (s)'), ylabel('Amplitude')
title('Time domain')

subplot(212)
plot(hz,ampls(1:length(hz)),'ks-','linew',3,'markersize',15,'markerfacecolor','w')


%ANSWER 2:
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
xlabel('Hz')
% Answer 3:
ssnn = signal + randn(size(signal))  + 2; % SNR = 50 dB
ssn  = min(1,max(-1,ssnn));             % limit to [-1,1] to prevent distortion in sound() function
ssn10 = ssn*10;                         % amplified, noisy sinusoidal signal
sound(ssn,Fs)
ssn10( ssn10 > 1 ) = 1;                 % upper limit clipping
ssn10( ssn10 <-1 ) =-1;
pwelch(ssn10,1024,0.5,1024,Fs,'dB')
xlabel('Hz');
grid; hold off

% Question 4:
SNR = 50;
SSS = 662;                  
Fs = 8000;                 
tt = 0:(1/8000):2;
tt = tt(1:4096); 

% time vector for one second duration (now real second instead of sample index)
t = 0:1/Fs:10;
y = chirp (t, 100, 10, 200, "linear");
sound(y,Fs);
specgram(y);

t = 0:-1/5:10;
y = chirp(t, 100,10,200,"logarithmic");
sound(y, Fs);
specgram(y, 256, 8000);



t = 0:1/Fs:10;
t = t(1:501);
y = chirp(t, 100,10,200,"logarithmic");
% adding white noise:
a = 0;
b = 0.02;
white_noise = (b-a).*rand(length(t),1) + a

y = 1.*exp(-t).* chirp (t, 100, 1, 200, "linear") +
      white_noise;
% this can not be
% I will try this:
new_freq = 100:1/5:200;
new_amp = (linspace(1,0, 501));
new_signal = new_amp.*sin(2*pi.*new_freq.*t);    
sound(new_signal)

subplot(1,2,1);
plot(new_freq, new_signal)
xlabel('Frequency')
ylabel('Amplitude')
subplot(1,2,2);
pwelch(new_signal, 1024, 0.5, 1024, Fs, 'dB')
xlabel('Hz')
