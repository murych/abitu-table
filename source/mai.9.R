url <- 'http://priem.mai.ru/lists/list_2_o27.php'

get.table <- function(url){
  html <- POST(url, body = list(dep = '9', budjet = 'Á', form = 'Î', spec = 'Á-12.03.04', listtype = '1'))
  
  html <- content(html)
  
  table <- readHTMLTable(html, header = F, which = 7)
  
  table <- table[-c(1:11),]
  table <- table[,-c(2,11)]
  
  column.names <-  c('number','name','summ','rus','math','phys', 'achieve', 'advantage', 'original', 'hostel', 'whithout.hostel')
  colnames(table) <- column.names
  
  for (i in c(2,3,8:11)){
    table[,i] <- as.character(as.vector(table[,i]))
    Encoding(table[,i]) <- 'UTF-8'
  }
  
  for (i in 1:length(table$summ)){
    table$prior[i] <- tail(strsplit(table$summ[i], split = '*')[[1]],2)[1]
  }
  
  for (i in 1:length(table$summ)){
    table$summ[i] <- paste(strsplit(table$summ[i], split = '*')[[1]][c(1:3)], collapse = '')
  }
  
  for (i in c(1,3:7,12)){
    table[,i] <- as.numeric(as.vector(table[,i]))
  }
  
  for (i in c(8:12)){
    table[,i] <- factor(table[,i])
  }
  
  table$achieve[is.na(table$achieve)] <- 0
  
  levels(table$advantage)[1] <- 'no'
  levels(table$advantage)[2] <- 'yes'
  
  levels(table$original)[1] <- 'copy'
  levels(table$original)[2] <- 'original'
  
  levels(table$hostel)[1] <- 'no'
  levels(table$hostel)[2] <- 'yes'
  
  levels(table$whithout.hostel)[2] <- 'no'
  levels(table$whithout.hostel)[3] <- 'yes'
  
  return(table)
}