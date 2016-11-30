#Load Libraries
library(reshape2)

#Download dataset, unzip, and read into R

zipped_file <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zipped_file)
unzip(zipped_file, list = TRUE)
y_test <- read.table(unzip(zipped_file, "UCI HAR Dataset/test/y_test.txt"))
y_train <- read.table(unzip(zipped_file, "UCI HAR Dataset/train/y_train.txt"))
X_test <- read.table(unzip(zipped_file, "UCI HAR Dataset/test/X_test.txt"))
X_train <- read.table(unzip(zipped_file, "UCI HAR Dataset/train/X_train.txt"))
subject_test <- read.table(unzip(zipped_file, "UCI HAR Dataset/test/subject_test.txt"))
subject_train <- read.table(unzip(zipped_file, "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unzip(zipped_file, "UCI HAR Dataset/features.txt"))
activity_labels <- read.table(unzip(zipped_file, "UCI HAR Dataset/activity_labels.txt"))
unlink(zipped_file)

#Rename column names to those of features dataset: 
colnames(X_test) <- t(features[2])
colnames(X_train) <- t(features[2])

#Bind subject_test and y_test columns to X_test and rename columns
X_test <- cbind(y_test,X_test)
colnames(X_test)[1] <- "activity"
X_test <- cbind(subject_test, X_test)
colnames(X_test)[1] <- "subject"

#Bind subject_train and y_train columns to X_train and rename columns
X_train <- cbind(y_train,X_train)
colnames(X_train)[1] <- "activity"
X_train <- cbind(subject_train, X_train)
colnames(X_train)[1] <- "subject"

# 1) Bind training and test datasets
complete_dataset <- rbind(X_train,X_test)

# 2) Extract mean and standard deviation features
extracted_columns <- grep("subject|activity|mean|Mean|std", names(complete_dataset), value = TRUE) 
complete_dataset <- complete_dataset[,extracted_columns]

# 3) Replace activity numbers with descriptive activity names
#Merge activity_labels with complete_dataset
complete_dataset<- merge(activity_labels,complete_dataset,by.x = "V1", by.y = "activity")

#Eliminate resulting redundant "V1" column (column 1 in merged dataset)
complete_dataset <- complete_dataset[,-1]

# Rename activity description column from "V2" to "activity"
colnames(complete_dataset)[1] <- "activity"

#swap column 1 and column 2 so column 1 is "subject" and column 2 is "activity
complete_dataset <- complete_dataset[,c(2,1,3:ncol(complete_dataset))]

# 4) Label dataset with descriptive variable names
names(complete_dataset) <- gsub("^t", "time", names(complete_dataset))
names(complete_dataset) <- gsub("^f", "Freqency", names(complete_dataset))
names(complete_dataset) <- gsub("Acc", "Acceleration", names(complete_dataset))
names(complete_dataset) <- gsub("Gyro", "Gyroscope", names(complete_dataset))
names(complete_dataset) <- gsub("\\()", "", names(complete_dataset))
names(complete_dataset) <- gsub("std", "standard_deviation", names(complete_dataset))
names(complete_dataset) <- gsub("X", "X_axis", names(complete_dataset))
names(complete_dataset) <- gsub("Y", "Y_axis", names(complete_dataset))
names(complete_dataset) <- gsub("Z", "Z_axis", names(complete_dataset))

# 5) Create tidy data set
#melt complete_dataset to isolate variable values
long_dataset <-  melt(complete_dataset, id = c("subject", "activity"))

#Cast melted dataset to wide and obtain means of variables
tidy_dataset <- dcast(long_dataset, subject + activity ~ variable, mean)

#Write dataset to table
write.table(tidy_dataset, "tidy_dataset.txt", row.names = FALSE, quote = FALSE)


