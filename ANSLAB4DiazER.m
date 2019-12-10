pkg load signal

%QUESTION 1:
%    y[n] – 0,4y[n-1] = x[n] – 0,5x[n-1] + 0,06x[n-2]

% it implies an input vector (Xs) and output vector (Ys)

r = rand;
vecr = randn(1,100);

% generating signal
signal = r*vecr;

% system: y[n] – 0,4y[n-1] = x[n] – 0,5x[n-1] + 0,06x[n-2]
% re-written: y[n] = x[n] – 0,5x[n-1] + 0,06x[n-2] + 0,4y[n-1]

diff_eq = zeros(1, 101); % here to get an extra value index for y[n-1]
diff_eq(1, 1:100) = signal + [0,signal(1:99)] + [0,0,signal(1:98)]; % filling the x part side
diff_eq += diff_eq[0,diff_eq(1:99)]); % adding the y[n - a] element 

%pick some points
stem(nn, diff_eq(1, 1:50))

%HERE THE SYSTEM PARAMETERS
% now to implement with filters from equation: y[n] – 0,4y[n-1] = x[n] – 0,5x[n-1] + 0,06x[n-2]
%These are the parameters:
bb = [1, -0.5, 0.06]; % 
aa = [1, -0.4];

%QUESTION 2: The system is stable
zplane(bb,aa)


%QUESTION 3: zeros and poles
poles = roots(bb) 
% -1.00000 + 0.00000i
%  -0.50000 + 0.86603i
%  -0.50000 - 0.86603i

zeros = roots(aa)
%   0.40000
%   0.00000
%   0.00000
poly(roots(bb))

%QUESTION 4: Generate Frequency Response using sampling rate of 22050 s-1
freqz(bb, aa, 1024, 22050) 

% QUESTION 5: Determine if the system is IIR or FIR by testing it with impulse function.
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

y = 1*dd(n-2) + 1*dd(n) - 2*dd(n-1);

figure(1);stem(n, y)
xlabel('n')
ylabel('Delta Function')

yy = filter(bb,aa,y) ; % 
figure(2); stem(yy)

%Question 6 and 7:
z1 = (0.7 + 0.7i);
z2 = (0.7 - 0.7i);
Zeros = [z1, z2];
p1 = (-0.7 + 0.7i);
p2 = (-0.7 - 0.7i);
Poles = [p1, p2];

poly(Zeros)
 %1.00000  -1.40000   0.98000
poly(Poles)
%1.00000   1.40000   0.98000


%Question 8:
freqz(Poles, Zeros, 1024, 22050) 

% QUestion 9:
% Just for fun, filter a white noise audio sample with the filter and describe 
%how your system changes the signal. Use a reasonable sampling rate (8000, 11025, 22050, 44100) in your test.

%create a signal (noisy)
fs = [8000, 11025, 22050, 44100];
f = 622;
n = 0:(1/fs(1)):1;
n = n(1:100);

signal1 = sin(2*pi*f*n);
plot(signal1)

% I found a better function to add noise
n = 0:(1/fs(1)):1;
n = n(1:100);
z1 = signal1 + rand(1, length(n));
n = 0:(1/fs(2)):1;
n = n(1:100);
z2 = signal1 + rand(1, length(n));
n = 0:(1/fs(3)):1;
n = n(1:100);
z3 = signal1 + rand(1, length(n));
n = 0:(1/fs(4)):1;
n = n(1:100);
z4 = signal1 + rand(1, length(n));


subplot(2,2,1);
y8000 = filter(Poles,Zeros,z1); % 
stem(y8000)
title('Output filter fs = 8000Hz');

subplot(2,2,2);
y11025 = filter(Poles,Zeros,z2); % 
stem(y11025)
title('Output filter fs = 11025Hz');

subplot(2,2,3);
y44100 = filter(Poles,Zeros,z2); % 
stem(y44100)
title('Output filter fs = 44100Hz');

subplot(2,2,4);
y22050 = filter(Poles,Zeros,z2); % 
stem(y22050)
title('Output filter fs = 22050Hz');
