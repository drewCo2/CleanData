#Course Project Codebook

##Variables
The script only contains a few variables that direct its operation:  
1. DataDir: This is the directory that the source data will be downloaded.  It is relative to your working directory.  
2. DataZip: The name of the zip file that contains the source data.  Also relative to the working directory.  
3. Additional path variables that are required for loading the data are computed, based on DataDir so that the script    functions can be sure to read from the correct locations on disk.  They are variables for activity, subject, and data paths.  See the comments on line 75 of run_analysis.R for more information.  



##Script Process + data transformations.
The script performs the following actions:

1. Clears the workspace, loads libraries, and sets global variables.
2. Each set of test and training data is loaded in the loadDataSet() function.  This function does most of the
   transformation work by reading the raw data, naming the columns, extracting only the mean and standard deviation
   information, and finally appends the corresponding activity and subject information to this subset.
   
3. Once the test and training data sets are loaded (in step #2, above), they are combined into a single, final data
   set that can be used for further analysis.

4. The script then uses the merged data from step #3 to create a tidy data set that summarizes the mean of each
   measurement, cross referenced by the activity and subject.  The data is output to a text file, and a csv file
   that can be loaded into a spreadsheet program for convenient reading.


##Data Names:
The names of the data columns, with exception of Activity and Subject use a simple naming convention.
The name of the measurement is followed by either mean() or std() and then by the axis of the measurement.

For example:
'tBodyAcc-mean()-Y' describes the mean value of the tBodyAcc measurement on the y-axis.
'fBodyAcc-std()-X' describes the standard deviation of the fBodyAcc measurement on the x-axis.
