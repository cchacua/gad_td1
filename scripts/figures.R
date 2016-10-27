
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

# Consommation des menages
demande2.df<-read.xlsx2(files[2], 1)
sapply(demande2.df[,14:15], maketsgraphandrates)


for(col in names(demande.df)){
  demande.df[[col]] <- maketsgraphandrates(demande.df[[col]])
}

apply(demande.df,2, maketsgraphandrates)


sapply(demande.df[,2:ncol(demande.df)], maketsgraphn)


offre.df<-read.xlsx2(files[3], "Offre")
lapply(offre.df, maketsgraphandrates)


maketsgraph(demande.df$a1)
das<-
  maketsgraphn(demande.df$a2)

#Change colors in points and line for 2016