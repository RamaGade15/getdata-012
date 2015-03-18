# getdata-012: Getting and Cleaning Data - Course Project

## Program Name: run_analysis.R 

Function: Processes two datasets, Train & Test datasets and creates a tidy dataset.

## Inputs: Both data sets are identical in structure

### a) Train Dataset. File names in this dataset are
	Varibles(features) in each observation are - 561
	Each observation represents a set of measurements (variables) 
         for an activity class (total 6) and subject (total 30)
### b) Test Dataset. File names in this dataset are
	Varibles(features) in each observation are - 561
	Each observation represents a set of measurements (variables) 
         for an activity class (total 6) and subject (total 30)
## Output:
 Tidy Data Set has 180 rows each corresponding one activity class and subject (6 x 30 = 180)
 Out of the 561 variables from the original dataset, only 66 variables representing and mean 
 and standard deviation are selected in the Tidy Data Set

## Process:
 
### Initialization: 

   Read activity labels from "./activity_labels.txt" into  data frame 'ActCodes'
   Read features (variable names) from "./features.txt" into  data frame 'features'
	
   **Train dataset:** 
       	Read observations from "./train/x_train.txt" into data frame xTrain. 	
       	Read Subject for each observation from "./train/subject_train.txt" into data frame subjectTrain.
	Read Activity Class for each observation from "./train/y_train.txt" into data frame yTrain.
   **Test dataset:** 
       	Read observations from "./test/x_test.txt" into data frame xTest. 	
       	Read Subject for each observation from "./test/subject_test.txt" into data frame subjectTest.
	Read Activity Class for each observation from "./test/y_test.txt" into data frame yTest.

###1. Merge the training and the test sets to create one data set and set variable names. 
   Append activity, subject colums to each observation and merge the datasets.

###2. Extract only the measurements on the mean and standard deviation for each measurement. 
   Columns are identified by searching for strings mean() and std() in column names.

###3. Use descriptive activity names to name the activities in the data set.

###4. Appropriately label the data set with descriptive variable names. 

###5. Create a second, independent **tidy data set** and save it as a file "./x_tidy_summary.txt"
   with the average of each variable for each activity and each subject.
   used dplyr function summarise_each to summarize each column by Activity and Subject.
