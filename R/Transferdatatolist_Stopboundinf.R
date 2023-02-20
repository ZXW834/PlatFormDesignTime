#' This function summarises and checks stopping boundary information.
#'
#' @param Stop.type The shape of stopping boundary
#' @param Boundary.type "Symmetric" or "Asymmetric"
#' @param cutoff = c(cutoff1, cutoff2) #A vector
#' #Pr(theta_1 > theta_0|D_n) > cutoff1. Should input the cutoff1 for efficacy boundary as the first element
#' #Pr(theta_1 < theta_0|D_n) < cutoff2. Should input the cutoff2 for futility boundary as the first element
#'
#' @return The list of information required for boundary construction
#' @export
#'
#' @examples
#' Stop.type = "Early-Pocock" #(Pocock boundarty is a flat boundary across time)
#' Boundary.type = "Symmetric"
#' cutoff = c(0.9928, 0.0072)
#' ns = c(60, 120, 180, 240, 300)
#'
#' Stopbound.inf = Stopboundinf()
#' #Stopbound.inf
#' #$Stop.type
#' # [1] "Early-Pocock"
#' #$Boundary.type
#' #[1] "Symmetric"
#' #$cutoff
#' # [1] 0.9928 0.0072
#' #$ns
#' #[1] 60 120 180 240 300
Stopboundinf = function(Stop.type="Early-Pocock", Boundary.type="Symmetric", cutoff=c(0.9928, 0.0072)) {
  if (Boundary.type == "Symmetric") {
    if (Stop.type == "Early-OBF" & cutoff[1] == cutoff[2]) {
      cutofftemp = cutoff
    }
    else if (sum(cutoff) == 1) {
      cutofftemp = cutoff
    }
    else{
      stop("Error: The input of cutoff should be Symmetric")
    }
  }
  else if (Boundary.type == "Asymmetric") {
    if (Stop.type == "Early-OBF" & cutoff[1] != cutoff[2]) {
      cutofftemp = cutoff
    }
    else if (sum(cutoff) != 1) {
      cutofftemp = cutoff
    }
    else{
      stop("Error: The input of cutoff should be Asymmetric")
    }
  }
  else {
    stop("Error: The boundary type is invalid. Should input Symmetric or Asymmetric.")
  }
  Stopbound.inf = list(
    Stop.type = Stop.type,
    Boundary.type = Boundary.type,
    cutoff = cutofftemp
  )
  return(Stopbound.inf)
}
