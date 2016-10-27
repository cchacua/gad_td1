
  # install.packages("devtools")
  # install.packages("xlsx")
  # install.packages("ggthemes")
  # 
  # library("devtools")
  # install_github(c("hadley/ggplot2", "jrnold/ggthemes"))
  # 
  # library(reshape)
  # library(RColorBrewer)
  # library(ggthemes)
  # install.packages("stringr")


# Évolution de la production en France des marchés clients


library(xlsx)
library(ggplot2)
library(stringr)

# Analysis of demand

# Files
files<-list.files(path="./data/", full.names=TRUE)
files

demande.df<-read.xlsx2(files[1], 1)

#Marchés clients fr - INSEE
sapply(demande.df[,2:5], maketsgraphandrates)
maketsgraphandrates(demande.df$a1)

#Marchés clients EU-FR - Eurostat
maketsgraphandrates.two(demande.df[,6:7])
maketsgraphandrates.two(demande.df[,8:9])
maketsgraphandrates.two(demande.df[,10:11])
maketsgraphandrates.two(demande.df[,12:13])

# Consommation des menages
demande2.df<-read.xlsx2(files[2], 1)
sapply(demande2.df[,14:15], maketsgraphandrates)


# Offre
offre.df<-read.xlsx2(files[3], 2)
sapply(offre.df[,5:8], maketsgraphandrates)
maketsgraphandrates(offre.df[,9])

#Configuration productive
conf.df<-read.xlsx2(files[3], 3)
sapply(conf.df[,2:3], maketsgraphandrates)

  

