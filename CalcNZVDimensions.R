setwd("C:/Users/schinnamgar/Desktop/Final research/Short answers/Data/nzv data")
set.seed(123)
texttowrite  <- cbind("dataset","Number of retained features")
write.table(texttowrite,"nzvfiledimensions.csv",append=T,sep=",",eol = "\n",col.names=F,row.names=F)
for(iter in 1:10)
{
   dataset_nzv_name <- paste("dataset",iter,"-","nzv",".","csv",sep="")
   nzvdataset <- read.csv(dataset_nzv_name)
   dimensions <- dim(nzvdataset)
   texttowrite  <- cbind(iter,dimensions[2])
   write.table(texttowrite,"nzvfiledimensions.csv",append=T,sep=",",eol = "\n",col.names=F,row.names=F)
}