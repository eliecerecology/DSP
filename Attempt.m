 
n = -5 : 5;
y = heaviside(n+2) - heaviside(n-2);

clf
stem(n, y)
axis([-5 5 -1 1])