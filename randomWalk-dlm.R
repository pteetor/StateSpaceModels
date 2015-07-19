#
#   Estimation of random walk model via `dlm`
#
library(dlm)

y <- datasets::Nile

buildRandomWalk <- function(v) {
  dW <- exp(v[1])
  m0 <- v[2]
  dlmModPoly(order=1, dV=0, dW=dW, m0=m0)
}

varGuess <- var(diff(y), na.rm=TRUE)
mu0Guess <- as.numeric(y[1])

parm <- c(log(varGuess), mu0Guess)
mle <- dlmMLE(y, parm=parm, buildRandomWalk)
if (mle$convergence != 0) stop("Optimizer did not converge")

model <- buildRandomWalk(mle$par)

cat("Transitional variance:", model$W, "\n",
    "Initial level:", model$m0, "\n")

filt <- dlmFilter(y, model)
tsdiag(filt, main="Random Walk Model")
