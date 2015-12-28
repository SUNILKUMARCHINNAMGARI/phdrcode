setwd("C:/Users/schinnamgar/Desktop/Final Research/dashboards")
for(iter in 1:10)
{
datasetdashboard <- paste("dataset",iter,"-dashboard.csv",sep="")
datasetranks <- paste("dataset",iter,"ranksbyclassifier-dashboard.csv",sep="")
datasetfinalranks <- paste("dataset",iter,"finalranksbyclassifier-dashboard.csv",sep="")
dashds <- read.csv(datasetdashboard,header=T)
for (k in 1 : nrow(dashds))
{
if (grepl("c50", dashds[k,1]) == T)
dashds[k,6] <- 1
else if (grepl("knn", dashds[k,1]) == T)
dashds[k,6] <- 2
else if (grepl("nb", dashds[k,1]) == T)
dashds[k,6] <- 3
else if (grepl("nnet", dashds[k,1]) == T)
dashds[k,6] <- 4
else if (grepl("OneR", dashds[k,1]) == T)
dashds[k,6] <- 5
else if (grepl("RIPPER", dashds[k,1]) == T)
dashds[k,6] <- 6
else if (grepl("SVM", dashds[k,1]) == T)
dashds[k,6] <- 7
else if (grepl("svm", dashds[k,1]) == T)
dashds[k,6] <- 7
}
colnames(dashds)[6] <- "ClassifierCode"
dashds$AccuracyRank <- rank(-dashds$Accuracy,ties.method="min",na.last = T)
dashds$FScoreRank <- rank(-dashds$FScore,ties.method="min",na.last = T)
dashds$KappaRank <- rank(-dashds$Kappa,ties.method="min",na.last = T)
dashds$MeanAbsoluteErrorRank <- rank(dashds$Mean.Absolute.Error,ties.method="min",na.last = T)
dashds$RankMean = dashds$AccuracyRank+dashds$FScoreRank+dashds$KappaRank+dashds$MeanAbsoluteErrorRank
ConsolidatedRankMean <- aggregate(RankMean ~ ClassifierCode, dashds, mean)
ConsolidatedRankMean$FinalRank <- rank(ConsolidatedRankMean$RankMean,ties.method="min",na.last = T)
if(file.exists(datasetranks) | file.exists(datasetfinalranks))
{
  file.remove(datasetranks)
  file.remove(datasetfinalranks)
}
write.table(dashds,datasetranks,append=T,sep=",",row.names=F,eol = "\n")
write.table(ConsolidatedRankMean,datasetfinalranks,append=T,sep=",",row.names=F,eol = "\n")
}