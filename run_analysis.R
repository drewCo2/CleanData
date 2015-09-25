library(dplyr)

DataDir<-"UCI HAR Dataset" 

# Loads the feature labels from disk 
loadFeatures<-function()
{
  path<-paste(DataDir,"/features.txt", sep="")
  res<-read.table(path)
  as.vector(res[,2])
}

# loads a dataset that we will merge later.
loadDataSet<-function(dataPath, activityPath)
{
  cNames<-GetMeasurementNames()
  data<-read.table(dataPath, col.names = cNames)
  act<-read.table(activityPath)
  
  data
}


# merge one or more datasets into a single data set.
# mergeDatasets<-function(dataSets)
# {
# }

# Get all of the measurement names.
GetMeasurementNames<-function()
{
  mPath<-paste(DataDir,"/features.txt",sep="")
  mData<-read.table(mPath)
  mData[[2]]  # Just the names folks!
}

# Get all of the activity names.
GetActivityFactors<-function()
{
  
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

testData<- paste(DataDir, "/test/X_test.txt", sep="")
testActivity<-paste(DataDir, "/test/y_test.txt", sep="")
testSet<-loadDataSet(testData, testActivity)

trainData<- paste(DataDir, "/train/X_train.txt", sep="")
trainActivity<-paste(DataDir, "/train/y_train.txt", sep="")
trainSet<-loadDataSet(trainData, trainActivity)

rt<-read.table(testData)
