## About the R package allometry 

Under the logarithmic (and thus linear) version of the allometric model (log(Y) = log(a) + b × log(X)), the variance in the trait mean (log(Y)) among populations or species are the result of changes in the intercept and an interaction between changes in body size and the allometric slope. Given a data set of several estimated allometries, the `allometry` package allows investigating the relative effects of the allometric parameters (intercept and slope) and body size in explaining the variance in the trait mean.

Why not compare the variance of the allometric parameters and body size directly? The challenge is that the intercept and body size are on a ratio scale but the slope is not. Comparing the variance of the slope and intercept in a set of allometries are therefore not straight forward as their variances are not directly comparable (see Houle et al. 2011 for an excellent treatment of measurement theory in biology). One way around this problem is to quantify the effect of the observed allometric parameters and size by using the trait variance as a common currency. This can be done by calculating the conditional variance of the trait mean on mean body size, intercept, and slope, either alone or in combination, which is what the `allometry` package contains functions to do. 

The rationale and the statistics behind the methods in the `allometry` package can be found in Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. Evolution, 68(3), 866–885. http://doi.org/10.1111/evo.12312

<p align="center">
<img src="https://github.com/klvoje/allometry/blob/master/extra/allometry_evolution.png" alt="allometry evolution" class="center" width="600"/>
</p>

**Figure 1** _(from Voje et al. 2014): Graphical illustration of how variation in static allometric parameters produces trait variation across taxa. The gray ellipses represent phenotypic variation within a population and the ancestral population is indicated by a broken line surrounding this variation. The size data within the two taxa are centered on the global mean, represented by the vertical line. In A only body size generates variation in the trait across populations. In this case, static allometry predicts the evolutionary allometry perfectly. In B, all variation across populations is due to change in the intercept. In C the slope has changed, but because the mean body size is the same there is no difference in the trait mean between populations. In D there are changes in both slope and body size, and their interaction cause a difference in trait means between populations._

The `allometry` package quantifies the amount of (predicted) trait variance that remains when allometric parameters or body size (or combinations of these parameters) are held constant. How much residual variance is due to variation in allometric slopes and intercepts and size indicates their relative importance in explaining the evolution of the trait.

One interpretation of the estimated residual variances is that they indicate how the different allometric parameters and size constrain the evolution of the trait. If the variance is considered to be additive genetic, this gives a direct measure of genetic constraint as it is equivalent to computing conditional evolvabilities (Hansen et al. 2003; Hansen and Houle 2008). Conditional evolvabilities give the trait evolvability that would result if stabilizing selection kept the mean of the conditioning parameter(s) constant. 

For example, the additive genetic variance conditional on size gives the evolvability of the trait when size is under stabilizing selection and only intercept and slope are allowed to vary. The relative amount of residual variance that is due to variation in slopes, intercepts and size (and their combinations) indicates their relative importance for trait evolution. A parameter with little effect on the trait evolution can be considered as a constraint on the evolution of the trait. 


## Installation

Install the package from github using devtools:

```
install.packages("devtools")

devtools::install_github("klvoje/allometry")

require(allometry)
```


## Example

We have a dataset of static allometries for male eye-stalk length in 30 species of stalk-eyed flies (Diopsidae). Eye-stalks are projections from the sides of the head with the eyes at the end. Different species have different eye-stalk lengths (The data was originally published in Baker and Wilkinson 2001, Evolution and reanalyzed in Voje and Hansen 2013, Evolution).  

<p align="center">
<img src="https://github.com/klvoje/allometry/blob/master/extra/stalkeyed_fly.png" alt="fly" class="center" width="450"/>
</p>

The data (`stalk_eyed_flies`) are part of the `allometry` package. Let us have a look at the first five rows:

```
head(stalk_eyed_flies, 5)
     slope intercept   mean_x   mean_y
1 2.025080 0.8648173 1.995890 2.004348
2 1.945740 0.8635298 1.828765 2.016134
3 1.156718 0.6305446 1.942182 1.448072
4 1.844403 0.8797951 1.851095 2.075101
5 1.735460 0.7927259 1.888131 1.836822
```

The needed input for each species (each row) consists of the allometric slope and intercept and the (log) mean size (`mean_x`) and the (log) mean trait (`mean_y`). 

