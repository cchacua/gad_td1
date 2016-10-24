# Évolution de la production en France des marchés clients
library(xlsx)

pro.md.fr<-read.xlsx(filesd[1], 1)
pro.md.fr<-pro.md.fr['Libellé'=="2010",]

