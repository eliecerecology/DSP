pkg load signal
% Question 1:

Fs = 8000;  % sampling frequency 8 kHz
f = 800;   % frequency to be rejected
z_q1 = exp(i*2*pi*f/Fs);
%zeros
b_q1 = poly([z_q1 conj(z_q1)]);


% pole:
% is placed near to the zero, poles distance to the zero determines
% the bandwidth of the notch filter
f3db = 200; % -3dB bandwidth is 100Hz

p_q1 = (1-2*pi*((f3db/Fs)/2))*z_q1; % 1 because 1 is the distance from 
a_q1 = poly([p_q1 conj(p_q1)]);


% then let's scale the system to 0dB baseline
gg = max(abs(freqz(b_q1, a_q1)));
b_q1 = b_q1/gg;

% Notch filter (a, b) is ready, let's analyze it
figure(1); zplane(b_q1, a_q1);
%[po, to] = ginput(1);
%poly([po to])





figure(2); hint = freqz(b_q1, a_q1, 1024, Fs);
xlim([0 4000])

title(sprintf('Notch filter, fc=%dHz f-3dB=%dHz', f, f3db));

% QUestion 2:

% Usint my old and nice impulse function generation from Lab1, I will create an impulse.

function y = dd(x)
  % x is a vector
  % We create an output vector of only 0 (our default value)
  y = zeros(1, length(x)); 

  % We find indexes of input values equal to 0,
  % and make them 1
  y(find(x==0)) = 1;
end;

% Create a data sequence: (see exercise 1.1 a)
%x1[n] = d[n-2] + d[n] - 2d[n-1]

% here the sequence 
n = -10 : 10 
imp_signal = dd(n);



# Get the parameters for zeros and poles
Zeros = b_q1; % zeros
Poles = a_q1; % poles

subplot(2,2,1) 
stem(n, imp_signal)
xlabel('n')
ylabel('Delta Function')
title('Impulse function');

subplot(2,2,2)
yy = filter(Poles,Zeros, imp_signal) ; % 
stem(n, yy)
xlabel('Frequency')
ylabel('Amplitude')
title('Output from filter');

%QUESTION 3: Doubling all delays
b_q3 = [b_q1(1) 0 b_q1(2) 0 b_q1(3)];
a_q3 = [a_q1(1) 0 a_q1(2) 0 a_q1(3)];
figure(3); zplane(b_q3, a_q3);
figure(4); freqz(b_q3, a_q3, 1024, Fs);
title(sprintf('Notch filter with doubled delays, fc=%dHz f-3dB=%dHz', f, f3db));

%QUESTION 4:
% Designing filter from analog counterparts 
fc = 1500;  % 1500 Hz is the -3dB point
Fs = 8000;
[b_q4,a_q4] = butter(4, fc/(Fs/2));
figure(5); zplane(b_q4, a_q4);


%QUESTION 5:
% EXTRACTING PARAMETERS:

% a. FOR FIRST FILTER from FIG 5
[x,y]=ginput(1)       % coordinates of the pole

ppn1 = [x+i*y; x-i*y]; % conjugate pair
zer1 = [-1 + 0*i];
zer2 = [-1 + 0*i];
zeros1 = [zer1, zer2];
ppn1(1,1)
%POLES:
%0.27792 + 0.63199i
%0.27792 - 0.63199i

# GET parameters for Filter 1:
poles_f1 = poly(ppn1); %poles filter 1
zeros_f1 = poly(zeros1); %poles filter 1
zplane(zeros_f1, poles_f1); % THE figure matches


% b. FOR SECOND FILTER from FIG 5
[v,w]=ginput(1)       % coordinates of the pole

ppn3 = [v+i*w; v-i*w]; % conjugate pair
zer3 = [-1 + 0*i];
zer4 = [-1 + 0*i];
zeros2 = [zer3, zer4];

# GET parameters for Filter 2: 
poles_f2 = poly(ppn3); %poles filter 1
zeros_f2 = poly(zeros2); %poles filter 1
zplane(zeros_f2, poles_f2); % THE figure matches Too! exciting!


% PUTTING TOGETHER THE PARAMETERS VIA CONVOLUTION:
numers_up = [conv(zeros_f1, zeros_f2)];
denoms_down = [conv(poles_f1, poles_f2)];
figure(6); zplane(numers_up, denoms_down); % THE figure matches Too! exciting!
figure(7); freqz( numers_up, denoms_down,1024, Fs);

% QUESTION 6: SYSTEM IN PARALLEL

% Put in paralell filter from Q1 and Q4 : Q1 + Q4
a_q12 = resize(a_q1, 1, 5)
b_q12 = resize(b_q1, 1, 5)

aa = [(a_q12 .+ a_q4)];
bb = [(b_q12 .+ b_q4)];

figure(8); zplane(bb, aa); % THE figure matches Too! exciting
figure(9); freqz( bb, aa,1024, Fs);

% QUESTION 7: SYSTEM IN CASCADE
aa = [conv(a_q1, a_q4)];
bb = [conv(b_q1, b_q4)];

figure(10); zplane(bb, aa); % THE figure matches Too! exciting
figure(11); freqz( bb, aa,1024, Fs);

% QUESTION 8: changing the direction of the real axis
za = (roots(aa));
change_sign = [1, -1, 1, -1, 1, -1];
change = reshape(change_sign, 6, 1);

za_real = real(za) .* change; % change to every other element


zaa = complex(real(za_real), imag(za));

zb = (roots(bb));
zb_real = real(zb) .* change;

zbb = complex(real(zb_real), imag(zb));

figure(12); zplane(zbb, zaa); % THE figure matches Too! exciting
figure(13); freqz( zbb, zaa,1024, Fs);