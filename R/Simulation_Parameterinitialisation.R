#' This function initialises the inner parameter used in simulate.trial function
#'
#' @param response.probs A vector of response probability of each arm
#' @param ns A vector of number of patient at each stage
#'
#' @return A list of initialised parameters
#' @export
#'
#' @examples
#' Initializetrialparameter(response.probs = c(0.4,0.6), ns = c(15,30,45,60,75,90))
#'
#' #$K
#' #[1] 2
#'
#' #$armleft
#' #[1] 2
#'
#' #$treatmentindex
#' #[1] 1
#'
#' #$n
#' #[1] 0 0
#'
#' #$y1
#' #[1] 0 0
#'
#' #$groupwise.response.probs
#' #    [,1] [,2]
#' #[1,]  0.4  0.6
#' #[2,]  0.4  0.6
#' #[3,]  0.4  0.6
#' #[4,]  0.4  0.6
#' #[5,]  0.4  0.6
#' #[6,]  0.4  0.6
#'
#' #$randomprob
#' #    1   2
#' #[1,] 0.5 0.5
#'
#' #$z
#' #numeric(0)
#'
#' #$y
#' #numeric(0)
#'
#' #$group_indicator
#' #numeric(0)
#'
Initializetrialparameter = function(response.probs, ns) {
  K = length(response.probs)
  armleft = K
  treatmentindex = seq(1, K - 1)
  n = rep(0, K)
  y1 = rep(0, K)
  groupwise.response.probs = matrix(rep(response.probs, length(ns)),
                                    nrow = length(ns),
                                    byrow = T)

  rand.prob = 1 / K
  randomprob = matrix(rep(rand.prob, K), ncol = K)
  colnames(randomprob) = seq(1, K)

  z <- array(0.0, 0)
  y <- array(0.0, 0)
  group_indicator <- array(0.0, 0)
  post.prob.best.mat = matrix(0,length(ns),K)
  colnames(post.prob.best.mat) = seq(0,K-1)
  return(
    list(
      K = K,
      armleft = armleft,
      treatmentindex = treatmentindex,
      n = n,
      y1 = y1,
      groupwise.response.probs = groupwise.response.probs,
      randomprob = randomprob,
      z = z,
      y = y,
      group_indicator = group_indicator,
      post.prob.best.mat = post.prob.best.mat
    )
  )
}
