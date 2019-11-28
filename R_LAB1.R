S_rate = 8000
T <- 1/S_rate
t <- 2
N <- S_rate*2
n = seq(0, 2*S_rate, 0.25)

plot(n)
Amplitude = exp(-0.2*n)
plot(Amplitude)

t = seq(0, 8000, by = 2) #1:10000
length(t)
y = unlist(Map('+', 0.25*exp(-0.22*t)*sin(t),  runif(length(t))/100 ))
plot(t[1:100],y[1:100],type="l", xlab="time", ylab="Sine wave")

