#read in labels for activities and variables
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#select only variables related to mean and std
ms_feat <- grepl("mean|std", features[,2])

#read in test data (y = activites, X = measurements)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")

#give variable names to X_test, then restric to the mean/std vars
names(X_test) <- features[,2]
X_test <- X_test[ , ms_feat] 

#add column y_test with names for activitiy names
y_test[,2] <- activities[,2][y_test[,1]]
names(y_test) <- c("activity_id", "activity")

#give subject_test variable name 
names(subject_test) <- c("subject")

#combine all test data
test_data <- cbind(subject_test, y_test, X_test)

##repeat steps above for train data
#read in train data (y = activites, X = measurements)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")

#give variable names to X_train, then restric to the mean/std vars
names(X_train) <- features[,2]
X_train <- X_train[ , ms_feat] 

#add column y_test with names for activitiy names
y_train[,2] <- activities[,2][y_train[,1]]
names(y_train) <- c("activity_id", "activity")

#give subject_test variable name 
names(subject_train) <- c("subject")

#combine all test data
train_data <- cbind(subject_train, y_train, X_train)


## combine test and train data
data <- rbind(test_data, train_data)


## create new data set with  average of each variable for each activity and each 
## subject
library(reshape2)
#melt the data by feature variables (keep subject and activity)
melted <- melt(data, names(data)[1:3], names(data)[4:79])

#new data table with mean of each variable for each combo of subject/activity
means <- dcast(melted, subject + activity ~ variable, mean)

#new dataset called tidy_data
tidy_data <- means
write.table(tidy_data, "tidy_data.txt")
