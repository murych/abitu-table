import <- function(){
  library(XML)
  library(ggplot2)
}

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  # Multiple plot function
  #
  # ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
  # - cols:   Number of columns in layout
  # - layout: A matrix specifying the layout. If present, 'cols' is ignored.
  #
  # If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
  # then plot 1 will go in the upper left, 2 will go in the upper right, and
  # 3 will go all the way across the bottom.
  #
  
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
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

multiplot(graph.create(table.sort(mai.6), number(mai.6)), graph.create(table.sort(mai.9),number(mai.9)), cols = 2)