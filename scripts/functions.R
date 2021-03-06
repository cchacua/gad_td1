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

substrRight <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}

maketsgraphsimple<-function(ts){
  serie<-as.data.frame(ts)
  data<-as.data.frame(serie[9:17,])
  data$yers<-seq(2008, 2016, 1)
  data[,1]<-as.numcol(data[,1])
  data<-na.omit(data)
  colnames(data)<-c("values", "temps")
  filename<-str_replace_all(serie[2,1], "[^[:alnum:]]", " ")
  windowsFonts()
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
  windowsFonts(arial=windowsFont("Arial"))
  
    p<-ggplot(data=data,
              aes(x=temps, y= values)) +
      geom_line(colour = "#0072B2") +
      geom_point(aes(colour=colors))+
      xlab('Ann\u{E9}e')+
      ylab(serie[1,1])+
      # ggtitle(serie[2,1])+
      #theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
      theme(text=element_text(family="arial", size=10))+
      theme(legend.position="none")
    
    ggsave(file=paste0("../output/", filename, ".png", sep=""), plot=p, width = 10, height = 5, units = "cm", scale=1)
    
    
  croissance<-data[2:nrow(data),1:2]
  croissance$valuest<-data[1:nrow(data)-1,1]
  croissance$taux<-((croissance$values/ croissance$valuest)-1)*100
  croissance$temps<-paste(substrRight(data[1:nrow(data)-1,2],2), substrRight(data[2:nrow(data),2],2),sep=" - " )
  print(croissance) 
   q<-ggplot(data=croissance,
             aes(x=temps, y= taux)) +
     geom_bar(stat="identity", color="#009E73", fill="#009E73")+
     #geom_line(colour = "#009E73") +
     #stat_smooth(se=FALSE)+
     #geom_point(colour = "#009E73")+
     xlab('P\u{E9}riode')+
     ylab("% de variation")+
     geom_hline(aes(yintercept=0))+
     # ggtitle(serie[2,1])+
     theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
     theme(text=element_text(family="arial", size=8))
     #theme(axis.text.x = element_text(angle=15, vjust=1, size=7, hjust=1))
   ggsave(file=paste0("../output/", filename, "-croissance.png", sep=""), plot=q, width = 10, height = 4, units = "cm", scale=1)
  data  
}  

maketsgraphandrates.two<-function(ts, label1="Europe", label2="France"){
  serie<-as.data.frame(ts)
  data<-as.data.frame(serie[9:17,])
  data$yers<-seq(2008, 2016, 1)
  data1<-data[,c(1,3)]
  data1$origin<-label1
  data1[,1]<-as.numcol(data1[,1])
  colnames(data1)<-c("values", "temps", "origin")
  data2<-data[,c(2,3)]
  data2$origin<-label2
  data2[,1]<-as.numcol(data2[,1])
  colnames(data2)<-c("values", "temps", "origin")
  data<-rbind(data1, data2)
  data[,1]<-as.numcol(data[,1])
  data<-na.omit(data)
  print(data)
  filename<-str_replace_all(serie[2,1], "[^[:alnum:]]", " ")
  windowsFonts(arial=windowsFont("Arial"))
  
  p<-ggplot(data=data,
            aes(x=temps, y= values, group=origin, color=origin)) +
    geom_line() +
    geom_point()+
    xlab('Ann\u{E9}e')+
    ylab(serie[1,1])+
    # ggtitle(serie[2,1])+
    #theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    theme(text=element_text(family="arial", size=10))+
    scale_color_discrete(name="")
  ggsave(file=paste0("../output/", filename, ".png", sep=""), plot=p, width = 10, height = 5, units = "cm", scale=1)
  
  croissance1<-data1[2:nrow(data1),1:3]
  croissance1$valuest<-data1[1:nrow(data1)-1,1]
  croissance1$taux<-((croissance1$values/ croissance1$valuest)-1)*100
  croissance1$temps<-paste(substrRight(data1[1:nrow(data1)-1,2],2), substrRight(data1[2:nrow(data1),2],2),sep=" - " )
  croissance1<-na.omit(croissance1)
  print(croissance1) 
  
  croissance2<-data2[2:nrow(data2),1:3]
  croissance2$valuest<-data2[1:nrow(data2)-1,1]
  croissance2$taux<-((croissance2$values/ croissance2$valuest)-1)*100
  croissance2$temps<-paste(substrRight(data2[1:nrow(data2)-1,2],2), substrRight(data2[2:nrow(data2),2],2),sep=" - " )
  croissance2<-na.omit(croissance2)
  print(croissance2) 
  
  croissance<-rbind(croissance1[,c("temps", "taux","origin")], croissance2[,c("temps", "taux","origin")])
  q<-ggplot(data=croissance,
            aes(x=temps, y= taux, fill=origin)) +
    geom_bar(stat="identity",position=position_dodge())+
    #geom_line(colour = "#009E73") +
    #stat_smooth(se=FALSE)+
    #geom_point(colour = "#009E73")+
    xlab('P\u{E9}riode')+
    ylab("% de variation")+
    geom_hline(aes(yintercept=0))+
    # ggtitle(serie[2,1])+
    theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    theme(text=element_text(family="arial", size=8))+
    theme(legend.title=element_blank())
  #theme(axis.text.x = element_text(angle=15, vjust=1, size=7, hjust=1))
  ggsave(file=paste0("../output/", filename, "-croissance.png", sep=""), plot=q, width = 10, height = 4, units = "cm", scale=1)
  data  
}  

maketsgraphn<-function(ts){
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
  windowsFonts(arial=windowsFont("Arial"))
  
  p<-ggplot(data=data,
            aes(x=temps, y= values)) +
    #stat_smooth(se=FALSE)+
    #scale_colour_identity()+
    geom_line() +
    geom_point(aes(colour=colors))+
    xlab("Année")+
    ylab(serie[1,1])+
    # ggtitle(serie[2,1])+
    #theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    theme(text=element_text(family="arial", size=10))+
  theme(legend.position="none")
  ggsave(file=paste("../output/", filename, ".png", sep=""), plot=p, width = 10, height = 5, units = "cm", scale=1)
  filename
} 

maketsrates<-function(ts){
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
  windowsFonts(arial=windowsFont("Arial"))
  
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
    geom_hline(aes(yintercept=0))+
    # ggtitle(serie[2,1])+
    theme(plot.title = element_text(size=11, face="bold", margin = margin(0, 0, 5, 0)))+
    theme(text=element_text(family="arial", size=8))
  ggsave(file=paste0("../output/", filename, "-croissance.png", sep=""), plot=q, width = 10, height = 3, units = "cm", scale=1)
  
  
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
