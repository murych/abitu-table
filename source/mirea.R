url.mirea <- 'http://www.priem.mirea.ru/rating-2015/names_rating.php?competition=1503310360525937974&prior=any&documentType=any'


table.mirea <- function(url){
  column.names <-  c('number','name','prior','original','hostel','marks', 'achieve', 'summ', 'comment')
  
  table <- readHTMLTable(url, header = F, which = 1)
  table <- table[-1,]
  colnames(table) <- column.names
  
  table$number <- as.numeric(as.vector(table$number))
  table$name <- as.character(as.vector(table$name))
  table$prior <- factor(table$prior)
  table$original <- factor(table$original)
  table$hostel <- factor(table$hostel)
  table$marks <- as.character(as.vector(table$marks))
  table$achieve <- factor(table$achieve)
  table$summ <- as.numeric(as.vector(table$summ))
  table$comment <- factor(table$comment)
  
  return(table)
}




# ggplot(table, aes(summ, fill=original)) + geom_bar(width=0.7) +
#   facet_wrap(~ prior + hostel)
# 
# qplot(factor(prior), data=table.mirea(url.mirea), geom="bar", fill=factor(original))
# 
# qplot(prior, data=table, weight=summ, geom="histogram")
# 
# qplot(summ, data = table.mirea(url.mirea), geom = "freqpoly")
# 
# ggplot(table, aes(summ)) + 
#         geom_freqpoly()
# 
# barplot(table.mirea(url.mirea)$summ)
