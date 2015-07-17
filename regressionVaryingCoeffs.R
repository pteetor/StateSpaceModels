#
# This is yet another model of the Nile River data,
# using the same explanatory variable, `x`, as the other
# regression recipe but letting its coefficient vary over time.
#
library(dlm)

y <- datasets::Nile
x <- cbind(c(rep(0,27), rep(1,length(y)-27)))

buildModReg <- function(v) {
  dV <- exp(v[1])
  dW <- exp(v[2:3])
  m0 <- v[4:5]
  dlmModReg(x, dV=dV, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])
lambda0Guess <- mean(diff(y), na.rm=TRUE)

parm <- c(log(varGuess), log(varGuess/5), log(varGuess/5),
          mu0Guess, lambda0Guess)
mle <- dlmMLE(y, parm=parm, build=buildModReg)

if (mle$convergence != 0) stop(mle$message)

model <- buildModReg(mle$par)

filt <- dlmFilter(y, model)
tsdiag(filt)
