setwd("C:/Users/schinnamgar/Desktop/Final Research/dashboards")
if(file.exists("filtersranksconsolidation.csv"))
{
  file.remove("filtersranksconsolidation.csv")
  file.remove("ConsolidatedFinalRanks-byfilters-alldatasets.csv")
  file.remove("ConsolidatedRankMean-byfilters-alldatasets.csv")
}
for (iter in 1:10)
{
datasetname <- paste("dataset",iter,"finalranks-dashboard.csv",sep="")
dataset<-read.csv(datasetname,header=T)
if (iter==1)
write.table(dataset,"filtersranksconsolidation.csv",append=T,sep=",",row.names=F,eol = "\n")
else 
write.table(dataset,"filtersranksconsolidation.csv",append=T,sep=",",row.names=F,col.names=F,eol = "\n")
}
fulldataset <- read.csv("filtersranksconsolidation.csv")
ConsolidatedRankMean <- aggregate(RankMean ~ FilterCode, fulldataset, mean)
ConsolidatedFinalRank <- aggregate(FinalRank ~ FilterCode, fulldataset, sum)
ConsolidatedRankMean$FinalConsolidatedRank <- rank(ConsolidatedRankMean$RankMean,ties.method="min",na.last = T)
ConsolidatedFinalRank$FinalConsolidatedRank <- rank(ConsolidatedFinalRank$FinalRank,ties.method="min",na.last = T)
write.table(ConsolidatedRankMean,"ConsolidatedRankMean-byfilters-alldatasets.csv",append=T,sep=",",row.names=F,eol = "\n")
write.table(ConsolidatedFinalRank,"ConsolidatedFinalRanks-byfilters-alldatasets.csv",append=T,sep=",",row.names=F,eol = "\n")