#
#   Estimation of the local linear trend model via dlm package
#
library(dlm)

y <- datasets::Nile

buildModPoly2 <- function(v) {
  dV <- exp(v[1])
  dW <- exp(v[2:3])
  m0 <- v[4:5]
  dlmModPoly(order=2, dV=dV, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])
lambda0Guess <- 0.0

parm <- c(log(varGuess), log(varGuess), log(varGuess),
          mu0Guess, lambda0Guess)
mle <- dlmMLE(y, parm=parm, buildModPoly2)

if (mle$convergence != 0) stop(mle$message)

model <- buildModPoly2(mle$par)

filt <- dlmFilter(y, model)
tsdiag(filt)
