# source('mai.R')
source('mirea.R')


import <- function(){
  library(XML) #!
  library(ggplot2)
  library(gridExtra)
}



import()



# grid.arrange(graph.create(table.sort(mai.6), number(mai.6)), 
#              graph.create(table.sort(mai.9),number(mai.9)), ncol=2)
# 
# qplot(prior, data=table.mirea(url.mirea), weight=summ, geom="histogram")
# qplot(factor(prior), data=table.mirea(url.mirea), geom="bar", fill=factor(original))
# ggplot(table.mirea(url.mirea), aes(summ, fill=original)) + geom_bar(width=0.7) +
#   facet_wrap(~ prior + hostel)
