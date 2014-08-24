library(reshape2)

## Load activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

## Load data column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
features = gsub('-mean', 'Mean', features)
features = gsub('-std', 'Std', features)
features = gsub('[-(),]', '', features)

## Subset of means and stdevs
subset_features <- grepl("Mean|Std", features)

## Load dataset function
readData <- function(fileSubject, fileX, fileY) {
	subject <- read.table(fileSubject)
	X <- read.table(fileX)
	y <- read.table(fileY)

	names(subject) <- c("subjectID")
	names(X) <- features
	names(y) <- c("activityID")

	X <- X[,subset_features]

	cbind(X, y, subject)
}

## Load test data
test_data <- readData(
	"./UCI HAR Dataset/test/subject_test.txt",
	"./UCI HAR Dataset/test/X_test.txt",
	"./UCI HAR Dataset/test/y_test.txt"
	)

## Load train data
train_data <- readData(
	"./UCI HAR Dataset/train/subject_train.txt",
	"./UCI HAR Dataset/train/X_train.txt",
	"./UCI HAR Dataset/train/y_train.txt"
	)

## Combine test and train data
data <- rbind(test_data, train_data)

## Melt data before aggregation
melt_data <- melt(
	data,
	id.vars = c("activityID", "subjectID"),
	measure.vars = features[subset_features]
	)

## Aggreagate and find means
tidy_data <- dcast(
	melt_data,
	activityID + subjectID ~ variable,
	mean)


## Substitute activity ID with corresponding Label
tidy_data$activityID <- activity_labels[tidy_data$activityID]
names(tidy_data)[1] <- "activityLabel"

## Save the result
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)
