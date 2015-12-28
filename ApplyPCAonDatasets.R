library(tm)
library(caret)
setwd("C:/Users/schinnamgar/Desktop/Final research/Short answers/Data")
set.seed(123)
for(iter in 1:10)
{
  datasetname <- paste("dataset",iter,".csv",sep="")
  dataset_raw_name <- paste("dataset",iter,"-","raw",".","csv",sep="")
  orig_dataset <- read.csv(datasetname)
  orig_dtmdataset <- read.csv(dataset_raw_name)  
  for (num in c(0.90,0.92,0.94,0.96,0.98))
   {
   preproc <- preProcess(orig_dtmdataset,method="pca",thresh=num)
   datasetPC <- predict(preproc,orig_dtmdataset)
   dataset_pca_name <- paste("dataset",iter,"-","pca-",num,".","csv",sep="")
   if(file.exists(dataset_pca_name))
   {
     file.remove(dataset_pca_name)
   }
   write.table(datasetPC,dataset_pca_name,sep=",",eol = "\n",col.names=T,row.names=F)
}
}