To analyze the data using `allometry`, we convert the data into an `allometry object`. To do so, we need to specify vectors for the slope, intercept and the average body and trait size:

```
indata<-as.allometry.object(stalk_eyed_flies$intercept, stalk_eyed_flies$slope, stalk_eyed_flies$mean_x, stalk_eyed_flies$mean_y)   
```

Note the printed message:

```
"The body size vector was centered on its mean, since this is an assumption in the downstream statistical procedures in the allometry package" 
```

All calculations in the `allometry` package assumes that the body size variable is centered around the global mean and that that all three variables follow a multivariate normal distribution. To ensure that the conditional variances estimated using the `allometry` package are meaningful, an automatic centering on the global body size (i.e. the mean of the mean body sizes) is performed when creating an `allometry object` using the `as.allometry.object` function. This global centering performs a linear transformation of the column of (log) mean body sizes that affects the estimated intercepts. The slopes and trait means are not affected.

It is possible to compute all six relevant conditional variances on the estimated trait variance. The functions are `constraint.size`, `constraint.intercept`, `constraint.slope`, `constraint.allometry`, `constraint.intercept_and_size`, and `constraint.slope_and_size`. Each function only needs a `allometry object` to run, e.g.: 

```
constraint.size(indata)
[1] 0.1590035
``` 

This number means the residual variance in the predicted trait variance is 0.1590035 when it is conditioned on size (i.e. the average size in not allows to change, while slope and intercept are allowed to change). This number is difficult to interpret without knowing the predicted trait variance, which can be obtained by running the `trait.variance` function:

```
trait.variance(indata)
[1] 0.3111499
```  

Constraining the size variable reduces the predicted trait variance from 0.3111499 to 0.1590035, which represents a 51% reduction in trait variance.   

Most users might be most interested in using the wrapper function `fit.all.constraints`, which estimates all six constraints (all possible conditional variances) at the same time:

```
fit.all.constraints(indata)
$info
                           Value
Trait variance         0.3111499
Number of allometries 30.0000000

$constraints
                   % remaining trait variance
Size                                51.101880
Intercept                           31.874223
Slope                               70.085715
Allometry                           31.904082
Intercept and size                   1.669501
Slope and size                      35.559221
```

The first part of the output gives the predicted trait variance and the number of allometries in the analysis. The second part gives the remaining (i.e. residual) trait variance after estimating the six possible constraints. The first three entries represent the remaining variance when conditioning on each of the three parameters (body size, intercept and slope) in isolation. However, the contribution of size and the allometric parameters (intercept and slope) to trait variance is not additive (i.e., not orthogonal, see equation 8 in Voje et al. 2014.). Interactions between the parameters therefore need to be evaluated to estimate the relative contribution of the different parameters on the predicted trait variance.

The combined effect of conditioning the estimated trait variance on both the intercept and size results in a residual variance of about 1.7%. Almost all of the trait variance can therefore be explained by these to variables alone, which means slope has only a marginal effect on the trait variance. Allometry represent conditioning the trait variance on the slope and intercept simultaneously. As we can see, this number is similar to the effect intercept, which suggests almost all of the variance accounted for by the slope must be due to interactions with the intercept. The slope seems to have little effect on the trait variance, which might indicate that this variable has little evolutionary potential or is difficult to change in a manner that has substantial effects on the evolution of the trait. 
   


## Author

Kjetil L. Voje <k.l.voje@gmail.com>


## References

Baker, R. H. and G. S. Wilkinson. 2001. Phylogenetic analysis of sexual dimorphism and eye-span allometry in stalk-eyed flies (Diopsidae). Evolution 55, 1373–1385.

Hansen, T. F., W. S. Armbruster, M. L. Carlson, and C. Pélabon. 2003. Evolvability and genetic constraint in Dalechampia blossoms: genetic correlations and conditional evolvability. J. Exp. Zool. 296B:23–39.

Hansen, T. F. and D. Houle. 2008. Measuring and comparing evolvability and constraint in multivariate characters. J Evolution Biol 21, 1201–1219.
  
Houle, D., Pélabon, C., Wagner, G. P., & Hansen, T. F. 2011. Measurement and Meaning in Biology. The Quarterly Review of Biology, 86:3–34. 

Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. 2014. Allometric constraints and the evolution of allometry. Evolution, 68:866–885.


  


