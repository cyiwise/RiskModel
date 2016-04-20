library(RDCOMClient)
source("Utils.R")

readTable <- function(filePath, Sht, tab){
  #Number of arguments
  nargin <- length(as.list(match.call())) - 1
  #Data result
  result <- list()
  
  xls <- COMCreate("Excel.Application") #xls[["Visible"]] = FALSE
  wbs <- xls[["Workbooks"]]
  #Open Excel file
  wb <- wbs$Open(filePath)
  sheets <- wb[["Sheets"]]
  wks <- sheets$Item(Sht)
  
  if(nargin == 3){
    rng <- wks$ListObjects()$Item(tab)$Range()
    tmp <- importDataFrame(rng,wks)
    result[[tab]] <- tmp
  }
  else{
    num <- wks$ListObjects()$Count()
    for(i in 1:num){
      name <- wks$ListObjects()$Item(i)$Name()
      rng <- wks$ListObjects()$Item(i)$Range()
      tmp <- importDataFrame(rng,wks)
      result[[name]] <- tmp
    }
  }
  
  wb$Close()
  xls$Quit()
  
  return(result)
}