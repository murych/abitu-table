# url <- 'http://www.pkmpei.ru/inform/list18e.html' # 12.03.04
# url <- 'http://www.pkmpei.ru/inform/list21e.html' # 11.03.04
url <- 'http://www.pkmpei.ru/inform/list19e.html' # 11.03.01


get.table <- function(url){
  column.names <-  c('summ','math','phys','rus','achieve','name', 'dob', 'hostel', 'original','notes')
  
  # table <- readHTMLTable(url, header = F, which = 5)
  table <- readHTMLTable(url, header = F, which = 4)
  table <- table[-c(1,2),]
  colnames(table) <- column.names
  
  for (i in length(table)){
    table[,i] <- factor(table[,i])
  }
  
  for (i in 1:5){
    table[,i] <- as.numeric(as.vector(table[,i]))
  }
  
  for (i in 5:10){
    table[,i] <- as.character(as.vector(table[,i]))
    Encoding(table[,i]) <- 'UTF-8'
  }
  
  for (i in 8:9){
    table[,i] <- factor(table[,i])
  }
  
  return(table)
}

draw.table <- function(table, window.title){
  res <- subset(table, subset = (original == 'îğèãèíàë' | name == 'Ìàéçåíáåğã Òèìóğ Ëåîíèäîâè÷'), select = c(summ, math, phys, rus, achieve, name, hostel, original))
  
  for (i in 1:length(res[,1])){
    res$number[i] <- i
  }
  
  window <- gtkWindow()
  window['title'] <- window.title
  
  frame <- gtkFrameNew()
  window$add(frame)
  
  vbox <- gtkVBoxNew()
  vbox$setBorderWidth(30)
  frame$add(vbox)
  
  tableRes <- gtkTableNew(nrow(res)+1,ncol(res)+1)
  tableRes$setColSpacings(10)
  vbox$packStart(tableRes,FALSE,FALSE,0)
  
  table.names <- c('Ñóììà','Ì','Ô','Ğ','ÈÄ','ÔÈÎ','Îáùåæèòèå','Òèï äîêóìåíòà','#')
  for (indC in 1:ncol(res)) {
    label <- gtkLabel(table.names[indC])
    tableRes$attachDefaults(label, indC, indC+1, 0, 1)
  }
  
  for (indR in 1:nrow(res)) {
    label <- gtkLabel(rownames(res)[indR])
    tableRes$attachDefaults(label,0,1,indR,indR+1)
    for (indC in 1:ncol(res)) {
      label <- gtkLabel(res[indR,indC])
      tableRes$attachDefaults(label, indC, indC+1, indR, indR+1)
    }
  }
}

draw.plot <- function(table, window.title){
  table <- subset(table, original == levels(table$original)[2] | original == levels(table$original)[3])
  table$original <- factor(table$original)
  
  plot.window <- gtkWindow()
  plot.window['title'] <- window.title
  plotArea <- gtkDrawingArea()
  gtkWidgetSetSizeRequest(plotArea, 400, 400)
  asCairoDevice(plotArea)
  gtkWidgetShow(plotArea)
  plot.window$add(plotArea)
  Sys.sleep(1)
  plot(table$original, xlab = 'Òèï äîêóìåíòà', ylab = 'Êîëè÷åñòâî çàÿâëåíèé')

}
