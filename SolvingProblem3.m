% Problem 33
%condition 1:
x = zeros(30, 1);
x(1:7) = 1;
% just to make sure I got the right vectorize

noSamples = length(x);


subplot(2,2,1);
y = fft(x);
xfft = abs(y/noSamples);
stem(xfft)
xlabel('Sample frequency')
ylabel('Amplitude')
title('{Spectrum 1}')

%condition 2:

x2 = zeros(60, 1);
x2(1:7) = 1;
% just to make sure I got the right vectorize
noSamples2 = length(x2);


subplot(2,2,2);
y2 = fft(x2);
xfft2 = abs(y2/noSamples2);
stem(xfft2)
xlabel('Sample frequency')
ylabel('Amplitude')
title('{Spectrum 2}')

%condition 3:
x3 = zeros(120, 1);
x3(1:7) = 1;
% just to make sure I got the right vectorize
noSamples3 = length(x3);


subplot(2,2,3);
y3 = fft(x3);
xfft3 = abs(y3/noSamples3);
stem(xfft3)
xlabel('Sample frequency')
ylabel('Amplitude')
title('{Spectrum 3}')


