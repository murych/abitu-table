mai.9 <- 'http://techcoockbooknotes.blogspot.com/2015/07/9-120304.html'
mai.6 <- 'http://techcoockbooknotes.blogspot.com/2015/07/6-120304.html'


table.mai <- function(html){
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
  pic.title <- c('Распределение по типу документа в МАИ №',header.num,'12.03.04')
  pic.title <- paste(pic.title, collapse = ' ')
  
  picture <- ggplot(table, aes(original))+
    geom_bar(col = 'black', aes(fill = original), width=0.5)+
    theme_bw()+
    scale_fill_brewer(palette = "Blues")+
    labs(title = pic.title, x = 'Тип', y = 'Количество')+
    theme(legend.position='none')
  
  return(picture)
}