#'@title Calculating the covariance between slope and size conditioned on intercept
#' 
#'@param allo an allometry object
#' 
#'@return The the covariance between slope and size conditioned on intercept
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

cov_b_x.a<-function (allometry.object)
{
  out<-cov(allometry.object$slope,allometry.object$x_mean)-(cov(allometry.object$intercept,allometry.object$slope)*cov(allometry.object$intercept,allometry.object$x_mean))/var(allometry.object$intercept)
  return(out)
}
