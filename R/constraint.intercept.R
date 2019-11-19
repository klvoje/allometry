#'@title Constraint on trait variance when keeping intercept fixed
#' 
#'@param allo an allometry object
#'
#'@details The constraint is quantified by calculating the decrease in trait variance that results when conditioning on one or more constraining parameters. 
#' 
#'@return Constraint on trait variance when keeping intercept fixed
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

constraint.intercept<-function (allometry.object)
{
  out<-var_x.a(allometry.object)*((mean(allometry.object$slope)^2) + var_b.a(allometry.object)) + cov_b_x.a(allometry.object)^2 
  return(out)
}