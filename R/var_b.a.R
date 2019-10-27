#'@title Calculating the variance in slope conditioned on intercept
#' 
#'@param allo an allometry object
#' 
#'@return The variance in slope conditioned on intercept
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

var_b.a<-function (allometry.object)
{
  out<-var(allometry.object$slope)-(cov(allometry.object$intercept,allometry.object$slope)^2/var(allometry.object$intercept))
  return(out)
}