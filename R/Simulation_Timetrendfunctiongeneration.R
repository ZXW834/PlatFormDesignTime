#' This function generate the time trend function based on trend information
#'
#' @param trend.inf #The list of information for time trend effect
#'
#' @return
#' #A list containing the time trend function according to input trend.type variable,
#' and a indicator of whether there is a time trend in data generation
#' based on input trend information
#' @export
#'
#' @examples
Timetrend.fun = function(trend.inf) {
  #Time trend pattern function
  trend.type = trend.inf$trend.type
  trend.effect = trend.inf$trend.effect
  trend_add_or_multip = trend.inf$trend_add_or_multip
  if (trend.type == "step" & sum(trend.effect != 0) > 0) {
    trend.function = function(ns, group , i, trend.effect) {
      delta = (group - 1) * trend.effect
      return(delta)
    }
    timetrendornot = c("There is time trend during data generation")
  }
  else if (trend.type == "linear" & sum(trend.effect != 0) > 0) {
    trend.function = function(ns, group , i, trend.effect) {
      delta = (i - 1 + ns[group] - ns[1]) * trend.effect /  (ns[length(ns)] - 1)
      return(delta)
    }
    timetrendornot = c("There is time trend during data generation")
  }
  else if (trend.type == "inverse.U.linear" &
           sum(trend.effect != 0) > 0) {
    trend.function = function(ns, group , i, trend.effect) {
      delta = ifelse(
        group <= round(length(ns) / 2),
        (i -
           1 + ns[group] - ns[1]) * trend.effect /  (ns[length(ns)] - 1),
        (ns[1] -
           1 + ns[round(length(ns) / 2)] - ns[1]) * trend.effect /  (ns[length(ns)] - 1) - (i - 1 +
                                                                                              ns[group - round(length(ns) / 2)] - ns[1]) * trend.effect /  (ns[length(ns)] - 1)
      )
      return(delta)
    }
    timetrendornot = c("There is time trend during data generation")
  }
  #Debugged at 0308 on 02112022 by Ziyan Wang for adding plateau pattern (using MM equation)
  else if (trend.type == "plateau" & sum(trend.effect != 0) > 0) {
    trend.function = function(ns, group , i, trend.effect) {
      delta = trend.effect * (i - 1 + ns[group] - ns[1]) / (max(ns) / 10 + (i -
                                                                              1 + ns[group] - ns[1]))
      return(delta)
    }
    timetrendornot = c("There is time trend during data generation")
  }
  else if (sum(trend.effect != 0) == 0) {
    trend.function = function(ns, group, i, trend.effect) {
      delta = 0
      return(delta)
    }
    timetrendornot = c("There is no time trend during data generation")
  }
  else {
    stop("Error: Wrong trend type or strength of time effect for data generation")
  }
  return(
    list(
      trend.function = trend.function,
      timetrendornot = timetrendornot,
      trend_add_or_multip = trend_add_or_multip,
      trend.effect = trend.effect
    )
  )
}
