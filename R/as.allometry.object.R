#'@title Make an 'allometry' object.
#' 
#'@param vector of allometric intercepts
#'
#'@param vector of allometric slopes
#'
#'@param vector of mean body size 
#'
#'@param vector of mean trait size 
#'
#'@description This function combines data into an 'allometry' object.
#'
#'@return a 'allometry' object.
#'
#'@author Kjetil L. Voje
#'
#'@references Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. \emph{Evoluton} 68:866–885.
#'
#'@export
#'

as.allometry.object<-function(intercept, slope, x_mean, y_mean){
  n.intercept <- length(intercept)
  n.slope <- length(slope)
  n.x_mean <- length(x_mean)
  n.y_mean <- length(y_mean)
  n.check <- c(n.intercept, n.slope, n.x_mean, n.y_mean)
  if (!all(n.check == n.intercept)) 
    stop("intercept, slope, x_mean and y_mean must be all of the same length") 
  if (round(mean(x_mean),13) != 0) {
    intercept<-y_mean-slope*(x_mean-mean(x_mean))
    x_mean<-x_mean-mean(x_mean) 
    print("The body size vector was centered on its mean, since this is an assumption in the downstream statistical procedures in the allometry package")
  }
  allometry.object<-list(intercept = intercept, slope = slope, x_mean=x_mean, y_mean = y_mean)
  
  class(allometry.object)<-"allometry object"
  return(allometry.object)
}
