#' @title Randomeffect modelling function
#'
#' @description This functions use rjags to sample from the time machine model
#' @param ytemp The data matrix including the information of total number of patients outcomes for each arm at each stage
#' @param treatmentindex The vector of current active arms' index
#' @param group A numerical value indicating the current stage index
#' @param ntemp The data matrix including the information of total number of patients allocated to each arm at each stage
#' @param armleft A numerical value indicating the number of active arms and control
#' @param jagmodel The jag time machine model
#'
#' @return A dataframe of posterior samples for each parameters
#' @importFrom stats update
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
#' treatmentindex=1, group=2,
#' ntemp=ntemp, armleft=2,
#' jagmodel=jagmodel)
Mixeffect_modelling = function(ytemp,
                               treatmentindex,
                               group,
                               ntemp,
                               armleft,
                               jagmodel) {
  dataran = list(
    'Y' = as.matrix(ytemp[c(1, treatmentindex + 1), 1:group]),
    'N' = as.matrix(ntemp[c(1, treatmentindex + 1), 1:group]),
    'armleft' = armleft,
    'stage' = group
  )
  inits1 = list(beta0 = 0,
                alpha = c(NA, rep(0, group - 1)),
                .RNG.name = 'base::Wichmann-Hill')
  jags.mod = rjags::jags.model(
    file = textConnection(jagmodel),
    data = dataran,
    n.chains = 1,
    n.adapt = 1000,
    inits = inits1,
    quiet = TRUE
  )
  stats::update(jags.mod, n.iter = 2500, progress.bar = "none")
  postsamp.list = rjags::coda.samples(jags.mod, c("alpha", "beta1", "beta0"), 2500, progress.bar =
                                "none")

  return(postsamp.list)
}
