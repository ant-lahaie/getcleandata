# Derived tidy datasets based on the Human Activity Recognition Using Smartphones Data Set 

Original data and more information at [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## files

CodeBook.md : project codebook
run_analysis.R : data wrangling script
dataFiltered.txt : original data narrowed to means and standard deviations with descriptive labels
dataFilteredAveraged.txt : dataFiltered.txt summarized by averaging all variables over each subject and activity

## variables

### dataFiltered

Each of the observations pertains to one of the experiment's 31 subjects, labeled by one of 6 types of motion.

The features selected for the original database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated.  

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

timeBodyAcceleration-XYZ
timeGravityAcceleration-XYZ
timeBodyAccelerationJerk-XYZ
timeBodyGyro-XYZ
timeBodyGyroJerk-XYZ
timeBodyAccelerationMagnitude
timeGravityAccelerationMagnitude
timeBodyAccelerationJerkMagnitude
timeBodyGyroMagnitude
timeBodyGyroJerkMagnitude
frequencyBodyAcceleration-XYZ
frequencyBodyAccelerationJerk-XYZ
frequencyBodyGyro-XYZ
frequencyBodyAccelerationMagnitude
frequencyBodyAccelerationJerkMagnitude
frequencyBodyGyroMagnitude
frequencyBodyGyroJerkMagnitude

For each, mean and standard deviation were calculated, marked by mean() and std() in the column names.

### dataFilteredAveraged

The preceding dataset was summarized by averaging all variables over each subject and activity.


## transformations

### dataFiltered

I started by reading the test data from X_test.txt and bound the activity and subject labels to the dataframe, repeating the same for the train data, and bound the two resulting dataframes together.

Reading the features, I cleaned up column names by substituting the abbreviations for full words. I then added "subject" and "activity" to the list of feature names, and imposed the list of features onto the dataframe columns.

I then labeled the activities through another series of simple string substitutions.

I filtered out the unwanted columns, leaving only those containing "mean()", "std()", "subject", or "activity."

### dataFilteredAveraged

Starting with the preceding dataframe, I grouped it by subject and activity and then summarized each of the remaining variables.

I appropriately named the variables of the new dataframe by appending "averaged" at the beginning of each.

I then saved both dataframes as .txt files.