setwd("C:/Users/schinnamgar/Desktop/Final Research/dashboards")
if(file.exists("classifierranksconsolidation.csv"))
{
  file.remove("classifierranksconsolidation.csv")
  file.remove("ConsolidatedFinalRanks-byclassifier-alldatasets.csv")
  file.remove("ConsolidatedRankMean-byclassifier-alldatasets.csv")
}
for (iter in 1:10)
{
datasetname <- paste("dataset",iter,"finalranksbyclassifier-dashboard.csv",sep="")
dataset<-read.csv(datasetname,header=T)
if (iter==1)
write.table(dataset,"classifierranksconsolidation.csv",append=T,sep=",",row.names=F,eol = "\n")
else 
write.table(dataset,"classifierranksconsolidation.csv",append=T,sep=",",row.names=F,col.names=F,eol = "\n")
}
fulldataset <- read.csv("classifierranksconsolidation.csv")
ConsolidatedRankMean <- aggregate(RankMean ~ ClassifierCode, fulldataset, mean)
ConsolidatedFinalRank <- aggregate(FinalRank ~ ClassifierCode, fulldataset, sum)
ConsolidatedRankMean$FinalConsolidatedRank <- rank(ConsolidatedRankMean$RankMean,ties.method="min",na.last = T)
ConsolidatedFinalRank$FinalConsolidatedRank <- rank(ConsolidatedFinalRank$FinalRank,ties.method="min",na.last = T)
write.table(ConsolidatedRankMean,"ConsolidatedRankMean-byclassifier-alldatasets.csv",append=T,sep=",",row.names=F,eol = "\n")
write.table(ConsolidatedFinalRank,"ConsolidatedFinalRanks-byclassifier-alldatasets.csv",append=T,sep=",",row.names=F,eol = "\n")