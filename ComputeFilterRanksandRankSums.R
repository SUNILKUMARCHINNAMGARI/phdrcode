setwd("C:/Users/schinnamgar/Desktop/Final Research/dashboards")
for(iter in 1:10)
{
datasetdashboard <- paste("dataset",iter,"-dashboard.csv",sep="")
datasetranks <- paste("dataset",iter,"ranks-dashboard.csv",sep="")
datasetfinalranks <- paste("dataset",iter,"finalranks-dashboard.csv",sep="")
dashds <- read.csv(datasetdashboard,header=T)
for (k in 1 : nrow(dashds))
{
if (grepl("chi", dashds[k,1]) == T)
dashds[k,6] <- 1
else if (grepl("-gain", dashds[k,1]) == T)
dashds[k,6] <- 2
else if (grepl("infogain", dashds[k,1]) == T)
dashds[k,6] <- 3
else if (grepl("relief", dashds[k,1]) == T)
dashds[k,6] <- 4
else if (grepl("symmetrical", dashds[k,1]) == T)
dashds[k,6] <- 5
else if (grepl("nzv", dashds[k,1]) == T)
dashds[k,6] <- 6
else if (grepl("pca0.9-", dashds[k,1]) == T)
dashds[k,6] <- 7
else if (grepl("pca0.92", dashds[k,1]) == T)
dashds[k,6] <- 8
else if (grepl("pca0.94", dashds[k,1]) == T)
dashds[k,6] <- 9
else if (grepl("pca0.96", dashds[k,1]) == T)
dashds[k,6] <- 10
else if (grepl("pca0.98", dashds[k,1]) == T)
dashds[k,6] <- 11
else if (grepl("tf5", dashds[k,1]) == T)
dashds[k,6] <- 12
else if (grepl("tf10", dashds[k,1]) == T)
dashds[k,6] <- 13
else if (grepl("tf15", dashds[k,1]) == T)
dashds[k,6] <- 14
else if (grepl("tf20", dashds[k,1]) == T)
dashds[k,6] <- 15
else if (grepl("tf25", dashds[k,1]) == T)
dashds[k,6] <- 16
}
colnames(dashds)[6] <- "FilterCode"
dashds$AccuracyRank <- rank(-dashds$Accuracy,ties.method="min",na.last = T)
dashds$FScoreRank <- rank(-dashds$FScore,ties.method="min",na.last = T)
dashds$KappaRank <- rank(-dashds$Kappa,ties.method="min",na.last = T)
dashds$MeanAbsoluteErrorRank <- rank(dashds$Mean.Absolute.Error,ties.method="min",na.last = T)
dashds$RankMean = dashds$AccuracyRank+dashds$FScoreRank+dashds$KappaRank+dashds$MeanAbsoluteErrorRank
ConsolidatedRankMean <- aggregate(RankMean ~ FilterCode, dashds, mean)
ConsolidatedRankMean$FinalRank <- rank(ConsolidatedRankMean$RankMean,ties.method="min",na.last = T)
if(file.exists(datasetranks) | file.exists(datasetfinalranks))
{
  file.remove(datasetranks)
  file.remove(datasetfinalranks)
}
write.table(dashds,datasetranks,append=T,sep=",",row.names=F,eol = "\n")
write.table(ConsolidatedRankMean,datasetfinalranks,append=T,sep=",",row.names=F,eol = "\n")
}