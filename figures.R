
  # install.packages("devtools")
  # install.packages("xlsx")
  # install.packages("ggthemes")
  # 
  # library("devtools")
  # install_github(c("hadley/ggplot2", "jrnold/ggthemes"))
  # 
  # library(reshape)
  # library(RColorBrewer)
install.packages("stringr")
# Évolution de la production en France des marchés clients


library(xlsx)
library(ggthemes)
library(ggplot2)
library(stringr)

# Analysis of demand

# Files
files<-list.files(path="./data/", full.names=TRUE)
files

df<-read.xlsx2(files[1], 1)

  
serie<-as.data.frame(df$a1)
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
  # theme(plot.title = element_text(size=11, face="bold", 
  #                                 margin = margin(0, 0, 5, 0)))+
  theme(text=element_text(family="arial", size=10))
ggsave(file=paste0("../output/", filename, ".png", sep=""), width = 10, height = 5, units = "cm", scale=1)

p

#Change colors in points and line for 2016