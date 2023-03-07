## code to prepare `dataforvignette` dataset goes here

load("data-raw/notrend_screening600_s5_fourarm04_ARratiothall_earlystop.RData")
dataloginformd=cutoff.information$dataloginformd
recommandloginformd=cutoff.information$recommandloginformd
predictedtpIEinformd=cutoff.information$predictedtpIEinformd


load("data-raw/TABLEEARLYcstagenullARTHALL.RData")
OPC_null = OPC
load("data-raw/TABLEEARLYcstagealtARTHALL.RData")
OPC_alt = OPC

load("data-raw/DATAEARLYcstagenullARTHALL.RData")
DATA_null = result
load("data-raw/DATAEARLYcstagealtARTHALL.RData")
DATA_alt = result
usethis::use_data(dataloginformd, recommandloginformd, predictedtpIEinformd, OPC_null, OPC_alt, overwrite = TRUE)
