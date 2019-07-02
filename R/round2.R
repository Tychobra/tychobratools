#' Standard rounding rather than R's round function which uses bankers rounding
#'
#' @params x Number to be rounded
#' @params x Decimal places to be rounded to
#' 
#' @return The number rounded to the nearest integer where .5 is always rounded up
#'
#' @examples
#' x <- 2.3
#' n <- 0
#' round2(x, n)
#' 
#' x <- 1.85
#' n <- 1
#' round2(x, n)
#' 
#' x <- 10.988
#' n <- 2
#' round2(x, n) 
round2 <- function(x, n) {
  posneg <- sign(x)
  z <- abs(x) * 10 ^ n + 0.5
  z <- trunc(z)
  z <- z / 10 ^ n
  z * posneg
}
