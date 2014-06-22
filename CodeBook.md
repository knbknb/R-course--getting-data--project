Codebook.md
========================================================

R Markdown document serving as a codebook for the programming project of the Coursera Course "Getting and Cleaning Data".

The script 
-    Merges the training and the test sets to create one data set.
-    Extracts only the measurements on the mean and standard deviation for each measurement. 
-    Uses descriptive activity names to name the activities in the data set
-    Appropriately labels the data set with descriptive variable names. 
-    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

R Script structure is explained in README.md.

This codebook lists the data types in the output file, `tidy-sensordata--mean-stddev--by-activity-and-person.txt`.

This file is an R data frame wriiten to disk as a tab-separated text file.

There are two string variables, Activity and PersonID in the first column. They are "ID columns". In the other columns (index >= 3), there are only numeric values. Standard Units of measure of these data types should be  m/s² (meters per seconds squared). But actually it is unknown what the units are (it could be intensities or uncorrected acceleration values).

There are these columns with their R datatypes:
------------------------------------------------
<pre>
Col. 1 -  Activity    -- character

Col. 2 -  PersonID    -- character

Col. 3 -  tBodyAcc-mean-X -- numeric

Col. 4 -  tBodyAcc-mean-Y

Col. 5 -  tBodyAcc-mean-Z

Col. 6 -  tBodyAcc-std-X

Col. 7 -  tBodyAcc-std-Y

Col. 8 -  tBodyAcc-std-Z

Col. 9 -  tGravityAcc-mean-X

Col. 10 -  tGravityAcc-mean-Y

Col. 11 -  tGravityAcc-mean-Z

Col. 12 -  tGravityAcc-std-X

Col. 13 -  tGravityAcc-std-Y

Col. 14 -  tGravityAcc-std-Z

Col. 15 -  tBodyAccJerk-mean-X

Col. 16 -  tBodyAccJerk-mean-Y

Col. 17 -  tBodyAccJerk-mean-Z

Col. 18 -  tBodyAccJerk-std-X

Col. 19 -  tBodyAccJerk-std-Y

Col. 20 -  tBodyAccJerk-std-Z

Col. 21 -  tBodyGyro-mean-X

Col. 22 -  tBodyGyro-mean-Y

Col. 23 -  tBodyGyro-mean-Z

Col. 24 -  tBodyGyro-std-X

Col. 25 -  tBodyGyro-std-Y

Col. 26 -  tBodyGyro-std-Z

Col. 27 -  tBodyGyroJerk-mean-X

Col. 28 -  tBodyGyroJerk-mean-Y

Col. 29 -  tBodyGyroJerk-mean-Z

Col. 30 -  tBodyGyroJerk-std-X

Col. 31 -  tBodyGyroJerk-std-Y

Col. 32 -  tBodyGyroJerk-std-Z

Col. 33 -  tBodyAccMag-mean

Col. 34 -  tBodyAccMag-std

Col. 35 -  tGravityAccMag-mean

Col. 36 -  tGravityAccMag-std

Col. 37 -  tBodyAccJerkMag-mean

Col. 38 -  tBodyAccJerkMag-std

Col. 39 -  tBodyGyroMag-mean

Col. 40 -  tBodyGyroMag-std

Col. 41 -  tBodyGyroJerkMag-mean

Col. 42 -  tBodyGyroJerkMag-std

Col. 43 -  fBodyAcc-mean-X

Col. 44 -  fBodyAcc-mean-Y

Col. 45 -  fBodyAcc-mean-Z

Col. 46 -  fBodyAcc-std-X

Col. 47 -  fBodyAcc-std-Y

Col. 48 -  fBodyAcc-std-Z

Col. 49 -  fBodyAccJerk-mean-X

Col. 50 -  fBodyAccJerk-mean-Y

Col. 51 -  fBodyAccJerk-mean-Z

Col. 52 -  fBodyAccJerk-std-X

Col. 53 -  fBodyAccJerk-std-Y

Col. 54 -  fBodyAccJerk-std-Z

Col. 55 -  fBodyGyro-mean-X

Col. 56 -  fBodyGyro-mean-Y

Col. 57 -  fBodyGyro-mean-Z

Col. 58 -  fBodyGyro-std-X

Col. 59 -  fBodyGyro-std-Y

Col. 60 -  fBodyGyro-std-Z

Col. 61 -  fBodyAccMag-mean

Col. 62 -  fBodyAccMag-std

Col. 63 -  fBodyBodyAccJerkMag-mean

Col. 64 -  fBodyBodyAccJerkMag-std

Col. 65 -  fBodyBodyGyroMag-mean

Col. 66 -  fBodyBodyGyroMag-std

Col. 67 -  fBodyBodyGyroJerkMag-mean

Col. 68 -  fBodyBodyGyroJerkMag-std
</pre>
