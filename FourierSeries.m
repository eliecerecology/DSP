k = [1:2:501]; % k series 
ak = 1./(pi*k);

f0 = 3; % 3 Hz
T0 = 1/f0; % Period
% this is addition of periodic 

t = 0:1/(5000*f0):3*T0; %
y = 0;

for m=1:length(k);
  x = ak(m).*cos(2*pi*f0*k(m)*t-pi/2);
  y = y + x;
  
  subplot(3,1,1)
  h = plot(t,x);
  hold on;
  
  subplot(3,1,2);
  h = plot(t, y);
  hold on;
  
  subplot(3,1,3);
  h = plot(t, y);
  xlabel('TIme (s)');
  pause
 end
  
