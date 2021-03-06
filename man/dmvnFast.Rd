\name{dmvnFast}
\alias{dmvnFast}
\title{Fast computation of the multivariate normal density.}
\usage{
  dmvnFast(X, mu, sigma, log = FALSE, isChol = FALSE,
    verbose = TRUE)
}
\arguments{
  \item{X}{matrix n by d where each row is a d dimensional
  random vector. Alternatively \code{X} can be a
  d-dimensional vector.}

  \item{mu}{vector of length d, representing the mean the
  distribution.}

  \item{sigma}{covariance matrix (d x d). Alternatively is
  can be the cholesky decomposition of the covariance. In
  that case isChol should be set to TRUE.}

  \item{isChol}{boolean set to true is \code{sigma} is the
  cholesky decomposition of the covariance matrix.}

  \item{log}{boolean set to true the logarithm of the pdf
  is required.}

  \item{verbose}{if TRUE (which is the default) the
  function will complain if \code{sigma} has zeros on the
  main diagonal.}
}
\value{
  a vector of length n where the i-the entry contains the
  pdf of the i-th random vector.
}
\description{
  Fast computation of the multivariate normal density.
}
\examples{
N <- 100
d <- 5
mu <- 1:d
X <- t(t(matrix(rnorm(N*d), N, d)) + mu)
tmp <- matrix(rnorm(d^2), d, d)
mcov <- tcrossprod(tmp, tmp)
myChol <- chol(mcov)

head(dmvnFast(X, mu, mcov), 10)
head(dmvnFast(X, mu, myChol, isChol = TRUE), 10)

\dontrun{
# Performance comparison
library(mvtnorm)
library(microbenchmark)

a <- cbind(
      dmvnFast(X, mu, mcov),
      dmvnFast(X, mu, myChol, isChol = TRUE),
      dmvnorm(X, mu, mcov))

# Check if we get the same output as dmvnorm()
a[ , 1] / a[, 3]
a[ , 2] / a[, 3]

microbenchmark(dmvnFast(X, mu,
                         myChol,
                          isChol = TRUE),
               dmvnFast(X, mu, mcov),
               dmvnorm(X, mu, mcov))
}
}
\author{
  Matteo Fasiolo <matteo.fasiolo@gmail.com>
}

