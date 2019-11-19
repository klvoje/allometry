#'@title Calculate predicted trait variance.
#' 
#'@param allo an allometry object
#'
#'@details Assuming a static allometry between trait size y and body size x with body size centered on its mean and a multivariate normal distribution of the parameters (intercept , slope , size), the variance in trait size, Var[y], can be expressed as a function of variation in the underlying parameters of the static allometry: Var[y] = Var[bx+a] = Var[a] + 2E[b]Cov[a,x] + (E[b]^2)Var[x] + Var[b]Var[x] + Cov[b,x]^2.
#' 
#'@return The predicted trait variance.
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

trait.variance<-function(allometry.object)
{
  out<-var(allometry.object$intercept) + (2*mean(allometry.object$slope)*cov(allometry.object$intercept,allometry.object$x_mean)) + ((mean(allometry.object$slope^2))*var(allometry.object$x_mean)) + (var(allometry.object$slope)*var(allometry.object$x_mean)) + cov(allometry.object$slope,allometry.object$x_mean)^2
  return(out)
}