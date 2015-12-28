setwd("C:/Users/schinnamgar/Desktop/Final research/Short answers/Data")
filenames <- list.files(pattern="*metrics.csv",full.names=T,recursive=T)
filenames <- data.frame(filenames)
for (iter in 1:10)
{
pattern = paste("dataset",iter,"-",sep="")
outputdf <- cbind("Metric From","Accuracy","Kappa","FScore","Mean Absolute Error")
outputfilename <- paste(pattern,"dashboard.csv",sep="")
if(file.exists(outputfilename))
{
  file.remove(outputfilename)
}
write.table(outputdf,outputfilename,append=T,sep=",",eol = "\n",col.names=F,row.names=F)
filenames_subset <- filenames[grepl(pattern, filenames[,1]),]
for (file in filenames_subset)
{
   ldf <- read.csv(file)
   outputdf <- cbind(file,round(ldf[4,2]*100),ldf[5,2],ldf[6,2],ldf[7,2])
   write.table(outputdf,outputfilename,append=T,sep=",",eol = "\n",col.names=F,row.names=F)
}
}