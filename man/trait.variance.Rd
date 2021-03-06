% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/trait.variance.R
\name{trait.variance}
\alias{trait.variance}
\title{Calculate predicted trait variance.}
\usage{
trait.variance(allometry.object)
}
\arguments{
\item{allo}{an allometry object}
}
\value{
The predicted trait variance.
}
\description{
Calculate predicted trait variance.
}
\details{
Assuming a static allometry between trait size y and body size x with body size centered on its mean and a multivariate normal distribution of the parameters (intercept , slope , size), the variance in trait size, Var[y], can be expressed as a function of variation in the underlying parameters of the static allometry: Var[y] = Var[bx+a] = Var[a] + 2E[b]Cov[a,x] + (E[b]^2)Var[x] + Var[b]Var[x] + Cov[b,x]^2.
}
\references{
Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
}
\author{
Kjetil L. Voje
}
