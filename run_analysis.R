
# convenience function.
dataDir<-function() { "UCI HAR Dataset" }




# Loads the feature labels from disk 
loadFeatures<-function()
{
  path<-paste(dataDir(),"/features.txt", sep="")
  res<-read.table(path)
  as.vector(res[,2])
}

# loads a dataset that we will merge later.
loadDataSet<-function(dataPath, activityPath)
{

}


# merge one or more datasets into a single data set.
mergeDatasets<-function(dataSets)
{
}


GetActivityFactors<-function()
{
  dataDir<-DataDir()
  
  # activity labels, as a factor
  alPath<-paste(DataDir,"/activity_labels.txt", sep="")
  alRaw<-read.fwf(alPath, widths=c(2,18), col.names=c("id", "activity"), header=FALSE)
  alFactor<-factor(alRaw$id, labels=alRaw$activity)
  
  
  
  alFactor
  # gee, we could probably find a better way to do this.....
  #  alData<-data.frame(alRaw)
  
  #alData
  # c(alData)
}


# now run the analysis...

testData<- paste(dataDir(), "/test/X_test.txt", sep="")
testActivity<-paste(dataDir(), "/test/y_test.txt", sep="")
loadDataSet(testPath, testActivity)
