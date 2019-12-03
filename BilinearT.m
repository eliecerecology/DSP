pkg load signal

% define the Laplace variable 's'
s = tf('s');

% create our transfer function G(s)
G = 2/(s + 1);

%convert it to z-domain with Tustin methods
Gz = c2d(G, 1, 'tustin');

% sample time T=0.1 seconds
Gz = c2d(G, 0.1, 'tustin');

%checking the frequncy respo
bode(G, Gz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s = tf('s');

% create our transfer function G(s)
G = (1 -s) /(1 + s);

%convert it to z-domain with Tustin methods
Gz = c2d(G, 2, 'tustin');

bode(G, Gz);
step(G, Gz);

ampli = zeros(10,1);

j = 0.2
amp = ((1 - j)/(1 + j))^2


