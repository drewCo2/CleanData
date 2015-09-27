# clean the workspace + load libs.
rm(list=ls())
library(dplyr)

# Data directory relative to your working directory.  Make sure to use setwd() to set
# an appropriate working directory.
DataDir<-"UCI HAR Dataset" 

# Loads the feature labels from disk 
loadFeatures<-function()
{
  path<-paste(DataDir,"/features.txt", sep="")
  res<-read.table(path)
  as.vector(res[,2])
}


# Get all of the measurement names.
GetMeasurementNames<-function()
{
  mPath<-paste(DataDir,"/features.txt",sep="")
  mData<-read.table(mPath)
  mData[[2]]  # Just the names folks!
}

# Get all of the activity names.
GetActivityData<-function()
{
  # Note, we could memoize for better performance later.  
  # activity labels, as a factor
  alPath<-paste(DataDir,"/activity_labels.txt", sep="")
  al<-read.table(alPath, header=FALSE) 
  al
}

# loads a dataset that we will merge later.
loadDataSet<-function(dataPath, activityPath, subjectPath)
{
    
  cNames<-GetMeasurementNames()
  data<-read.table(dataPath, col.names = cNames)

  # Extract only the standar deviation and mean information.
  pat<-"mean()|std()"
  data<-select(data,matches(pat))

  
  # Append subject and activity information to the data set. 
  al<-GetActivityData()
  act<-read.table(activityPath)
  data$Activity<-factor(act$V1, levels=al[,1], labels=al[,2])

#  subject<-read.table(subjectPath)
#  data$Subject<-subject
  
  data
}



# Load the test data.  'loadDataSet' function extracts mean/std information + sets subject/activity data.
testData<- paste(DataDir, "/test/X_test.txt", sep="")
testActivity<-paste(DataDir, "/test/y_test.txt", sep="")
testSubject<-paste(DataDir, "/test/subject_test.txt", sep="")
testSet<-loadDataSet(testData, testActivity, testSubject)

# Load the train data.
trainData<- paste(DataDir, "/train/X_train.txt", sep="")
trainActivity<-paste(DataDir, "/train/y_train.txt", sep="")
trainSubject<-paste(DataDir, "/train/subject_train.txt", sep="")
trainSet<-loadDataSet(trainData, trainActivity, trainSubject)

#merge the data.
mSet<-rbind(testSet, trainSet)

# Determine which columns we want to extract from.  Use a pattern match.
#cIndexes<-grep(pat,colnames(mSet))

#final<-mSet[cIndexes,]


