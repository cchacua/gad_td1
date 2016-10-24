# Évolution de la production en France des marchés clients
library(xlsx)
library(ggplot2)

# Files
filesd<-list.files(path="./data/demande/", full.names=TRUE)
filesd


pro.md.fr<-read.xlsx2(filesd[1], 1)

colnames(pro.md.fr)<-c("Année",
                       "Mois",
                       "Fabrication de savons, détergents et produits d’entretien",
                       "Fabrication de parfums et de produits pour la toilette",
                       "Fabrication de produits pharmaceutiques de base")
        
pro.md.fr$'Mois'<-as.character(pro.md.fr$'Mois')
pro.md.fr$'Mois'<-ifelse(nchar(pro.md.fr$'Mois')==1, paste("0", pro.md.fr$'Mois', sep=""), pro.md.fr$'Mois')
pro.md.fr$'Année'<-as.numeric(as.character(pro.md.fr$'Année'))
pro.md.fr$id<-paste(pro.md.fr$'Année', pro.md.fr$'Mois', sep="")


pro.md.fr<-open.insee.monthly(filesd[1])
summary(pro.md.fr)
d2<-sapply(pro.md.fr, as.numcol)

pro.md.fr2<-read.xlsx(filesd[2], 1)
colnames(pro.md.fr2)<-c("Année",
                       "Mois",
                       "Industries alimentaires",
                       "Boissons")
pro.md.fr2$id<-paste(pro.md.fr2$'Année', pro.md.fr2$'Mois', sep="")

pro.md.fr.all<-merge(pro.md.fr,pro.md.fr2,by="id")
pro.md.fr.all$"Agro-alimentaire : nourriture et boissons"<-as.numeric(as.character(pro.md.fr.all$`Industries alimentaires`))+as.numeric(as.character(pro.md.fr.all$Boissons))/2
pro.md.fr.all$'Année.x'<-as.numeric(as.character(pro.md.fr.all$'Année.x'))
pro.md.fr.all<-pro.md.fr.all[pro.md.fr.all$'Année.x'>=2008,]

pro.md.fr<-pro.md.fr['Libellé'=="2010",]

