init.ui <- function(){
  
  get.university <- function(){
    switch(gtkComboBoxGetActive(combobox.uni),
           '1' <- source('mirea.R'),
           '2' <- source('mai.6.R'),
           '3' <- source('mai.9.R'),
           '4' <- source('mpei.R'))
  }
  
  button.gettable <- function(button){
    get.university()
    window.title <- c(university[(gtkComboBoxGetActive(combobox.uni)+1)], special[(gtkComboBoxGetActive(combobox.dep)+1)])
    window.title <- paste(window.title, collapse = ' ')
    draw.table(get.table(url),window.title)
  }
    
  button.getplot <- function(button){
    get.university()
    window.title <- c(university[(gtkComboBoxGetActive(combobox.uni)+1)], special[(gtkComboBoxGetActive(combobox.dep)+1)])
    window.title <- paste(window.title, collapse = ' ')
    plot.window <- gtkWindow()
    plot.window['title'] <- window.title
    plotArea <- gtkDrawingArea()
    gtkWidgetSetSizeRequest(plotArea, 400, 400)
    asCairoDevice(plotArea)
    gtkWidgetShow(plotArea)
    plot.window$add(plotArea)
    
    plot(get.table(url)$summ, type = 'l')
  }
  
  window <- gtkWindow()
  window['title'] <- 'Get results'
  
  frame <- gtkFrameNew()
  window$add(frame)
  
  box1 <- gtkHBoxNew(spacing = 10)
  box1$setBorderWidth(85)
  frame$add(box1)
  
  university <- c("----","ÌÈĞİÀ","ÌÀÈ #6", "ÌÀÈ #9", "ÌİÈ")
  
  model.uni <-rGtkDataFrame(university)
  combobox.uni <- gtkComboBox(model.uni)
  crt.uni <- gtkCellRendererText()
  combobox.uni$packStart(crt.uni)
  combobox.uni$addAttribute(crt.uni, "text", 0)
  gtkComboBoxSetActive(combobox.uni, 1)
  box1$packStart(combobox.uni)
  
  special <- c('----', '12.03.04', '11.03.04', '11.03.03')
  
  model.dep <- rGtkDataFrame(special)
  combobox.dep <- gtkComboBox(model.dep)
  crt.dep <- gtkCellRendererText()
  combobox.dep$packStart(crt.dep)
  combobox.dep$addAttribute(crt.dep, "text", 0)
  gtkComboBoxSetActive(combobox.dep, 1)
  box1$packStart(combobox.dep)

  
  GetPlot <- gtkButton('Get Plot')
  gSignalConnect(GetPlot, "clicked", button.getplot)
  box1$packStart(GetPlot, fill = F)
  
  GetTable <- gtkButton('Get Table')
  gSignalConnect(GetTable, 'clicked', button.gettable)
  box1$packStart(GetTable, fill = F)
}