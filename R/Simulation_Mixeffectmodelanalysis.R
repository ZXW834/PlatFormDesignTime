#' @title Jags mixeffect (Time machine) model analysis
#' @description This function analysis the posterior samples from time machine model
#'
#' @param group A numerical value indicating the current stage index
#' @param treatmentindex The vector of current active arms' index
#' @param ns A vector of accumulated number of patient at each stage
#' @param postsamp.list A jag result list
#' @param K Total number of arms
#'
#' @return A list of evaluation metrics
#' @export
#'
#' @examples
#' jagmodel<-"  model {
#' for(i in 1:armleft){
#'   for(j in 1:stage){
#'       Y[i,j] ~ dbin(p[i,j],N[i,j])
#'           logit(p[i,j]) = beta0 + alpha[stage-(j-1)] + beta1[i]
#'             }
#'             }
#'        alpha[1] = 0
#'        alpha[2] ~ dnorm(0, tau2)
#'    for(k in 3:stage ) {
#'      alpha[k] ~ dnorm(2*alpha[k-1] - alpha[k-2],tau2)
#'      }
#'    beta1[1] <- 0
#'    for(i in 2:armleft){
#'      beta1[i] ~ dnorm(0,0.31)
#'      }
#'    tau2 ~ dgamma(0.1, 0.01)
#'    beta0 ~ dnorm(0, 0.31)
#'    }"
#'    ntemp=matrix(rep(NA,5*2),nrow=2)
#'    ytemp=matrix(rep(NA,5*2),nrow=2)
#'    ytemp[1,1:2]=c(5,6);ytemp[2,1:2]=c(5,5)
#'    ntemp[1,1:2]=c(30,30);ntemp[2,1:2]=c(30,30)
#' postsamp.list=Mixeffect_modelling(ytemp=ytemp,
#' treatmentindex=1, group=2, ntemp=ntemp,
#' armleft=2, jagmodel=jagmodel)
#' analysis=Mixeffect_analysis(postsamp.list=postsamp.list,
#' group=2, treatmentindex=2, ns = c(60,120,180,240,300), K=2)
Mixeffect_analysis = function(postsamp.list, group, treatmentindex, ns, K = K) {
  postsamp = as.data.frame(postsamp.list[[1]])
  posteriorsummary = summary(postsamp.list, quantiles = c(0.025, 0.5, 0.975)) # Posterior Summaries
  estimates = round(posteriorsummary[[1]], 3) # Posterior estimatesimates only (no CIs)
  postalpha = postsamp[, grep(names(postsamp), pattern = "alpha")] # Posterior of alpha (stageercept) parameters
  if (group > 1) {
    postalpha = postalpha[, group:1]
  } # flip alphas to count forward
  postbeta = postsamp[, grep(names(postsamp), pattern = "beta1")] # Posterior of beta1 (treatment effect) parameters
  postbeta0 = postsamp[, grep(names(postsamp), pattern = "beta0")] # Posterior of beta0 (stageercept) parameter
  statsbeta0 = round(mean(postbeta0), 3)
  stats4 = round(colMeans(postbeta)[-1], 3)
  stats5 = round(estimates[rownames(estimates) == names(postbeta[-1]), colnames(estimates) ==
                             "SD"], 3)
  stats1 = rep(NA,K-1)
  names(stats1) = seq(1,K-1)
  stats1[treatmentindex] = colMeans(postbeta > 0)[treatmentindex + 1]
  post.prob.btcontrol = stats1
  stats6 = rep(NA, length(ns) - 1)
  names(stats6) = seq(2, length(ns))
  stats6[1:group - 1] = round(colMeans(postalpha)[1:(group - 1)], 3)
  stats7 = {

  }
  sampefftotal = postbeta0
  #Sample distribution of treatment in logistic regression
  for (temp in 1:(dim(postbeta)[2] - 1)) {
    sampefftotal = cbind(sampefftotal, postbeta0 + postbeta[, temp + 1])
  }
  sampoutcome = inv.logit(sampefftotal)

  return(
    list(
      stats1 = stats1,
      statsbeta0 = statsbeta0,
      stats4 = stats4,
      stats5 = stats5,
      stats6 = stats6,
      stats7 = stats7,
      sampoutcome = sampoutcome,
      sampefftotal = sampefftotal,
      post.prob.btcontrol = post.prob.btcontrol
    )
  )
}
