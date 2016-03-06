initializing <- function() {
  Sys.setlocale("LC_CTYPE", "Russian")
  library(XML)
  library(RGtk2)
  library(cairoDevice)
  library(ggplot2)
  library(gridExtra)
  library(httr)
}


source("source/ui.R")

initializing()

init.ui()
