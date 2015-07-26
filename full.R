import <- function(){
  library(XML)
  library(ggplot2)
  library(gridExtra)
}

table.sort <- function(html){
  column.names <-  c('number','id','name','dob','original','prior')
  
  table.mai <- readHTMLTable(html, header = T, which = 1)
  colnames(table.mai) <- column.names
  table.mai$number <- as.numeric(as.vector(table.mai$number))
  table.mai$id <- as.vector(table.mai$id)
  table.mai$name <- as.vector(table.mai$name)
  table.mai$dob <- as.vector(table.mai$dob)
  
  return(table.mai)
}

number <- function(html){
  header.num <- strsplit(parseURI(html)$path, split = '(/|-)')[[1]]
  header.num <- tail(header.num, n=2)
  header.num <- header.num[-2]
  
  return(header.num)
}

graph.create <- function(table, header.num){
  pic.title <- c('Ðàñïðåäåëåíèå ïî òèïó äîêóìåíòà â ÌÀÈ ¹',header.num,'12.03.04')
  pic.title <- paste(pic.title, collapse = ' ')
  
  picture <- ggplot(table, aes(original))+
    geom_bar(col = 'black', aes(fill = original), width=0.5)+
    theme_bw()+
    scale_fill_brewer(palette = "Blues")+
    labs(title = pic.title, x = 'Òèï', y = 'Êîëè÷åñòâî')+
    theme(legend.position='none')
  
  return(picture)
}

########
import()

mai.9 <- 'http://techcoockbooknotes.blogspot.com/2015/07/9-120304.html'
mai.6 <- 'http://techcoockbooknotes.blogspot.com/2015/07/6-120304.html'

grid.arrange(graph.create(table.sort(mai.6), number(mai.6)), 
             graph.create(table.sort(mai.9),number(mai.9)), ncol=2)