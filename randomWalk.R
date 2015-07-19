#
#   Estimation of random walk model via StructTS function
#
#   You can fit a random walk model using `StructTS`
#   by fitting a local level model while forcing the
#   observational variance to be zero.
#
y <- datasets::Nile

struct <- StructTS(y, type="level",
                   fixed=c(0, NA))

tsdiag(struct, main="Random Walk Model")
