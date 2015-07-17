#
#   Estimate the local level model using the dlm package
#
library(dlm)

y <- datasets::Nile

buildModPoly1 <- function(v) {
  dV <- exp(v[1])
  dW <- exp(v[2])
  m0 <- v[3]
  dlmModPoly(1, dV=dV, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])

parm <- c(log(varGuess), log(varGuess), mu0Guess)

mle <- dlmMLE(y, parm=parm, buildModPoly1)
if (mle$convergence != 0) stop(mle$message)

model <- buildModPoly1(mle$par)

cat("Observational variance:", model$V, "\n",
    "Transitional variance:", model$W, "\n",
    "Initial level:", model$m0, "\n")

filt <- dlmFilter(y, model)
tsdiag(filt)
