#'@title Calculating the variance in intercept conditioned on slope
#' 
#'@param allo an allometry object
#' 
#'@return The variance in intercept conditioned on slope
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

var_a.b<-function (allometry.object)
{
  out<-var(allometry.object$intercept)-(cov(allometry.object$intercept,allometry.object$slope)^2/var(allometry.object$slope))
  return(out)
}