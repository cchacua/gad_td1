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
  df
}

as.numcol<-function(x){
  y<-as.numeric(as.character(x))
  y
}
