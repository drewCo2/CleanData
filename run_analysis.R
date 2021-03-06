# Andrew A. Ritz
# Getting + Cleaning data course project.



# clean the workspace + load libs.
rm(list=ls())
library(dplyr)

# Data directory relative to your working directory.  Make sure to use setwd() to set
# an appropriate working directory.
DataDir<-"./UCI HAR Dataset" 
DataZip<-"./DataSet.zip"


# download the data set and extract it if it isn't available.
if(!file.exists(DataZip)){
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile = DataZip)
  unzip(zipfile = DataZip)
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

# loads a dataset that we will use for merging later.
# This function combines steps 2-4 per set.
loadDataSet<-function(dataPath, activityPath, subjectPath)
{
    
  cNames<-GetMeasurementNames()
  td<-read.table(dataPath)

    
  # Extract only the standar deviation and mean information.
  # data<-select(data,matches(pat))

  names(td)<-cNames

  pat<-"-mean\\(\\)|-std\\(\\)"
  cFilter<-grep(pat,cNames)
  data<-td[,cFilter]  
  
  # Append subject and activity information to the data set. 
  al<-GetActivityData()
  act<-read.table(activityPath)
  data$Activity<-factor(act$V1, levels=al[,1], labels=al[,2])

  subject<-read.table(subjectPath, header=FALSE)
  data$Subject<-subject$V1
  
  data
}


# Load the test data.
# The script will create a set of path variables that it will use to load the correct data for
# each of the data sets. Each data set requires information for the source data, and its associated
# activity an subject information.
# 'loadDataSet' function extracts mean/std information + sets subject/activity data.
testData<- paste(DataDir, "/test/X_test.txt", sep="")
testActivity<-paste(DataDir, "/test/y_test.txt", sep="")
testSubject<-paste(DataDir, "/test/subject_test.txt", sep="")
testSet<-loadDataSet(testData, testActivity, testSubject)

# Load the training data.
trainData<- paste(DataDir, "/train/X_train.txt", sep="")
trainActivity<-paste(DataDir, "/train/y_train.txt", sep="")
trainSubject<-paste(DataDir, "/train/subject_train.txt", sep="")
trainSet<-loadDataSet(trainData, trainActivity, trainSubject)


# Merge the test + train data sets into a final set. (Item #1)
merged<-rbind(testSet, trainSet)



# Create the final tidy data set (#5)
# The aggregate function is applying mean to everything in the dataset (.) and creating
# a cross reference for each based on Activity and Subject.
tidy<-aggregate(. ~Subject + Activity, merged, mean)

# Write outout for inspection.
write.table(tidy, "TidyData.txt", row.names = FALSE)
write.csv(tidy, "TidySet.csv")
