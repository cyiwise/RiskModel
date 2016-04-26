#Equities Universe
if(file.exists("Universe.RData")){
  load("Universe.RData")
}else{
  SZASHR <- bds("SZASHR Index","INDX_MEMBERS")
  SZASHR$Exchange <- "SZ"
  SHASHR <- bds("SHASHR Index","INDX_MEMBERS")
  SHASHR$Exchange <- "SH"
  Universe <- rbind(SZASHR,SHASHR)
  names(Universe)[1] <- "Ticker"
  Universe$Ticker <- paste(Universe$Ticker,"Equity")
  Universe$Sector <- bdp(securities = Universe$Ticker, fields = "GICS_SECTOR_NAME")$GICS_SECTOR_NAME
  save(Universe, file = "Universe.RData")
}

#Financial Data
#Parameter Setting
referDate <- as.Date("20160420","%Y%m%d") #referDate <- Sys.Date()
overRides <- structure(c(format(referDate,"%Y%m%d"), "Q"), names = c("FUNDAMENTAL_PUBLIC_DATE","FUND_PER"))
TotAssets <- bdp(securities = Universe$Ticker, fields = "BS_TOT_ASSET",overrides = overRides)

