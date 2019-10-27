#'@title Constraint on trait variance when keeping slope fixed
#' 
#'@param allo an allometry object
#'
#'@details The constraint is quantified by calculating the decrease in trait variance that results when conditioning on one or more constraining parameters. 
#' 
#'@return Constraint on trait variance when keeping slope fixed
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

constraint.slope<-function (allometry.object)
{
  out<-var_a.b(allometry.object) + var_x.b(allometry.object)*(mean(allometry.object$slope^2)+var(allometry.object$slope))
  return(out)
}