% linearity check
aa = rand; bb = rand;
xx1 = randn(1,20);
xx2 = randn(1,20);
% combined signal
cs = aa*xx1 + bb*xx2;
% system: 4 point running average
% y[n] = 1/4*(x[n] + x[n-1] + x[n-2] + x[n-3])
Fcs = 1/4*( cs + [0,cs(1:19)] + [0,0,cs(1:18)] + ...
[0,0,0,cs(1:17)]);
Fxx1 = 1/4*( xx1 + [0,xx1(1:19)] + [0,0,xx1(1:18)] + ...
[0,0,0,xx1(1:17)]);
% causality
nn = -9:20; % 100 points around 0
xx = randn(size(nn)) .* double(nn >= 0);
stem(nn,xx)
Fxx = 1/4*( xx + [0,xx(1:99)] + [0,0,xx(1:98)] + ...
[0,0,0,xx(1:97)]);
stem(nn,Fxx)
norm(Fxx(nn < 0))