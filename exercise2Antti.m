% linearity check
aa = rand; bb = rand;
xx1 = randn(1,100);
xx2 = randn(1,100);
% combined signal
cs = aa*xx1 + bb*xx2;
% system: 4 point running average
% y[n] = 1/4*(x[n] + x[n-1] + x[n-2] + x[n-3])
Fcs = 1/4*( cs + [0,cs(1:99)] + [0,0,cs(1:98)] + ...
[0,0,0,cs(1:97)]);
Fxx1 = 1/4*( xx1 + [0,xx1(1:99)] + [0,0,xx1(1:98)] + ...
[0,0,0,xx1(1:97)]);
Fxx2 = 1/4*( xx2 + [0,xx2(1:99)] + [0,0,xx2(1:98)] + ...
[0,0,0,xx2(1:97)]);
cF = aa*Fxx1 + bb*Fxx2;
norm(cF-Fcs)
eps

% causality
nn = -49:50; % 100 points around 0
xx = randn(size(nn)) .* double(nn >= 0);
stem(nn,xx)
Fxx = 1/4*( xx + [0,xx(1:99)] + [0,0,xx(1:98)] + ...
[0,0,0,xx(1:97)]);
stem(nn,Fxx)
norm(Fxx(nn < 0))
% time shift invariance
% test vector xx
% output of time shifted input
xxts = [0,xx(1:99)];
Fxxts = 1/4*( xxts + [0,xxts(1:99)] + [0,0,xxts(1:98)] + ...
[0,0,0,xxts(1:97)]);

% time shifted output
tsFxx = [0,Fxx(1:99)];
% compare only the real parts of the signal...
norm(Fxxts(2:99) - tsFxx(2:99))
%% system coefficients
% y[n] = x[n] + 2x[n-1] + 2x[n-2] + x[n-3] + ...
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