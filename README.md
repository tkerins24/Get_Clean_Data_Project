# Get_Clean_Data_Project
Week 4 Project

The purpose of this project is to take the raw data from the Human Activity Recognition Smartphones Dataset Version 1.0 and transform it into a Tidy Dataset for further analysis.

Brief Background: The experiments were carried out on a group of 30 volunteers with each one performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using the phones embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were recorded during each activity. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The data can be downloaded from this URL: http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The following procedures were used to transform the data into a tidy dataset. (refer to the file “run_analysis.R” for the actual script used).

1)	Merge the training and the test sets to create one data set

	a)	Downloaded the master zipped file and unzipped it
    b)	Read the following input files using the read.table function:
      i)	X_test.txt and X_train.txt: the test data and training datasets
      ii)	y_test.txt and y_train.txt: the test and train class labels and their activity names
      iii)	subject_test.txt and subject_train.txt: each row identifies the subject who performed the activity.
      iv)	activity_labels.txt: contains descriptions of the 6 activities performed
      v)	features.txt: contains the name of each feature in the test and training datasets.
	  
	c)	Renamed the column names of X_test and y_test to the names in the features.txt file
	d)	Bound the “subject_test” and “y_test” columns to X_test using cbind and renamed the columns to “subject” and “test”.
	e)	Bound the “subject_train” and “y_train” columns to X_train using cbind and renamed the columns to “subject” and “test”.
	f)	Bound the resulting X_test and X_train datasets together using rbind and stored the results in “complete_dataset”.

2)	Extract only the measurements on the mean and standard deviation for each measurement.

	a)	Modified “complete_dataset” by extracting any features containing mean, Mean, or std using the grep function.
	
3)	Use descriptive activity names to name the activities in the data set

	a)	Modified “complete_dataset” by merging the activity_labels dataset with it.
	
4)	Appropriately labeled the data set with descriptive variable names.

	a)	Expanded the feature abbreviations in the original dataset using the gsub function.
	
		i)	Example: “Acc” expanded to “Acceleraton”
		
5)	From the data set in step 4, created a second, independent tidy data set with the average of each variable for each activity and each subject.

	a)	Melted “complete_dataset” to “long_dataset” by “subject” and “activity” to isolate the features values
	b)	 into a single column to prepare to take the average of each feature variable.
	c)	Cast the melted dataset to the “tidy_dataset” by subject and activity and used the mean function to obtain the average value for each feature.

The final “tidy_dataset” consists of a subject column that identifies the number of the subject, an activity column which describes the activity performed (WALKING, SITTING, etc.) followed by columns for each of the features. Each row contains the average values for each feature by subject and activity.

