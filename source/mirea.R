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