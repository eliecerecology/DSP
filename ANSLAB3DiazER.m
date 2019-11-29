% Eliecer Diaz
% 1706220
% LAB 3

% Problem 1: Generate a sine wave sample with
% Sample length 2^12 samples
SSS = 622;
srate  = 8000; % hz
time  = 0:(1/(2^12)):2-1/srate; % time in seconds 0 to 2 seconds
pnts   = length(time); % number of time points
length(pnts);
signal = 1 * sin( 2*pi*SSS*time ); 


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
