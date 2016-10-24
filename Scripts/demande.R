# Évolution de la production en France des marchés clients
library(xlsx)
library(ggplot2)
library(reshape)

# Files
filesd<-list.files(path="./data/demande/", full.names=TRUE)
filesd

pro.md.fr1<-open.insee.monthly(filesd[1])
colnames(pro.md.fr1)<-c("Année",
                       "Mois",
                       "Fabrication de savons, détergents et produits d’entretien",
                       "Fabrication de parfums et de produits pour la toilette",
                       "Fabrication de produits pharmaceutiques de base", 
                       "id")


pro.md.fr2<-open.insee.monthly(filesd[2])
colnames(pro.md.fr2)<-c("Année",
                       "Mois",
                       "Industries alimentaires",
                       "Boissons", 
                       "id")
pro.md.fr2$"Agro-alimentaire : nourriture et boissons"<-(pro.md.fr2[,3]+pro.md.fr2[,4])/2
pro.md.fr2<-pro.md.fr2[,5:6]

pro.md.fr.all<-merge(pro.md.fr1,pro.md.fr2,by="id")
pro.md.fr.all<-pro.md.fr.all[pro.md.fr.all$id>=200801,]
pro.md.fr.all<-pro.md.fr.all[pro.md.fr.all$id<=201606,]
pro.md.fr.all<-na.omit(pro.md.fr.all)

pro.md.fr.all<-aggregate(pro.md.fr.all, list("Année" = pro.md.fr.all$"Année"), mean)


