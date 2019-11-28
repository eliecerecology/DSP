n = -10 : 10
%y = 1*dd(n-2) + 1*dd(n) - 2*dd(n-1);
y = 1*dd(n) - 1*dd(n-1)

stem(n, y)
xlabel('n')
ylabel('Delta Function')