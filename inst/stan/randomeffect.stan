functions {
}
data {
  int<lower=1> N;  // total number of observations
  int Y[N];  // response variable
  int<lower=1> K;  // number of population-level effects
  matrix[N, K] X;  // population-level design matrix
  // row_vector[K-1] Xdummy[N];  // population-level design matrix
  // data for group-level effects of ID 1
  int<lower=1> groupmax;  // number of grouping levels
  // int<lower=1> M_1;  // number of coefficients per level
  int<lower=1> group[N];  // grouping indicator per observation
  // group-level predictor values
  // vector[N] Z_1_1;
}
transformed data {
  int Kc = K - 1;
  matrix[N, Kc] Xc;  // centered version of X without an intercept
  vector[Kc] means_X;  // column means of X before centering
  for (i in 2:K) {
    means_X[i - 1] = mean(X[, i]);
    Xc[, i - 1] = X[, i] - means_X[i - 1];
  }
}
parameters {
  vector[K-1] beta1;  // population-level effects
  real beta0;  // temporary intercept for centered predictors
  // vector<lower=0>[N_1] sd_1;  // group-level standard deviations
  real alpha[groupmax]; 
  real<lower=0> sigma;
  // vector[N_1] z_1[M_1];  // standardized group-level effects
}
transformed parameters {
  // vector[N_1] r_1_1;  // actual group-level effects
  // r_1_1 = (sd_1[1] * (z_1[1]));
  // real alpha[1]
  //   alpha[1]=0;
}
model {
  // likelihood including constants
    // initialize linear predictor term
    // vector[N] mu = Intercept + rep_vector(0.0, N);
    // for (n in 1:N) {
    //   // add more terms to the linear predictor
    //   mu[n] += r_1_1[J_1[n]] * Z_1_1[n];
    // }
    sigma ~ gamma(0.1,0.01);
    beta0 ~ normal(0,1.8);
    beta1 ~ normal(0,1.8);
    
    alpha[1]~normal(0,0.001);
    alpha[2]~normal(0,sigma);
    for (k in 3:groupmax){
    alpha[k] ~ normal(2*alpha[k-1]-alpha[k-2],sigma);
    }
    // alpha ~ normal(0,sigma);
    
    for(n in 1:N) {
      Y[n] ~ bernoulli(inv_logit(beta0 + alpha[groupmax+1-group[n]] +  Xc[n]*beta1));
    }
    
  // priors including constants
}
generated quantities {
  // actual population-level intercept
  real b_Intercept = beta0 - dot_product(means_X, beta1);
}
