url <- 'http://www.pkmpei.ru/inform/list18e.html'


get.table <- function(url){
  column.names <-  c('summ','math','phys','rus','achieve','name', 'dob', 'hostel', 'original','notes')
  
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
