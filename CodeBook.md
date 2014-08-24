## CodeBook for the tidy dataset

The script `run_analysis.R` performs extraction of tidy data from dataset available by this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).


### Executing the script

Before running `run_analysis.R` please ensure you have `reshape2` package installed. Then unpack data archive into working directory, the script assumes that all necessary data files available at `./UCI HAR Dataset`.

The script performs following actions:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


### Variables in the script

To satisfy strange requirements of project I have to describe all variables used in the script:
* `activity_labels` stores array of all six possible activities WALKING, ..., LAYING.
* `features` is array of names of all available features in corresponding .txt file.
* `subset_features` is a subset of `features` containing only `Mean` or `Std` measurements.
* `readData` is a function. It reads data from subject,X,y files, filters them and returns as a single data frame.
* `test_data` - test data frame read by `readData`.
* `train_data` - train data frame read by `readData`.
* `data` - combined test and train data.
* `melt_data` is melted `data`.
* `tidy_data` is `melt_data` aggregated across activityID and subjectID.
