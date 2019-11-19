#'@title Constraint on trait variance when keeping slope and size fixed.
#' 
#'@param allo an allometry object
#'
#'@details The constraint is quantified by calculating the decrease in trait variance that results when conditioning on one or more constraining parameters. 
#' 
#'@return Constraint on trait variance when keeping slope and size fixed.
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

constraint.slope_and_size<-function (allometry.object)
{
  out<-((var(allometry.object$intercept)*var(allometry.object$slope)*var(allometry.object$x_mean)) + 
          2*(cov(allometry.object$intercept,allometry.object$slope)*cov(allometry.object$intercept,allometry.object$x_mean)*cov(allometry.object$slope,allometry.object$x_mean)) - 
          (cov(allometry.object$intercept,allometry.object$slope)^2)*var(allometry.object$x_mean) - 
          (cov(allometry.object$intercept,allometry.object$x_mean)^2)*var(allometry.object$slope) - 
          (cov(allometry.object$slope,allometry.object$x_mean)^2)*var(allometry.object$intercept))/((var(allometry.object$slope)*var(allometry.object$x_mean))-cov(allometry.object$slope,allometry.object$x_mean)^2)
  return(out)
}