#
# set working directory
#
setwd("./UCI HAR Dataset")
install.packages("dplyr"); library(dplyr)
#
#================================================================
# data description
#================================================================
# Train Dataset: Observations - 7352
# Test  Dataset: Observations - 2947
#
# Varibles(features) in each observation - 561
# Activity classes observed - 6
# 
# subjectTrain/subjectTest - subject number (1:30) for each observation 
# yTest/yTrain - Activity class (1:6) for each observation
#
#
#================================================================
# ActCodes: Links the class labels with their activity name.
#
fileName <- "./activity_labels.txt"
ActCodes <- read.table(fileName)
colnames(ActCodes) <- c("Activity", "ActivityName")
#
# features (Variables)
#
fileName <- "./features.txt"
features <- read.table(fileName)
colnames(features) <- c("FeatureCode", "FeatureName")
#
#------------------------------------------------------------------------
# Read Train Dataset
#
# Observations
fileName <- "./train/x_train.txt"
xTrain <- read.table(fileName)
#nrow(xTrain)
#
# Subject for each observation
fileName <- "./train/subject_train.txt"
subjectTrain <- read.table(fileName)
colnames(subjectTrain) <- "Subject"
#
# Activity Class for each observation
fileName <- "./train/y_train.txt"
yTrain <- read.table(fileName)
colnames(yTrain) <- "Activity"
#
#------------------------------------------------------------------------
# Read Test Dataset
#
# Observations
fileName <- "./test/x_test.txt"
xTest <- read.table(fileName)
#nrow(xTest)
#
# Subject for each observation
fileName <- "./test/subject_test.txt"
subjectTest <- read.table(fileName)
colnames(subjectTest) <- "Subject"
#
# Activity Class for each observation
fileName <- "./test/y_test.txt"
yTest <- read.table(fileName)
colnames(yTest) <- "Activity"
#
#-------------------------------------------------------------------------
# 1. Merge the training and the test sets to create one data set.
#    and set variable names
#
# append activity, subject colums to each observation and merge the datasets
#
xCombined <- rbind(cbind(yTrain, subjectTrain, xTrain), 
                cbind(yTest, subjectTest, xTest))

colnames(xCombined) <- c("Activity", "Subject", 
                         as.character(features$FeatureName))
#
# 2. Extract only the measurements on the mean and standard deviation 
#    for each measurement. 
#
# Identify column names with "mean" and "std" as part of description
#
cols <- grep ("mean\\(\\)", (colnames(xCombined)))
cols <- c(1,2, cols, grep("std\\(\\)", (colnames(xCombined))))
cols <- sort(cols)
#
# Extract mean and std colums along with Activity & subject
#
x_mean_std <- xCombined[,cols]
#
# 3. Use descriptive activity names to name the activities in the data set
#    
# Append activity name column looking up Activity in ActCodes data frame

#
x_mean_std <- merge(x_mean_std, ActCodes)
x_mean_std <- x_mean_std[,c(69, 2:68)]
#
# 4. Appropriately label the data set with descriptive variable names. 
#
# Variable names are already set in step #1
#
# 5. Create a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#    x_tidy_summary is the data frame
#
# Sort by ActivityName and Subject
x_mean_std <- arrange(x_mean_std, ActivityName, Subject)
#
x_tidy_summary <- 
  x_mean_std %>% group_by(ActivityName, Subject) %>% summarise_each(funs(mean))
#
# Create a file with contents of tidy_summary
#
fileName <- "./x_tidy_summary.txt"
write.table(x_tidy_summary, fileName, row.name=FALSE)
#--------------------------------------------------------------
