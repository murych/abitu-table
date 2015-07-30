initializing <- function(){
  Sys.setlocale("LC_CTYPE", "Russian")
  # par(mar=c(1,1,1,1))
  library(XML)
  library(RGtk2)
  library(cairoDevice)
  library(ggplot2)
  library(gridExtra)
  library(httr)
}


source('ui.R')

initializing()

init.ui()
