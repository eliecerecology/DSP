n = 10;
for j = 1:n
  j = j/10;
  
  amp = ((1 - j)/(1 + j))^2

end

%% A system in frequency domain
% An example system:
% y[n] = (x[n] + x[n-1] + x[n-2])/3
bb = [0.97, - 0.97]%[1.0005, -0.0005]%ones(1,2)*0.97; %ones(1,3)/3; xs
aa = [1, -0.95]%[1, 0]; %[1, 0, 0]; % zeros because 2nd order system and there is no y[n-1] and y[n-2] terms

% Zeros and poles of H(z)
zz = roots(bb) % zeros of the system
pp = roots(aa) % poles of the system

% Poles are at the origin ... thus a FIR system!
zplane(bb,aa) % Argand's diagram
poly([0 0])   % you can also generate a polynomial if you know the roots
zplane(zz,pp) % an another way to call the zplane (by giving the roots)
bb
zz
freqz(bb, aa, 1024, 22050)          % frequency response, look documentation for freqz for more info