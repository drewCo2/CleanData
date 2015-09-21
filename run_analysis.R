


mergeDatasets<-function()
{
  DataDir<-"UCI HAR Dataset"
  
  # activity labels.
  alPath<-paste(DataDir,"/activity_labels.txt", sep="")
  alRaw<-read.fwf(alPath, widths=c(2,18), col.names=c("id", "activity"), header=FALSE)
  
  alFactor<-factor(alRaw$id, labels=alRaw$activity)

  alFactor
  # gee, we could probably find a better way to do this.....
  #  alData<-data.frame(alRaw)
    
  #alData
  # c(alData)
}

