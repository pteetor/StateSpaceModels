#
# This is yet another model of the Nile River data,
# this time using two explanatory variables.
# `x1` is the same as the previous examples.
# 'x2' is a 5-year moving average of the data.
#
# The code uses the TTR package to compute the
# moving average, so you'll need that package
# to run this.
#
# Also, the example is a bit contrived because
# the moving average is not lagged.
#
library(dlm)

y <- datasets::Nile
x1 <- cbind(c(rep(0,27), rep(1,length(y)-27)))
x2 <- TTR::EMA(y, 5)
x2 <- mean(y[1:5])     # Overwrite NA values

x <- cbind(x1, x2)

#
# Parameters to model builder:
#   v[1] = log of variance of epsilon (error term)
#   v[2:4] = log of variance of mu, lambda1, lambda2
#   v[5:7] = initial values for mu, lambda1, lambda2
#
buildModReg <- function(v) {
  dV <- exp(v[1])
  dW <- exp(v[2:4])
  m0 <- v[5:7]
  dlmModReg(x, dV=dV, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])
lambda0Guess <- mean(diff(y), na.rm=TRUE)

parm <- c(log(varGuess),
          log(varGuess/5), log(varGuess/5), log(varGuess/5),
          mu0Guess, lambda0Guess, lambda0Guess )
mle <- dlmMLE(y, parm=parm, build=buildModReg)

if (mle$convergence != 0) stop(mle$message)

model <- buildModReg(mle$par)

filt <- dlmFilter(y, model)
tsdiag(filt)

filtered <- filt$m[-1,1] + x1*filt$m[-1,2] + x2*filt$m[-1,3]
both <- cbind(y=y, filtered=filtered)
plot(both, plot.type="single",
     col=c("black", "blue"), lty=c("solid", "dotted") )
