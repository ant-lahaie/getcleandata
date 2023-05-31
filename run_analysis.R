#setting working directory
# getwd()
# setwd("UCI HAR Dataset")
# getwd()

# initial data read
test <- read.table("test/X_test.txt")
test <- cbind(activity = read.table("test/y_test.txt"), test)
test <- cbind(subject = read.table("test/subject_test.txt"), test)

train <- read.table("train/X_train.txt")
train <- cbind(activity = read.table("train/y_train.txt"), train)
train <- cbind(subject = read.table("train/subject_train.txt"), train)

features <- read.table("features.txt")

# merge observations
dat <- rbind(test, train)

# clean up column names
features$V2 <- sub("^t","time", features$V2)
features$V2 <- sub("^f","frequency", features$V2)
features$V2 <- sub("Acc","Acceleration", features$V2)
features$V2 <- sub("Mag","Magnitude", features$V2)

#add first column name "subject", second  "activity"
features <- rbind(c("0","activity"), features)
features <- rbind(c("0","subject"), features)

# assign column names to dataset
colnames(dat) <- features[,2]

#label activities
dat$activity <- sub(1, "walking", dat$activity)
dat$activity <- sub(2, "walkingUpstairs", dat$activity)
dat$activity <- sub(3, "walkingDownstairs", dat$activity)
dat$activity <- sub(4, "sitting", dat$activity)
dat$activity <- sub(5, "standing", dat$activity)
dat$activity <- sub(6, "laying", dat$activity)


#filter out unwanted columns: leave only mean() ; std() ; subject, activity
dataFiltered <- select(dat, contains("subject") | contains("activity") | contains("mean()") | contains("std()"))

# create a second data set with the average of each variable for each activity and each subject
dataFilteredAveraged <- dataFiltered %>%
        group_by(subject, activity) %>%
        summarize_all(mean)

#appropriately label summarized columns
DFA_colnames <- colnames(dataFilteredAveraged)
DFA_colnames <- sub("^time","averageTime",DFA_colnames)
DFA_colnames <- sub("^frequency","averageFrequency",DFA_colnames)
colnames(dataFilteredAveraged) <- DFA_colnames

#save dataframes as csv files
write.table(dataFiltered, "dataFiltered.txt",row.names=FALSE)
write.table(dataFilteredAveraged, "dataFilteredAveraged.txt",row.names=FALSE)
