open.insee.monthly<-function(file.xls){
  df<-read.xlsx2(file.xls, 1)
  cnames<-colnames(df)
  cnames[1]<-"Année"
  cnames[2]<-"Mois"
  colnames(df)<-cnames
  df$'Mois'<-as.character(df$'Mois')
  df$'Mois'<-ifelse(nchar(df$'Mois')==1, paste("0", df$'Mois', sep=""), df$'Mois')
  df$'Année'<-as.numeric(as.character(df$'Année'))
  df$'id'<-paste(df$'Année', df$'Mois', sep="")
  df<-sapply(df, as.numcol)
  df<-as.data.frame(df)
  df
}

as.numcol<-function(x){
  y<-as.numeric(as.character(x))
  y
}

maketsgraphsimple<-function(ts){
  serie<-as.data.frame(ts)
  data<-as.data.frame(serie[9:17,])
  data$yers<-seq(2008, 2016, 1)
  data[,1]<-as.numcol(data[,1])
  data<-na.omit(data)
  colnames(data)<-c("values", "temps")
  filename<-str_replace_all(serie[2,1], "[^[:alnum:]]", " ")
  windowsFonts(arial=windowsFont("Arial"))
  p<-ggplot(data=data,
            aes(x=temps, y= values)) +
    geom_line(colour = "#0072B2") +
    #stat_smooth(se=FALSE)+
    geom_point(colour = "#0072B2")+
    xlab("Année")+
    ylab(serie[1,1])+
    # ggtitle(serie[2,1])+
    # theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    theme(text=element_text(family="arial", size=10))
  ggsave(file=paste0("../output/", filename, ".png", sep=""), width = 10, height = 5, units = "cm", scale=1)
}  

maketsgraph<-function(ts){
  serie<-as.data.frame(ts)
  data<-as.data.frame(serie[9:17,])
  data$yers<-seq(2008, 2016, 1)
  data[,1]<-as.numcol(data[,1])
  data<-na.omit(data)
  colnames(data)<-c("values", "temps")
  filename<-str_replace_all(serie[2,1], "[^[:alnum:]]", " ")
  #windowsFonts(arial=windowsFont("Arial"))
  p<-ggplot(data=data,
            aes(x=temps, y= values)) +
    geom_line(colour = "#0072B2") +
    #stat_smooth(se=FALSE)+
    geom_point(colour = "#0072B2")+
    xlab("Année")+
    ylab(serie[1,1])+
    # ggtitle(serie[2,1])+
    # theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    #theme(text=element_text(family="arial", size=10))
  ggsave(file=paste0("../output/", filename, ".png", sep=""), width = 10, height = 5, units = "cm", scale=1)
}  


maketsgraphandrates<-function(ts){
  serie<-as.data.frame(ts)
  data<-as.data.frame(serie[9:17,])
  data$yers<-seq(2008, 2016, 1)
  data[,1]<-as.numcol(data[,1])
  data$colors<-rep.int("#0072B2",9)
  data$colors[9]<-"#D55E00"
  data<-na.omit(data)
  colnames(data)<-c("values", "temps", "colors")
  print(data)
  filename<-str_replace_all(serie[2,1], "[^[:alnum:]]", " ")
  #windowsFonts(arial=windowsFont("Arial"))
  data
  p<-ggplot(data=data,
            aes(x=temps, y= values)) +
    #stat_smooth(se=FALSE)+
    geom_line(colour = "#0072B2") +
    #scale_colour_identity()+
    geom_point(aes(colour=colors))+
    # geom_line(colour = "#0072B2") +
    # geom_point(colour = "#0072B2")+
    xlab("Année")+
    ylab(serie[1,1])
    # ggtitle(serie[2,1])+
    # theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    #theme(text=element_text(family="arial", size=10))
    ggsave(file=paste0("../output/", filename, ".png", sep=""), width = 10, height = 5, units = "cm", scale=1)
  
  croissance<-data[2:nrow(data),1:2]
  croissance$valuest<-data[1:nrow(data)-1,1]
  croissance$taux<-((croissance$values/ croissance$valuest)-1)*100
  print(croissance) 
   q<-ggplot(data=croissance,
              aes(x=temps, y= taux)) +
      geom_line(colour = "#009E73") +
      #stat_smooth(se=FALSE)+
      geom_point(colour = "#009E73")+
      xlab("Année")+
      ylab("Taux de variation")+
      geom_hline(aes(yintercept=0))
    # ggtitle(serie[2,1])+
    # theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    #theme(text=element_text(family="arial", size=8))
    ggsave(file=paste0("../output/", filename, "-croissance.png", sep=""), width = 10, height = 3, units = "cm", scale=1)
    
  }  
# library(grid)
# library(gtable)
# 
# ggplot_with_subtitle <- function(gg, 
#                                  label="", 
#                                  fontfamily=NULL,
#                                  fontsize=10,
#                                  hjust=0, vjust=0, 
#                                  bottom_margin=5.5,
#                                  newpage=is.null(vp),
#                                  vp=NULL,
#                                  ...) {
#   
#   if (is.null(fontfamily)) {
#     gpr <- gpar(fontsize=fontsize, ...)
#   } else {
#     gpr <- gpar(fontfamily=fontfamily, fontsize=fontsize, ...)
#   }
#   
#   subtitle <- textGrob(label, x=unit(hjust, "npc"), y=unit(hjust, "npc"), 
#                        hjust=hjust, vjust=vjust,
#                        gp=gpr)
#   
#   data <- ggplot_build(gg)
#   
#   gt <- ggplot_gtable(data)
#   gt <- gtable_add_rows(gt, grobHeight(subtitle), 2)
#   gt <- gtable_add_grob(gt, subtitle, 3, 4, 3, 4, 8, "off", "subtitle")
#   gt <- gtable_add_rows(gt, grid::unit(bottom_margin, "pt"), 3)
#   
#   if (newpage) grid.newpage()
#   
#   if (is.null(vp)) {
#     grid.draw(gt)
#   } else {
#     if (is.character(vp)) seekViewport(vp) else pushViewport(vp)
#     grid.draw(gt)
#     upViewport()
#   }
#   
#   invisible(data)
#   
# }
