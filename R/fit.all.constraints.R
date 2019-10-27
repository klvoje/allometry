#'@title Calculating all possible (six) constraints at the same time.
#' 
#'@param allo an allometry object
#'
#'@details A wrapper function for investigating all possible (six) combinations of constraints at the same time.
#' 
#'@return First part of the output gives the observed trait variance and the number of allometries in the dataset. The second
#' part of the output gives predicted total trait variance that remains when conditioning on different parameters in percent. 
#' E.g. a value of 50 means 50% of the predicted trait variance remains after conditioning on specific parameter(s).
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

fit.all.constraints<-function(allometry.object)
{
  trait_var<-trait.variance(allometry.object)
  size<-constraint.size(allometry.object)
  intercept<-constraint.intercept(allometry.object)
  slope<-constraint.slope(allometry.object)
  allometry<-constraint.allometry(allometry.object)
  intercept_size<-constraint.intercept_and_size(allometry.object)
  slope_size<-constraint.slope_and_size(allometry.object)
  
  summary.out<-as.data.frame(c(trait_var, round(length(allometry.object$intercept), 0)))
  rownames(summary.out)<-(c("Trait variance", "Number of allometries"))
  colnames(summary.out)<-("Value")
  
  output<-(as.data.frame(c(size, intercept, slope, allometry, intercept_size, slope_size))/trait_var)*100
  rownames(output)<-c("Size", "Intercept", "Slope", "Allometry", "Intercept and size", "Slope and size")
  colnames(output)<-("% remaining trait variance")
  
  out<- list("info" = summary.out, "constraints" = output)
  return(out)
  
}