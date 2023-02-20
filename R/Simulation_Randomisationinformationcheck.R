#' This function checks the validity of the randomisation information input
#'
#' @param Random.inf A list of adaptive randomisation information required for randomisation
#'
#' @return #A checked list of input randomisation information
#' @export
#'
#' @examples
Randomisation.inf = function(Random.inf = Random.inf) {
  #----------------------------Randomisation information-----------------------
  Fixratio = Random.inf$Fixratio
  if (Fixratio == T) {
    if (is.na(Random.inf$Fixratiocontrol) |
        Random.inf$Fixratiocontrol <= 0) {
      stop(
        "Error: The value R > 0 for fix randomisation (R:1:1:1:......) should be input which is Fixratiocontrol"
      )
    }
    else{
      Fixratiocontrol = Random.inf$Fixratiocontrol
    }
    return(
      list(
        Fixratio = Fixratio,
        Fixratiocontrol = Fixratiocontrol,
        BARmethod = NA,
        Thall.tuning.inf = list(tuningparameter = NA,  c = NA)
      )
    )
  }
  else {
    BARmethod = Random.inf$BARmethod
    if (BARmethod == "Thall") {
      tuning.inf = Random.inf$Thall.tuning.inf$tuningparameter
      if (tuning.inf == "Fixed") {
        tuningparameter = "Fixed"
        c = Random.inf$Thall.tuning.inf$fixvalue
        if (is.na(Random.inf$Thall.tuning.inf$fixvalue)) {
          stop("Error: The value of tuning parameter in Thall's approach should be specified.")
        }
        return(
          list(
            BARmethod = BARmethod,
            Thall.tuning.inf = list(tuningparameter = tuningparameter, c = c),
            Fixratio = Fixratio,
            Fixratiocontrol = NA
          )
        )
      }
      else {
        tuningparameter = "Unfixed"
      }
      return(
        list(
          BARmethod = BARmethod,
          Thall.tuning.inf = list(tuningparameter = tuningparameter,  c = NA),
          Fixratio = Fixratio,
          Fixratiocontrol = NA
        )
      )
    }
    else{
      BARmethod = "Trippa"
      return(
        list(
          BARmethod = BARmethod,
          Thall.tuning.inf = list(tuningparameter = NA,  c = NA),
          Fixratio = Fixratio,
          Fixratiocontrol = NA
        )
      )
    }
  }
}

#------------------------------------------------------------------------
