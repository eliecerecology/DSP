# Eliecer Diaz


% 1. Generate an impulse response function of a running average filter with length SS. (Note: only two last digits of your usual SSS).

SS = 20;
a1 = 1;
a2 = rand;
x1 = randn(1, SS);

signal = a1*x1 + a2*x1 
as = [a1, a2];


output = filter(as,1, signal) ; % LTI system = filter()
stem(output)
title('output signal') 
xlabel('n') 
%2. The impulse response of a digital filter is the output arising from the unit impulse sequence defined as
SS = 20;

imp = [1; zeros(SS, 1)];
step = [1; ones(SS, 1)];
h_i = filter(1, 1, imp); % here for the impulse function 
h_step = filter(1, 1, step); % here for the step function 

subplot(1,2,1);
stem(0:SS, h_i);
title('impulse function');

subplot(1,2,2);
stem(h_step);
title('Step function');

% 3- delay signal

% I will delay impuse signal 3 steps (n -3), so 3 zeros
h_i_delay = filter([0,0,0, 1],1,imp(1:18));

subplot(1,2,1);
stem(0:SS, h_i);
title('Original impulse function');

subplot(1,2,2);
stem(h_i_delay)
title('Delayed impulse function');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Checking linearity
% y[n] = x[n]*e^n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%create a couple of random numbers
a1 = rand;
a2 = rand;
x1 = randn(1, SS);
x2 = randn(1, SS);
n = 1:SS;

%combined (left side of the proof): input
fcomb = a1*x1 + a2*x2
Left = fcomb.*exp(n)

% Right side: output
P1 = a1*x1.*exp(n)
P2 = a2*x2.*exp(n)

Right = P1 + P2

norm(Right - Left)
%yes it is linear since is 0, implying the left and right are the same!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 5. Checking Time shift Invariance
% y[n] = x[n]*e^n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% I will shift to the right using a zero
x = [0,x1(1:19)];
F = x1.*exp(n); %NON shifted
F_shifted = x.*exp(n); %shifted 1 place to the right

stem(F_shifted)

% Get time shifted output
timeShifted_F = [0,F(1:19)];

subplot(1,2,1);
stem(F_shifted);
title('Input shifted 1 step');

subplot(1,2,2);
stem(timeShifted_F)
title('Output Shifted 1 step');

F_shifted

% compare only the real parts of the signal...
norm( timeShifted_F- F_shifted )

%conclusion: It is time invariant

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 6. Checking causality?
% y[n] = x[n]*e^n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
new_n = -9:10; % My 20 points around 0, to see if there are values in that domain

x = randn(size(new_n)) .* double(new_n >= 0);
stem(new_n,x)

Filter = x.*exp(new_n);
stem(new_n,Filter)

norm(Filter(new_n < 0))
% YEP, it is causal, no values below 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 7. Stability?
% y[n] = x[n]*e^n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#ANSWER: there is an exponent, what makes the
#response not bounded (no limit), so the system is unstable by nature.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 8 . System difference equation is:
%    y[n] = x[n]-1.2*x[n-1]+x[n-2]-0.5*y[n-1]
% Generate SS points long impulse response function h[n].
% Is the system FIR or IIR? 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%the system us IIR because it has a y[n-3] component, so it has poles
SS = 20;
a = rand;
x1 = randn(1,SS);
x2 = randn(1,SS);

% input signal
signal = a*x1;
output = a*x2;
% impulse response function of a running average filter
% y[n] = (x[n]) - (1/2*x[n-1]) + (x[n-2]) + (0.5*y[n-1])

SS = 20;
n = 0:SS;
a = [1 -0.5];                  % ys hand side of difference equation
b = [1 -0.5 1];                % xs hand side of difference equation
x = [1; zeros(SS, 1)];         % this is the impulse function

k = filter(b,a,x);
stem(n,k)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 9. Write an m-function, which returns discrete delta function values for a given index vector. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = disdel(n, SS) % two parameters the length of the vector and the SS.
  % recycling same function point 8
  a = [1 -0.5 1];                     % left hand side of difference equation
  b = [1 0.5];                        % right hand side of difference equation
  x = [1; zeros(SS, 1)];
  k = filter(b,a,x);
  stem(k)
  k
 end;
 
 
pkg load symbolic
sys = tf([2 5 1],[1 3 5]);
h = pzplot(sys);
grid on