init.ui <- function(){
  
  get.university <- function(){
    switch(gtkComboBoxGetActive(combobox.uni),
           '1' <- source('mirea.R'),
           '2' <- source('mai.6.R'),
           '3' <- source('mai.9.R'),
           '4' <- source('mpei.R'))
#     switch(gtkComboBoxGetActive(combobox.uni),
#            '1' <- print('mirea.R'),
#            '2' <- print('mai.6.R'),
#            '3' <- print('mai.9.R'),
#            '4' <- print('mpei.R'))
  }
  
  button.action <- function(button){
    get.university()
    
    new.window <- gtkWindow()
    new.window['title'] <- 'Plot'
    
    plotArea <- gtkDrawingArea()
    gtkWidgetSetSizeRequest(plotArea, 400, 400)
    asCairoDevice(plotArea)
    gtkWidgetShow(plotArea)
    new.window$add(plotArea)
    
    plot(get.table(url)$summ, type = 'l')
    # plot(table.mirea(url.mirea)$summ, type = 'l')
    
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

  
  GetResult <- gtkButton('Get Plot')
  gSignalConnect(GetResult, "clicked", button.action)
  box1$packStart(GetResult, fill = F)
}