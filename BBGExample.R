#Setup bloomberg connection
library(Rblpapi)
con <- blpConnect()

gics_sector <- c("Energy","Materials","Utilities","Industrials","Consumer Discretionary","Information Technology","Health Care","Telecommunication Services","Financials","Consumer Staples")

#Get input
source("ReadInput.R")
portfolio <- readTable("D:\\RCode\\Input.xlsx","Portfolio")
cash <- readTable("D:\\RCode\\Input.xlsx","Cash Position")

#Get GICS Sector
portfolio$Benchmark$Sector <- bdp(securities = portfolio$Benchmark$Ticker, fields = "GICS_SECTOR_NAME")
portfolio$Actual$Sector <- bdp(securities = portfolio$Actual$Ticker, fields = "GICS_SECTOR_NAME")
portfolio$Draft$Sector <- bdp(securities = portfolio$Draft$Ticker, fields = "GICS_SECTOR_NAME")

#Get PX_Last
portfolio$Benchmark$Price <- bdp(securities = portfolio$Benchmark$Ticker, fields = "PX_LAST")
portfolio$Actual$Price <- bdp(securities = portfolio$Actual$Ticker, fields = "PX_LAST")
portfolio$Draft$Price <- bdp(securities = portfolio$Draft$Ticker, fields = "PX_LAST")

## in case to avoid long term halts
## for the first method, need to re-order (or use "sapply" to call one by one)
opts <- structure("1", names = "maxDataPoints")
result <- bdh(securities = "000002 CH Equity", fields = "PX_LAST",start.date = as.Date("2015-01-01"),end.date = as.Date("2016-03-04"),options = opts)
prices <- sapply(result, function(x) x$PX_LAST)
## tempraroy use the first method
bdp(securities = "000002 CH Equity", fields = "PX_CLOSE_1D")$PX_CLOSE_1D

#Can use na.locf( , fromLast = TRUE) in "zoo package" to fill NA (if any)

weighting <- sapply(gics_sector, function(x) sum(Test$Test$Holding[match(Test$Test$Sector, x, nomatch = 0)]))
