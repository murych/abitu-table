import <- function(){
  library('RGtk2')
  library('cairoDevice')
  library(ggplot2)
}


init.ui <- function(){
  button.action <- function(button){
    source('mirea.R')
    
    new.window <- gtkWindow()
    new.window['title'] <- 'Plot'
    
    plotArea <- gtkDrawingArea()
    gtkWidgetSetSizeRequest(plotArea, 400, 400)
    asCairoDevice(plotArea)
    gtkWidgetShow(plotArea)
    dialog$add(plotArea)
    
    plot(table.mirea(url.mirea)$summ, type = 'l')
  }
  
  window <- gtkWindow()
  window['title'] <- 'Get results'
  
  frame <- gtkFrameNew()
  window$add(frame)
  
  box1 <- gtkVBoxNew()
  box1$setBorderWidth(30)
  frame$add(box1)
  
  GetResult <- gtkButton('Get Plot')
  gSignalConnect(GetResult, "clicked", button.action)
  box1$packStart(GetResult, fill = T)
}