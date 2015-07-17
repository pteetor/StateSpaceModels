#
#   This code constructs a local linear trend model for the Nile River data.
#
y <- datasets::Nile

struct <- StructTS(y, type="trend")
if (struct$code != 0) stop("optimizer did not converge")

print(struct$coef)

cat("Transitional variance:", struct$coef["level"], "\n",
    "Slope variance:", struct$coef["slope"], "\n",
    "Observational variance:", struct$coef["epsilon"], "\n",
    "Initial level of mu:", struct$model0$a[1], "\n",
    "Initial level of lambda:", struct$model0$a[2], "\n" )

tsdiag(struct)
