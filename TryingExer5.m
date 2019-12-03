% Small intro to discrete time system analysis in Octave/MATLAB
% By Jacques Berg

%% A system in frequency domain
% An example system:
% y[n] = (x[n] + x[n-1] + x[n-2])/3
bb = ones(1,3)/3;
aa = [1, 0, 0]; % zeros because 2nd order system and there is no y[n-1] and y[n-2] terms

bb = [1, 0, 0];
aa = [1.0005, -0.0005];



% Zeros and poles of H(z)
zz = roots(bb) % zeros of the system
pp = roots(aa) % poles of the system

% Poles are at the origin ... thus a FIR system!
zplane(bb,aa) % Argand's diagram
poly([0 0])   % you can also generate a polynomial if you know the roots
zplane(zz,pp) % an another way to call the zplane (by giving the roots)
bb
zz
freqz(bb,aa)          % frequency response, look documentation for freqz for more info
Fs = 213854;          % an arbitrary sampling frequency
freqz(bb,aa,1024,Fs)  % frequency response, now with physical frequency
figure; zplane(zz,pp)



%%%%%%to plot the frequency!
b0 = 0.05634;
b1 = [1  1];
b2 = [1 -1.0166 1];
a1 = [1 -0.683];
a2 = [1 -1.4461 0.7957];

b = b0*conv(b1,b2);
a = conv(a1,a2);

[h,w] = freqz(b,a,'whole',2001);

plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')