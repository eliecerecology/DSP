
%sinusoids of the same frequency

fs = 50*100;
Ts = 1/fs;
t = 0:Ts:5*(1/100);
x1 = 5*cos(2*pi*100*t+(pi/3));
x2 = 4*cos(2*pi*100*t-(pi/4));
x3 = x1 + x2;

%figures:
figure(1)
subplot(3,2,1)
h = plot(t, x1); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");

subplot(3,1,2)
h = plot(t, x2); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");

subplot(3,1,3)
h = plot(t, x3); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");

%sinusoids of the DIFFERENT frequency
fs = 50*100;
Ts = 1/fs;
t = 0:Ts:5*(1/100);
x1 = 5*cos(2*pi*100*t+(pi/3));
x2 = 4*cos(2*pi*200*t-(pi/4));
x3 = x1 + x2;

%figures:
figure(2)
subplot(3,1,1)
h = plot(t, x1); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");

subplot(3,1,2)
h = plot(t, x2); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");

subplot(3,1,3)
h = plot(t, x3); box off; grid on;
xlabel("Time (s)");
ylabel("x1(t) Amplitude");
