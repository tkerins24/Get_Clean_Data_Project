CodeBook

The codebook information for the raw dataset can be found by downloading from this URL:
http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Unzip the files and you can find information on each of the variables in the following text files:

“features_info.txt”: Describes in detail the signals that were captured from the accelerometer and gyroscope and how they were captured and the set of variables that were estimated from them.

“cleanfeatures.txt” contains a complete list of the 561 variables derived from the raw measurements that summarize the various statistics such as mean, standard deviation, kurtosis, etc.

“README.txt” file from this site summarizes what is contained in each record and the included data files.

“activity_labels.txt” describes the labels applied to each activity (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

The new variables, and names that were derived during the transformation of the data into a tidy dataset are as follows.

“complete_dataset”: This is the dataset that combines the training and test datasets together after binding the subject and activity columns to them, adding descriptive activity names, extracting only the median and standard features and renaming the feature columns with more descriptive names. It serves as the input to creating the tidy dataset. It is structured as follows:

Columns:

“Subject”: integer. the subject number (from 1 to 30) of the person performing the activities

“Activity”: factor containing the descriptive activity names: ((WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

“feature” numeric. columns containing only the standard deviation and mean features. These names were derived using the grep function to extract those variables with the following substrings: mean, Mean, std. Also these feature columns were re-named to make them more descriptive:

gsub("^t", "time", names(complete_dataset))
  
gsub("^f", "Freqency", names(complete_dataset))

gsub("Acc", "Acceleration", names(complete_dataset))

sub("Gyro", "Gyroscope", names(complete_dataset))

gsub("\\()", "", names(complete_dataset))

gsub("std", "standard_deviation", names(complete_dataset))

gsub("X", "X_axis", names(complete_dataset))

gsub("Y", "Y_axis", names(complete_dataset))

gsub("Z", "Z_axis", names(complete_dataset))


Each row in the “complete_dataset” represents a single median or standard deviation measurement.

“tidy_dataset” This is final dataset that is derived from “complete_dataset” It was derived by first melting it into a long dataset by subject and activity to get all the feature values into a single column. Then it was cast into a wide dataset to using the mean to get the average value for each of the median and mean features. It is structured as follows:

Columns:

“Subject”: integer, the subject number (from 1 to 30) of the person performing the activities

“Activity”: Factor containing the descriptive activity names: ((WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

“feature” columns. numeric. containing only the standard deviation and mean features. These are the same columns from “complete_dataset”

Rows: Each row contains the average value by subject, by activity for each of the “feature” variables.
