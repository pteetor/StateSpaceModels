#
# This example uses an explanatory variable to account for a change in the river's level.
# The example is taken from the excellent paper by Petris and Petrone.[^PetrisPetrone2011]
# 
# The explanatory variable is quite simple.
# It has value 0.0 *before* the Aswan Dam was built and value 1.0 *after* the dam was built.
# The dam had a significant effect on the river's level,
# so it makes sense as an explanatory variable.
# 
# Here, the explanatory variable is called $x$.
# We can construct it "manually" from our knowledge of the data:
# the dam was built after the 27th observation.
#
library(dlm)

y <- datasets::Nile
x <- cbind(c(rep(0,27), rep(1,length(y)-27)))

buildModReg <- function(v) {
  dV <- exp(v[1])
  dW <- c(exp(v[2]), 0)
  m0 <- v[3:4]
  dlmModReg(x, dV=dV, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])
lambdaGuess <- mean(diff(y), na.rm=TRUE)

parm <- c(log(varGuess), log(varGuess/5), mu0Guess, lambdaGuess)
mle <- dlmMLE(y, parm=parm, build=buildModReg)

if (mle$convergence != 0) stop(mle$message)

model <- buildModReg(mle$par)

filt <- dlmFilter(y, model)
tsdiag(filt)
