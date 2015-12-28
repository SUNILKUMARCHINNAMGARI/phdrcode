library(tm)
library(caret)
setwd("C:/Users/schinnamgar/Desktop/Final research/Short answers/Data")
set.seed(123)
for(iter in 1:10)
{
  datasetname <- paste("dataset",iter,".csv",sep="")
  dataset_raw_name <- paste("dataset",iter,"-","raw",".","csv",sep="")
  dataset_nzv_name <- paste("dataset",iter,"-","nzv",".","csv",sep="")
dataset <- read.csv(datasetname)
dataset <- dataset[,-1]
essaytextcorpus <- Corpus(VectorSource(dataset[,2]))
essaytextcorpus <- tm_map(essaytextcorpus,tolower)
essaytextcorpus <- tm_map(essaytextcorpus,removePunctuation)
essaytextcorpus <- tm_map(essaytextcorpus,removeWords,stopwords())
essaytextcorpus <- tm_map(essaytextcorpus,stripWhitespace)
essaytextcorpus <- tm_map(essaytextcorpus,stemDocument)
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1))
  return(x)
}
essaytextcorpus_dtm <- DocumentTermMatrix(essaytextcorpus)
essaytextcorpus_dtm <- apply(essaytextcorpus_dtm, MARGIN = 2, convert_counts)
write.table(essaytextcorpus_dtm,dataset_raw_name,append = FALSE,sep=",",eol = "\n",row.names=F)
calc_nzv<-nearZeroVar(essaytextcorpus_dtm)
essaytextcorpus_dtm<-essaytextcorpus_dtm[ ,-calc_nzv]
write.table(essaytextcorpus_dtm,dataset_nzv_name,append = FALSE,sep=",",eol = "\n",row.names=F)
rm(list=setdiff(ls(), "iter"))
}