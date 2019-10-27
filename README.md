## About the R package allometry 

Which allometric parameters (intercept and slope) have the largest effect in explaining trait variance? And what is the effect of variation in body size on trait variance? Given a set of homologous allometric relationship from different populations or across species, these questions cannot be answered by estimating the variance of the parameters themselves. While the intercept and body size are on a ratio scale, the slope is not, which means it is difficult to meaningfully compare their variances directly (see Houle et al. 2011 for an excellent treatment of measurement theory in biology). 

One way around this problem is to quantify the effect of the observed allometric parameters and size on the trait variance. By using the trait variance as a common currency for the effect of the parameters, it is possible to evaluate their relative effect.  

The contribution of size and the allometric parameters (intercept and slope) to trait variance is not additive (i.e., not orthogonal, see equation 8 in Voje et al. 2014.). Interactions between the parameters need to be evaluated to estimate the relative contribution of the different parameters on the predicted trait variance. Both variation in size and allometric intercept can generate some variation in a trait by themselves, whereas variation in slope does not generate trait variation unless size show some variation.

![allometry evolution](https://github.com/klvoje/allometry/blob/master/extra/allometry_evolution.png=)

Figure 1: Graphical illustration of how variation in static allometric parameters produces trait variation across taxa. The gray ellipses represent phenotypic variation within a population and the ancestral population is indicated by a broken line surrounding this variation. The size data within the two taxa are centered on the global mean, represented by the vertical line. In A only body size generates variation in the trait across populations. In this case, static allometry predicts the evolutionary allometry perfectly. In B all variation across populations is due to change in the intercept. In C the slope has changed, but because the mean body size is the same there is no difference in the trait mean between populations. In D there are changes in both slope and body size, and their interaction cause a difference in trait means between populations

The `allometry` package quantifies the amount of (predicted) trait variance that remains when allometric parameters or body size (or combinations of these parameters) are held constant. How much residual variance is due to variation in allometric slopes and intercepts and size indicates their relative importance in explaining the evolution of the trait.

Estimating the residual variances indicates how the the different allometric parameters and size constrain the evolution of the trait. If the variation is considered to be additive genetic, this gives a direct measure of genetic constraint as it is equivalent to computing conditional evolvabilities (Hansen et al. 2003; Hansen and Houle 2008). Conditional evolvabilities give the trait evolvability that would result if stabilizing selection kept the mean of the conditioning parameter(s) constant (Hansen et al. 2003). 

For example, the additive genetic variance conditional on size gives the evolvability of the trait when size is under stabilizing selection and only intercept and slope are allowed to vary. The relative amount of residual variance that is due to variation in  slopes, intercepts and size (and their combinations) indicates their relative importance for trait evolution. A parameter with little effect on the trait evolution can be considered as a constraint on the evolution of the trait. 

The rationale and the statistics behind the methods in the `allometry` package can be found in Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. (2014). Allometric constraints and the evolution of allometry. Evolution, 68(3), 866–885. http://doi.org/10.1111/evo.12312


## Installation

Install the package from github using devtools:

```
install.packages("devtools")

devtools::install_github("klvoje/allometry")

require(allometry)
```


## Example

We have a dataset of 30 static allometries of eye-stalk length in stalk-eyed flies (Diopsidae) (Figure 2). 

<img src="https://github.com/klvoje/allometry/blob/master/extra/stalkeyed_fly.png" alt="fly" width="276"/>

![fly](https://github.com/klvoje/allometry/blob/master/extra/stalkeyed_fly.png =276x248)

The data (`stalk_eyed_flies`) is part of the `allometry` package. Let us have a look at the first five rows:

```
head(stalk_eyed_flies, 5)
     slope intercept   mean_x   mean_y
1 2.025080 0.8648173 7.358750 7.421250
2 1.945740 0.8635298 6.226196 7.509239
3 1.156718 0.6305446 6.973951 4.254902
4 1.844403 0.8797951 6.366790 7.965349
5 1.735460 0.7927259 6.607010 6.276558
```

The needed input for each species (each row) consists of the allometric slope and intercept and the mean size (`mean_x`) and the mean trait (`mean_y`). 

To analyze the data using `allometry`, we convert the data into a `allometry object`. To do so, we need to specify vectors for the slope, intercept and the average body and trait size:

```
indata<-as.allometry.object(stalk_eyed_flies$intercept, stalk_eyed_flies$slope, stalk_eyed_flies$mean_x, stalk_eyed_flies$mean_y)   
```

Note the printed message:

```
"The body size vector was centered on its mean, since this is an assumption in the downstream statistical procedures in the allometry package" 
```

All calculations in the `allometry` package assumes that the body size variable is centered around the global mean and that that all three variables follow a multivariate normal distribution. To ensure that the conditional variances estimated when using `allometry` are meaningful, an automatic centering on the global body size is performed when creating a `allometry object` using the `as.allometry.object` function. This global centering performes a linear transformation of the column of mean body sizes that affects the estimated intercepts. The slopes and trait means are not affected.

It is possible to compute all six relevant conditional variances on the estimated trait variance. The functions are `constraint.size`, `constraint.intercept`, `constraint.slope`, `constraint.allometry`, `constraint.intercept_and_size`, and `constraint.slope_and_size`. Each function only needs a `allometry object` to run, e.g.: 

```
constraint.size(indata)
[1] 3.079512 
``` 

This number means the residual variance in the predicted trait variance is 3.079512 when it is conditioned on size (i.e. the average size in not allows to change, while slope and intercept are allowed to change). This number is difficult to interpret without knowing the predicted trait variance, which can be obtained by running the `trait.variance` function:

```
trait.variance(indata)
[1] 6.63319
```  

Constraining the size variable reduces the predicted trait variance from 6.63319 to 3.079512, which is about a 46% reduction in trait variance.   

Most users might be most interested in using the wrapper function `fit.all.constraints`, which estimates all six constraints at the same time:

```
fit.all.constraints(indata)
$info
                         Value
Trait variance         6.63319
Number of allometries 30.00000

$constraints
                   % remaining trait variance
Size                                 46.42580
Intercept                            56.79689
Slope                                91.61384
Allometry                            55.39848
Intercept and size                    2.86776
Slope and size                       29.80281
```

The first part of the output gives the trait variance and the number of allometries in the analysis. The second part gives the remaining trait variance after estimating the six possible constraints. The combined effect of conditioning the estimated trait variance on both the intercept and size results in a residual variance of about 3%. Almost all of the trait variance can therefore be explained by these to variables alone, which means slope has only a marginal effect on the trait variance. Allometry represent conditioning the trait variance on the slope and intercept simultaneously. As we can see, this number is similar to the effect intercept, which suggests almost all of the variance accounted for by the slope must be due to interactions with the intercept. The slope seems to have little effect on the trait variance, which might indicate that this variable has little evolutionary potential or is difficult to change in a manner that has substantial effects on the evolution of the trait. 
   


## Author

Kjetil L. Voje <k.l.voje@gmail.com>


## References

Hansen, T. F. 2003. Is modularity necessary for evolvability? Remarks on the relationship  between pleiotropy and evolvability. Biosystems 69:83–94.

Hansen, T. F., W. S. Armbruster, M. L. Carlson, and C. Pélabon. 2003. Evolv- ability and genetic constraint in Dalechampia blossoms: genetic correlations and conditional evolvability. J. Exp. Zool. 296B:23–39.

Houle, D., Pélabon, C., Wagner, G. P., & Hansen, T. F. 2011. Measurement and Meaning in Biology. The Quarterly Review of Biology, 86:3–34. 

Voje, K. L., Hansen, T. F., Egset, C. K., Bolstad, G. H., & Pélabon, C. 2014. Allometric constraints and the evolution of allometry. Evolution, 68:866–885.


