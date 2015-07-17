#
#   Construct a local level model for the Nile data.
#
y <- datasets::Nile

struct <- StructTS(y, type="level")
if (struct$code != 0) stop("optimizer did not converge")

print(struct$coef)

cat("Transitional variance:", struct$coef["level"], "\n",
    "Observational variance:", struct$coef["epsilon"], "\n",
    "Initial level:", struct$model0$a, "\n")

tsdiag(struct)
