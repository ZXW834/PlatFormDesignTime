
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PlatFormDesignTimeTrend

<!-- badges: start -->
<!-- badges: end -->

The goal of PlatFormDesignTimeTrend is to simulates the multi-arm multi-stage or
platform trial with Bayesian approach using the ‘rstan’ package, which
provides the R interface for to the stan. The package uses Thall’s and
Trippa’s randomisation approach for Bayesian adaptive randomisation. In
addition, the time trend problem of platform trial can be studied in
this package. There is a demo for multi-arm multi-stage trial for two
different null scenario in this package.

## Installation

You can install the development version of PlatFormDesignTimeTrend like so:

``` r
# install.packages("PlatFormDesignTimeTrend")
# install_github("ZXW834/PlatFormDesignTime)
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(PlatFormDesignTimeTrend)
#> Loading required package: rstan
#> Loading required package: StanHeaders
#> Loading required package: ggplot2
#> rstan (Version 2.21.2, GitRev: 2e1f913d3ca3)
#> For execution on a local, multicore CPU with excess RAM we recommend calling
#> options(mc.cores = parallel::detectCores()).
#> To avoid recompilation of unchanged Stan programs, we recommend calling
#> rstan_options(auto_write = TRUE)
## basic example code
Trial.simulation (ntrials = 10,
trial.fun = simulatetrial,
 input.info = list(
   response.probs = c(0.4, 0.4),
   ns = c(30, 60, 90, 120, 150),
   max.ar = 0.75,
   rand.type = "Urn",
   max.deviation = 3,
   model.inf = list(
     model = "tlr",
     ibb.inf = list(
       pi.star = 0.5,
       pess = 2,
       betabinomialmodel = ibetabinomial.post
     ),
     tlr.inf = list(
       beta0_prior_mu = 0,
       beta1_prior_mu = 0,
       beta0_prior_sigma = 2.5,
       beta1_prior_sigma = 2.5,
       beta0_df = 7,
       beta1_df = 7,
       reg.inf =  "main",
       variable.inf = "Fixeffect"
     )
   ),
   Stopbound.inf = Stopboundinf(
     Stop.type = "Early-Pocock",
       Boundary.type = "Symmetric",
         cutoff = c(0.99, 0.01)
         ),
   Random.inf = list(
     Fixratio = FALSE,
     Fixratiocontrol = NA,
     BARmethod = "Thall",
     Thall.tuning.inf = list(tuningparameter = "Fixed",  fixvalue = 1)
   ),
   trend.inf = list(
     trend.type = "step",
     trend.effect = c(0, 0),
     trend_add_or_multip = "mult"
   )
 ),
 cl = 2)
#> $result
#> $result$`0404stage5`
#> $result$`0404stage5`[[1]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.9168 16  2  14   5        0    -1.896     1.238    0.824
#> 2 0.8184 22  6  38  15        0    -0.978     0.542    0.344
#> 3 0.6788 30 10  60  23        0    -0.712     0.235    0.232
#> 4 0.6816 39 14  81  33        0    -0.585     0.207    0.166
#> 5 0.5328 49 19 101  40        0    -0.461     0.032    0.121
#> 
#> $result$`0404stage5`[[2]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.3532 15  6  15   5        0    -0.441    -0.276    0.547
#> 2 0.4372 35 12  25   8        0    -0.669    -0.092    0.298
#> 3 0.1596 53 18  37   9        0    -0.674    -0.469    0.223
#> 4 0.4020 76 24  44  13        0    -0.781    -0.099    0.182
#> 5 0.2292 93 32  57  16        0    -0.658    -0.285    0.137
#> 
#> $result$`0404stage5`[[3]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.6388 14  6  16   8        0    -0.268     0.265    0.558
#> 2 0.8232 25  9  35  17        0    -0.574     0.505    0.288
#> 3 0.6456 32 12  58  24        0    -0.526     0.170    0.200
#> 4 0.8620 43 15  77  35        0    -0.616     0.431    0.152
#> 5 0.8764 50 18 100  46        0    -0.571     0.409    0.122
#> 
#> $result$`0404stage5`[[4]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.6484 15  5  15   6        0    -0.700     0.276    0.551
#> 2 0.8196 25  9  35  17        0    -0.564     0.496    0.282
#> 3 0.7648 32 10  58  22        0    -0.826     0.327    0.205
#> 4 0.6504 39 13  81  30        0    -0.695     0.157    0.182
#> 5 0.5664 50 17 100  35        0    -0.675     0.052    0.133
#> 
#> $result$`0404stage5`[[5]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.8416 14  7  16  11        0     0.024     0.757    0.567
#> 2 0.6044 21 10  39  20        0    -0.098     0.150    0.288
#> 3 0.3540 33 16  57  25        0    -0.076    -0.169    0.196
#> 4 0.4164 53 24  67  29        0    -0.194    -0.079    0.130
#> 5 0.6484 71 30  79  36        0    -0.310     0.126    0.108
#> 
#> $result$`0404stage5`[[6]]
#>     PP1C  nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.3540  15  7  15   6        0    -0.145    -0.263    0.528
#> 2 0.1916  35 15  25   8        0    -0.291    -0.466    0.299
#> 3 0.0860  57 27  33  11        0    -0.110    -0.588    0.207
#> 4 0.3512  80 31  40  14        0    -0.471    -0.157    0.167
#> 5 0.5496 101 40  49  20        0    -0.428     0.048    0.125
#> 
#> $result$`0404stage5`[[7]]
#>     PP1C  nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.4232  14  4  16   4        0    -0.989    -0.149    0.641
#> 2 0.0740  33 13  27   6        0    -0.449    -0.824    0.323
#> 3 0.1756  56 20  34   9        0    -0.585    -0.441    0.224
#> 4 0.1144  79 32  41  12        0    -0.390    -0.495    0.170
#> 5 0.1020 101 39  49  14        0    -0.462    -0.464    0.139
#> 
#> $result$`0404stage5`[[8]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.8804 15  8  15  11        0     0.153     0.839    0.559
#> 2 0.6492 23 10  37  18        0    -0.268     0.203    0.280
#> 3 0.4560 35 15  55  23        0    -0.285    -0.037    0.198
#> 4 0.5476 51 20  69  28        0    -0.438     0.045    0.144
#> 5 0.3532 65 28  85  34        0    -0.286    -0.123    0.108
#> 
#> $result$`0404stage5`[[9]]
#>     PP1C  nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.1308  15  7  15   4        0    -0.180    -0.840    0.565
#> 2 0.0356  37 20  23   7        0     0.153    -0.985    0.303
#> 3 0.2460  59 29  31  13        0    -0.034    -0.308    0.205
#> 4 0.3924  82 39  38  17        0    -0.096    -0.110    0.154
#> 5 0.1352 100 47  50  19        0    -0.118    -0.380    0.119
#> 
#> $result$`0404stage5`[[10]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.4832 15  5  15   5        0    -0.713    -0.005    0.542
#> 2 0.3972 30 12  30  11        0    -0.419    -0.148    0.283
#> 3 0.2116 48 20  42  14        0    -0.334    -0.360    0.184
#> 4 0.0956 70 29  50  15        0    -0.349    -0.510    0.155
#> 5 0.0980 93 37  57  17        0    -0.416    -0.454    0.129
#> 
#> 
#> 
#> $OPC
#>            Type.I.Error.or.Power    Bias      rMSE N.per.arm.1 N.per.arm.2
#> 0404stage5                     0 -0.1039 0.3056068        77.3        72.7
#>            Survive.per.arm.1 Survive.per.arm.2   N
#> 0404stage5              30.7              27.7 150
#> 
#> $Nameofsaveddata
#> $Nameofsaveddata$nameTable
#> [1] "TABLENOTRENDEARLY-POCOCKSYMMETRICTHALL.RData"
#> 
#> $Nameofsaveddata$nameData
#> [1] "DATANOTRENDEARLY-POCOCKSYMMETRICTHALL.RData"
```
