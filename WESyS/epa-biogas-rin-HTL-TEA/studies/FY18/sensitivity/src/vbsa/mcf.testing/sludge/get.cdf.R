get.cdf <- function (numeric.factor, df) {
  Fn <- ecdf (numeric.factor)
  return (knots (Fn))
}

