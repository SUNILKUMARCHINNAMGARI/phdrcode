library(tm)
library(caret)
setwd("C:/Users/schinnamgar/Desktop/Final research/Short answers/Data")
set.seed(123)
for(iter in 1:10)
{
num=5
while (num <=25)
{
datasetname <- paste("dataset",iter,".csv",sep="")
dataset_raw_name <- paste("dataset",iter,"-","raw",".","csv",sep="")
dataset_tf_name <- paste("dataset",iter,"-","tf-",num,".","csv",sep="")
if(file.exists(dataset_tf_name))
file.remove(dataset_tf_name)
dataset <- read.csv(datasetname)
dataset <- dataset[,-1]
essaytextcorpus <- Corpus(VectorSource(dataset[,2]))
essaytextcorpus <- tm_map(essaytextcorpus,tolower)
essaytextcorpus <- tm_map(essaytextcorpus,removePunctuation)
essaytextcorpus <- tm_map(essaytextcorpus,removeWords,stopwords())
essaytextcorpus <- tm_map(essaytextcorpus,stripWhitespace)
essaytextcorpus <- tm_map(essaytextcorpus,stemDocument)
essaytextcorpus_dtm <- DocumentTermMatrix(essaytextcorpus)
essay_dict <- findFreqTerms(essaytextcorpus_dtm, num)
essaytextcorpus_dtm <- DocumentTermMatrix(essaytextcorpus,list(dictionary = essay_dict))
essaytextcorpus_matrix <- as.matrix(essaytextcorpus_dtm)
convert_counts <- function(x) {
  x <- ifelse(x > 0, 1, 0)
  x <- factor(x, levels = c(0, 1))
  return(x)
}
essaytextcorpus_dtm <- apply(essaytextcorpus_dtm, MARGIN = 2, convert_counts)
write.table(essaytextcorpus_dtm,dataset_tf_name,append = FALSE,sep=",",eol = "\n",row.names=F)
num=num+5
}
}