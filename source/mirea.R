url <- 'http://www.priem.mirea.ru/rating-2015/names_rating.php?competition=1503310360525937974&prior=any&documentType=any'


get.table <- function(url){
  column.names <-  c('number','name','prior','original','hostel','marks', 'achieve', 'summ', 'notes')
  
  table <- readHTMLTable(url, header = F, which = 1)
  table <- table[-1,]
  colnames(table) <- column.names
  
  for (i in c(1,3,7,8)){
    table[,i] <- as.numeric(as.vector(table[,i]))
  }
  
  for (i in c(2,4,5,6,9)){
    table[,i] <- as.character(as.vector(table[,i]))
  }
  
  for (i in c(3,4,5)){
    table[,i] <- factor(table[,i])
  }
  
  return(table)
}

draw.table <- function(table, window.title){
  res <- subset(table, subset = (original == 'ïîäëèííèê' | name == 'Ìàéçåíáåğã Òèìóğ Ëåîíèäîâè÷'), select = c(summ, marks, achieve, name, hostel, original))
  
  for (i in 1:length(res[,1])){
    res$number[i] <- i
  }
  
  window <- gtkWindow()
  window['title'] <- window.title
  
  frame <- gtkFrameNew()
  window$add(frame)
  
  scroll = gtkScrolledWindow()
  vbox = gtkVBoxNew(homogeneous = FALSE, spacing = 0)
  frame$setSizeRequest(650,400)
  scroll$addWithViewport(vbox)

  frame$add(scroll)
  
  tableRes <- gtkTableNew(nrow(res)+1,ncol(res)+1)
  tableRes$setColSpacings(10)
  vbox$packStart(tableRes,FALSE,FALSE,0)
  
  table.names <- c('Ñóììà','Áàëëû','ÈÄ','ÔÈÎ','Îáùåæèòèå','Òèï äîêóìåíòà','#')
  
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
  plot.window <- gtkWindow()
  plot.window['title'] <- window.title
  plotArea <- gtkDrawingArea()
  gtkWidgetSetSizeRequest(plotArea, 410, 400)
  asCairoDevice(plotArea)
  gtkWidgetShow(plotArea)
  plot.window$add(plotArea)
  Sys.sleep(1)
  plot(table$original, xlab = 'Òèï äîêóìåíòà', ylab = 'Êîëè÷åñòâî çàÿâëåíèé')
  
}