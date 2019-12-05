%y[n] = x[n] + 2x[n-1] + 2x[n-2] + x[n-3] + ...
%  0.4y[n-1]
bb = [1,2,2,1];
aa = [1, -0.4,0,0];
% zeros and poles
zplane(bb,aa)
roots(bb) % zero locatioins
roots(aa)

% test signal xx
yy = filter(bb,aa,xx) ; % LTI system = filter()
stem(nn,xx)
figure(2); stem(nn,xx)
figure(1); stem(nn,yy)
% impulse response...
dd = double(nn == 0); % discrete delta
hh = filter(bb,aa,dd); % impulse response
stem(nn,h)
stem(nn,hh)
norm(hh(nn > 0))
zpl
zplane(bb,aa)
Fs = 1000; % sampling rate
Fs
freqz(bb,aa, 1024, Fs)
% low pass system with about 20dB gain
bb = bb / max(abs(freqz(bb,aa, 1024, Fs)));
freqz(bb,aa, 1024, Fs)
doc
grpdelay(bb,aa)