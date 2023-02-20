perHtypeIerrorfunc = function(res) {
  colMeans(t(sapply(res, function(x) {
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    #Indentify which hypothesis is rejected
    reject = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                            K - 1), 1)[, 2]
    if (length(reject) >= 1) {
      rejectres = rep(0, K - 1)
      rejectres[reject] = 1
      return(rejectres)
    }
    else{
      return(rep(0, K - 1))
    }
  })))
}
FWERfunc = function(res) {
  mean(sapply(res, function(x) {
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    if (sum(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1) >= 1) {
      return(1)
    }
    else{
      return(0)
    }
  }))
}

Meanfunc = function(res) {
  K = sapply(res, function(x) {
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    return(K)
  })
  meaneffect = colMeans(matrix(t(sapply(res, function(x) {
    stage = dim(x)[1]
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    reject = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                            K - 1), 1)[, 2]
    if (length(reject) >= 1) {
      drop.at = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                               K - 1), 1)[, 1]
      drop.at.all = rep(stage, K - 1)
      drop.at.all[reject] = drop.at
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, treatmentindex)
      meanres = matrix(x[, (K - 1 + 2 * K + K - 1 + 1 + 1):(K - 1 + 2 *
                                                              K + K - 1 + 1 + K - 1)], ncol = K - 1)
      result = rep(NA, K - 1)
      for (i in 1:(K - 1)) {
        result[i] = meanres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
    else{
      drop.at.all = rep(stage, K - 1)
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, treatmentindex)
      meanres = matrix(x[, (K - 1 + 2 * K + K - 1 + 1 + 1):(K - 1 + 2 *
                                                              K + K - 1 + 1 + K - 1)], ncol = K - 1)
      result = rep(NA, K - 1)
      for (i in 1:(K - 1)) {
        result[i] = meanres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
  })), ncol = K - 1))
  return(meaneffect)
}
varfunc = function(res) {
  K = sapply(res, function(x) {
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    return(K)
  })
  meaneffect = matrixStats::colVars(matrix(t(sapply(res, function(x) {
    stage = dim(x)[1]
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    reject = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                            K - 1), 1)[, 2]
    if (length(reject) >= 1) {
      drop.at = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                               K - 1), 1)[, 1]
      drop.at.all = rep(stage, K - 1)
      drop.at.all[reject] = drop.at
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, treatmentindex)
      meanres = matrix(x[, (K - 1 + 2 * K + K - 1 + 1 + 1):(K - 1 + 2 *
                                                              K + K - 1 + 1 + K - 1)], ncol = K - 1)
      result = rep(NA, K - 1)
      for (i in 1:(K - 1)) {
        result[i] = meanres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
    else{
      drop.at.all = rep(stage, K - 1)
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, treatmentindex)
      meanres = matrix(x[, (K - 1 + 2 * K + K - 1 + 1 + 1):(K - 1 + 2 *
                                                              K + K - 1 + 1 + K - 1)], ncol = K - 1)
      result = rep(NA, K - 1)
      for (i in 1:(K - 1)) {
        result[i] = meanres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
  })), ncol = K - 1))
  return(meaneffect)
}

Nfunc = function(res) {
  K = sapply(res, function(x) {
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    return(K)
  })
  Nmean = colMeans(matrix(t(sapply(res, function(x) {
    stage = dim(x)[1]
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    reject = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                            K - 1), 1)[, 2]
    if (length(reject) >= 1) {
      drop.at = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                               K - 1), 1)[, 1]
      drop.at.all = rep(stage, K - 1)
      drop.at.all[reject] = drop.at
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(c(max(drop.at.all), drop.at.all), c(1, treatmentindex +
                                                                1))
      Nres = matrix(x[, seq(K, K - 1 + 2 * K - 1, 2)], ncol = K)
      result = rep(NA, K)
      for (i in 1:K) {
        result[i] = Nres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
    else{
      drop.at.all = rep(stage, K)
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, c(1, treatmentindex + 1))
      Nres = matrix(x[, seq(K, K - 1 + 2 * K - 1, 2)], ncol = K)
      result = rep(NA, K)
      for (i in 1:K) {
        result[i] = Nres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
  })), ncol = K))
  return(Nmean)
}

Sperarmfunc = function(res) {
  K = sapply(res, function(x) {
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    return(K)
  })
  Smean = colMeans(matrix(t(sapply(res, function(x) {
    stage = dim(x)[1]
    resname = colnames(x)
    K = sum(stringr::str_detect(colnames(x), "H")) + 1
    reject = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                            K - 1), 1)[, 2]
    if (length(reject) >= 1) {
      drop.at = which(matrix(x[, (K - 1 + 2 * K + 1):(K - 1 + 2 * K + K - 1)] %in% 1, ncol =
                               K - 1), 1)[, 1]
      drop.at.all = rep(stage, K - 1)
      drop.at.all[reject] = drop.at
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(c(max(drop.at.all), drop.at.all), c(1, treatmentindex +
                                                                1))
      Nres = matrix(x[, seq(K + 1, K - 1 + 2 * K, 2)], ncol = K)
      result = rep(NA, K)
      for (i in 1:K) {
        result[i] = Nres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
    else{
      drop.at.all = rep(stage, K)
      treatmentindex = seq(1, K - 1)
      trtmean.loc = cbind(drop.at.all, c(1, treatmentindex + 1))
      Nres = matrix(x[, seq(K + 1, K - 1 + 2 * K, 2)], ncol = K)
      result = rep(NA, K)
      for (i in 1:K) {
        result[i] = Nres[trtmean.loc[i, 1], trtmean.loc[i, 2]]
      }
      return(result)
    }
  })), ncol = K))
  return(Smean)
}

list.of.analysisfunction <-
  list(
    perHtypeIerrorfunc = perHtypeIerrorfunc,
    FWERfunc = FWERfunc,
    Meanfunc = Meanfunc,
    varfunc = varfunc,
    Nfunc = Nfunc,
    Sperarmfunc = Sperarmfunc
  )
