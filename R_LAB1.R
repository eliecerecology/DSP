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

x <- c(1,1,1,1,0,0,0,0)
fft(x)
fft(fft(x), inverse = TRUE)/length(x)
plot(fft(x))
## Slow Discrete Fourier Transform (DFT) - e.g., for checking the formula
fft0 <- function(z, inverse=FALSE) {
  n <- length(z)
  if(n == 0) return(z)
  k <- 0:(n-1)
  ff <- (if(inverse) 1 else -1) * 2*pi * 1i * k/n
  vapply(1:n, function(h) sum(z * exp(ff*(h-1))), complex(1))
}

relD <- function(x,y) 2* abs(x - y) / abs(x + y)
n <- 2^8
z <- complex(n, rnorm(n), rnorm(n))

## relative differences in the order of 4*10^{-14} :
summary(relD(fft(z), fft0(z)))
summary(relD(fft(z, inverse=TRUE), fft0(z, inverse=TRUE)))



#Checking around
library(REdaS)
N = 8
f = rep(1, N)

w = exp(-1i*2*pi/N)

for (i in 1:(N*N)){
  result = w^i
  print(i)
  print(result)
}




F <- matrix(0, N, N)
for (i in 1:N){
  for (j in 1:N){
    F[i, j] <- w^((i-1)*(j-1))
  }
}
F

