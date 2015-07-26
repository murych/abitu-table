source('functions.R')

import()

mai.9 <- 'http://techcoockbooknotes.blogspot.com/2015/07/9-120304.html'
mai.6 <- 'http://techcoockbooknotes.blogspot.com/2015/07/6-120304.html'

grid.arrange(graph.create(table.sort(mai.6), number(mai.6)), 
             graph.create(table.sort(mai.9),number(mai.9)), ncol=2)