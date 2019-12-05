pkg load signal

%Question 1:
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
bb = [1, -0.5, 0.06]; % 
aa = [1, -0.4];

zplane(bb,aa)

yy = filter(bb,aa,signal) ; % 
figure(2); stem(signal)
figure(1); stem(yy)
