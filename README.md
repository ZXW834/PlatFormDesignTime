
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PlatFormDesignTimeTrend

<!-- badges: start -->
<!-- badges: end -->

The goal of PlatFormDesignTimeTrend is to simulates the multi-arm
multi-stage or platform trial with Bayesian approach using the ‘rstan’
package, which provides the R interface for to the stan. The package
uses Thall’s and Trippa’s randomisation approach for Bayesian adaptive
randomisation. In addition, the time trend problem of platform trial can
be studied in this package. There is a demo for multi-arm multi-stage
trial for two different null scenario in this package.

## Installation

You can install the ‘PlatFormDesignTimeTrend’ package 1.0.0 like so:

``` r
# install.packages("PlatFormDesignTimeTrend")
devtools::install_github("ZXW834/PlatFormDesignTime", build_vignettes = TRUE)
```

## Tutorials

-   ‘MAMS-CutoffScreening-tutorial’ is a tutorial document of how to do
    cutoff screening under Bayesian MAMS trial
-   ‘MAMS-trial-simulation-tutorial’ is a tutorial document of how to do
    Bayesian MAMS trial simulation with or without time trend

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(PlatFormDesignTimeTrend)
#> Loading required package: rstan
#> Loading required package: StanHeaders
#> Loading required package: ggplot2
#> rstan (Version 2.21.8, GitRev: 2e1f913d3ca3)
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
#> [1] "Start trial information initialisation"
#> $result
#> $result$`0404TimeTrend00stage5main`
#> $result$`0404TimeTrend00stage5main`[[1]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.3664 15  6  15   5        0    -0.438    -0.267    0.597
#> 2 0.1756 34 13  26   7        0    -0.498    -0.506    0.322
#> 3 0.5488 56 19  34  12        0    -0.671     0.057    0.201
#> 4 0.5908 70 25  50  19        0    -0.591     0.091    0.154
#> 5 0.7564 81 27  69  27        0    -0.692     0.249    0.125
#> 
#> $result$`0404TimeTrend00stage5main`[[2]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.3460 15  6  15   5        0    -0.429    -0.272    0.533
#> 2 0.1068 35 12  25   5        0    -0.673    -0.744    0.372
#> 3 0.5788 57 16  33  10        0    -0.952     0.089    0.236
#> 4 0.8748 69 20  51  20        0    -0.889     0.435    0.146
#> 5 0.8664 76 22  74  28        0    -0.909     0.403    0.125
#> 
#> $result$`0404TimeTrend00stage5main`[[3]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.2388 15  7  15   5        0    -0.150    -0.552    0.582
#> 2 0.4036 37 14  23   8        0    -0.502    -0.150    0.308
#> 3 0.5328 55 20  35  13        0    -0.568     0.041    0.193
#> 4 0.3984 69 26  51  18        0    -0.501    -0.110    0.150
#> 5 0.1424 87 35  63  20        0    -0.404    -0.373    0.124
#> 
#> $result$`0404TimeTrend00stage5main`[[4]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.6656 15  5  15   6        0    -0.735     0.306    0.603
#> 2 0.9672 26  8  34  19        0    -0.803     1.029    0.310
#> 3 0.8444 34 14  56  29        0    -0.357     0.437    0.194
#> 4 0.7612 42 16  78  35        0    -0.499     0.285    0.158
#> 5 0.4364 50 21 100  41        0    -0.322    -0.047    0.123
#> 
#> $result$`0404TimeTrend00stage5main`[[5]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.5612 14  4  16   5        0    -0.943     0.121    0.574
#> 2 0.3144 27 10  33  10        0    -0.561    -0.287    0.311
#> 3 0.4148 48 17  42  14        0    -0.607    -0.086    0.198
#> 4 0.7604 67 22  53  21        0    -0.714     0.283    0.143
#> 5 0.3872 74 25  76  24        0    -0.669    -0.104    0.121
#> 
#> $result$`0404TimeTrend00stage5main`[[6]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.7796 15  4  15   6        0    -1.027     0.576    0.568
#> 2 0.8684 23  5  37  13        0    -1.309     0.675    0.366
#> 3 0.8464 31  8  59  21        0    -1.070     0.471    0.224
#> 4 0.9684 39 11  81  36        0    -0.946     0.724    0.165
#> 5 0.9632 47 15 103  49        0    -0.762     0.659    0.138
#> 
#> $result$`0404TimeTrend00stage5main`[[7]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.8716 15  4  15   7        0    -0.997     0.838    0.551
#> 2 0.4680 23  9  37  14        0    -0.446    -0.046    0.282
#> 3 0.3216 39 17  51  20        0    -0.258    -0.181    0.170
#> 4 0.7140 60 21  60  24        0    -0.623     0.215    0.137
#> 5 0.3144 68 25  82  27        0    -0.547    -0.162    0.119
#> 
#> $result$`0404TimeTrend00stage5main`[[8]]
#>     PP1C nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.6688 14  5  16   7        0    -0.584     0.314    0.513
#> 2 0.7976 23  8  37  17        0    -0.627     0.466    0.303
#> 3 0.7216 30 11  60  26        0    -0.549     0.279    0.200
#> 4 0.6460 38 14  82  33        0    -0.547     0.143    0.148
#> 5 0.8324 49 17 101  43        0    -0.638     0.339    0.127
#> 
#> $result$`0404TimeTrend00stage5main`[[9]]
#>     PP1C  nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.0632  15  8  15   4        0     0.095    -1.108    0.546
#> 2 0.0624  37 19  23   7        0     0.046    -0.871    0.326
#> 3 0.0468  60 31  30  10        0     0.067    -0.776    0.231
#> 4 0.0180  82 43  38  12        0     0.091    -0.877    0.187
#> 5 0.0904 104 48  46  16        0    -0.156    -0.480    0.137
#> 
#> $result$`0404TimeTrend00stage5main`[[10]]
#>     PP1C  nC yC nE1 yE1 H1^1tpIE Intercept Trt1_Mean Trt1_Var
#> 1 0.1352  15  7  15   4        0    -0.164    -0.851    0.573
#> 2 0.1020  37 19  23   8        0     0.054    -0.668    0.277
#> 3 0.1692  59 27  31  11        0    -0.171    -0.444    0.208
#> 4 0.1900  82 37  38  14        0    -0.196    -0.351    0.165
#> 5 0.1388 105 52  45  18        0    -0.023    -0.382    0.121
#> 
#> 
#> 
#> $OPC
#>                           Type.I.Error.or.Power   Bias      rMSE N.per.arm.1
#> 0404TimeTrend00stage5main                     0 0.0102 0.3841629        74.1
#>                           N.per.arm.2 Survive.per.arm.1 Survive.per.arm.2   N
#> 0404TimeTrend00stage5main        75.9              28.7              29.3 150
#> 
#> $Nameofsaveddata
#> $Nameofsaveddata$nameTable
#> [1] "TABLENOTRENDEARLY-POCOCKSYMMETRICTHALL.RData"
#> 
#> $Nameofsaveddata$nameData
#> [1] "DATANOTRENDEARLY-POCOCKSYMMETRICTHALL.RData"
```
