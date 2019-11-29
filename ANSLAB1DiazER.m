% 1. Create an index-vector from -9 to 20
clear all
vector = [-9:20];

% 2. Use the previous vector to generate a unit step function
function step(ind)
  ind(ind >= 0) = 1;
  ind(ind < 0) = 0;

  ind
  
 end;

 %3. create an impulse function
function y = dd(x)
  % x is a vector
  % We create an output vector of only 0 (our default value)
  y = zeros(1, length(x)); 

  % We find indexes of input values equal to 0,
  % and make them 1
  y(find(x==0)) = 1;
end;

%4. Create a data sequence: (see exercise 1.1 a)
%x1[n] = d[n-2] + d[n] - 2d[n-1]

% here the sequence 
n = -10 : 10 

y = 1*dd(n-2) + 1*dd(n) - 2*dd(n-1);

stem(n, y)
xlabel('n')
ylabel('Delta Function')


%5. Create a data sequence: (see exercise 1.1 b)
% x2[n] = u[n+2] - u[n-2]
n = -20 : 20 

function y = step(x)
  % x is a vector
  % We create an output vector of only 0 (our default value)
  %y = zeros(1, length(x)); 

  % We find indexes of input values equal to 0,
  % and make them 1
  y(find(x >= 0)) = 1;
  y(find(x < 0)) = 0;
end;

y = step(n+2) - step(n-2); 

stem(n, y)
xlabel('n')
ylabel('Step Function')
% 6.Create a data sequence: (see exercise 1.1 c)
# x3[n] = cos(0,1 pi n)

n = -20 : 20 
y = cos(0.1*pi*n);
stem(n,y)
xlabel('n')
ylabel('Trig Function')
%7. Create a data sequence: (see exercise 1.1 d)
% x4[n] = cos(2 pi n)

n = -20 : 20 
y = cos(2*pi*n);
stem(n,y)
xlabel('n')
ylabel('Trig Function')
% 8. Use your index-vector of Question 1 to produce the sampled data vector of a sine wave with
% - Amplitude of 0.5
% - Signal frequency of  SSS Hz
# - Sampling rate of 2000 s-1

% assuming the function is something like: Asin(2*pi*f*t + phi)
n = -9:20
Amplitude = 0.5;
S_rate = 2000;
T = 1/S_rate;
t = 1;
N = S_rate*t;

freq = 622;
omega = 2*pi*freq;
t_seq = n*T;

y = sin(omega*t_seq);
plot(n, y)

% 9 . Create a data sequence:
%    x[n] = u[n]*s[n] + 2*d[n-4]
%    where, u[n] = unit step function
%    s[n] = previous, sampled sine
%    d[n] = delta function
n = -9:20

% x[n] = u[n]*s[n] + 2*d[n-4]
u = step(n); % step 
s = sin(omega*t_seq); % sine
d = 2*dd(n-4)

y = u.*s + d;

% 10. stem
stem(n, y)
xlabel('n')
ylabel(' u[n]*s[n] + 2*d[n-4] function')

% 11.


%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = 8000; %8 Khz sampling frequency
f = 2; % 2Hz signal frquency
t = 0:1/fs:20-1/fs; %10sec sampleshttp://www.blogger.com/img/blank.gif

%genrating noise
a = 0;
b = 0.010;
noise = (b-a).*rand(length(n),1) + a;


x = 0.25*exp(-t*0.25).*sin(2*pi*f*t) .+ noise ;
%plot(t,x)


sound(x)

