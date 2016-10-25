# Évolution de la production en France des marchés clients
library("devtools")
install_github(c("hadley/ggplot2", "jrnold/ggthemes"))

library(xlsx)
library(ggplot2)
library(reshape)
library(RColorBrewer)
library("ggthemes")


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
p<-ggplot(data=data,
          aes(x=temps, y= values)) +
  geom_line() +
  geom_point()+
  scale_fill_brewer(palette="Set2")
p  
aes(colour="#00BFC4")
  
  geom_bar(position=position_dodge(),stat="identity") + 
  theme(legend.position="bottom")+ theme(legend.background = element_rect(fill="#EBEBEB", size=.5, linetype="dotted"))
p<-p+xlab("Production")+ylab("Facturations (en milliers d'euros)")+labs(fill="Année")
library(scales)
p<-p+scale_y_continuous(labels=function(x) format(x, big.mark = " ", scientific = FALSE))+
  ggtitle("Evolution entre 2013 et 2015 des cinq plus importantes \n productions françaises facturées en 2015.")+
  theme(plot.title = element_text(lineheight=.9, face="bold"))+
  scale_x_discrete(labels=c("Aéronefs et \n engins spatiaux","Produits du raffinage","Véhicules \n automobiles","Préparations \n pharmaceutiques", "Commerce du gaz \n par réseau")) +
  theme(text=element_text(family="Times", face="bold", size=12))
p
ggsave(file=paste(serie[,2], ".png", sep=""), width = 28, height = 17, units = "cm", scale=0.78)


df.rnames<-rownames(df)
df.rnames[9:17]<-df$x0[9:17]
rownames(df)<-df.rnames
