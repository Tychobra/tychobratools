% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/round2.R
\name{round2}
\alias{round2}
\title{Standard rounding rather than R's round function which uses bankers rounding}
\usage{
round2(x, n)
}
\arguments{
\item{x}{Number to be rounded}

\item{n}{Decimal places to be rounded to}
}
\value{
The number rounded to the nearest integer where .5 is always rounded up
}
\description{
Standard rounding rather than R's round function which uses bankers rounding
}
\examples{
x <- 2.3
n <- 0
round2(x, n)

x <- 1.85
n <- 1
round2(x, n)

x <- 10.988
n <- 2
round2(x, n) 
}
