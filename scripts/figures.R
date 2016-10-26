
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
lapply(demande.df, maketsgraphandrates)

offre.df<-read.xlsx2(files[3], "Offre")
lapply(offre.df, maketsgraphandrates)


maketsgraph(demande.df$a1)
das<-
  maketsgraphandrates(demande.df$a1)

#Change colors in points and line for 2016