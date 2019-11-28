% Small intro to filter design and analysis in Octave/MATLAB
% By Jacques Berg

% Notch filters are useful tools to reject a specific disturbing tone from
% the signal. They are designed by placing zero to the unit circle at the
% center frequency to be rejected
Fs = 8000;  % sampling frequency 8 kHz
f = 1000;   % frequency to be rejected
z_q1 = exp(i*2*pi*f/Fs);
b_q1 = poly([z_q1 conj(z_q1)]);
% pole is placed near to the zero, poles distance to the zero determines
% the bandwidth of the notch filter
f3db = 100; % -3dB bandwidth is 100Hz
p_q1 = (1-2*pi*((f3db/Fs)/2))*z_q1;
a_q1 = poly([p_q1 conj(p_q1)]);
% then let's scale the system to 0dB baseline
gg = max(abs(freqz(b_q1, a_q1)));
b_q1 = b_q1/gg;
% Notch filter (a, b) is ready, let's analyze it
figure(1); zplane(b_q1, a_q1);
figure(2); freqz(b_q1, a_q1, 1024, Fs);
title(sprintf('Notch filter, fc=%dHz f-3dB=%dHz', f, f3db));

% Doubling the delays means adding zeros to MATLAB filter parameters
b_q3 = [b_q1(1) 0 b_q1(2) 0 b_q1(3)];
a_q3 = [a_q1(1) 0 a_q1(2) 0 a_q1(3)];
figure(3); zplane(b_q3, a_q3);
figure(4); freqz(b_q3, a_q3, 1024, Fs);
title(sprintf('Notch filter with doubled delays, fc=%dHz f-3dB=%dHz', f, f3db));

% Designing filter from analog counterparts is easy with MATLAB
fc = 3200;  % 3200 Hz is the -3dB point
[b_q4,a_q4] = butter(4, fc/(Fs/2));
figure(5); zplane(b_q4, a_q4);
figure(6); freqz(b_q4, a_q4, 1024, Fs);