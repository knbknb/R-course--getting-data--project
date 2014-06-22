Codebook.md
========================================================

R Markdown document serving as a codebook for the programming project of the Coursera Course "Getting and Cleaning Data".

The script  `run_analysis.R`
-    Merges the training and the test sets to create one data set.
-    Extracts only the measurements on the mean and standard deviation for each measurement. 
-    Uses descriptive activity names to name the activities in the data set
-    Appropriately labels the data set with descriptive variable names. 
-    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Input file contents and R Script structure are explained in README.md and in the comments of the source code itself.

This codebook lists the data types in the output file, `tidy-sensordata--mean-stddev--by-activity-and-person.txt`.

This file is an R data frame wriiten to disk as a tab-separated text file.

Data File structure
------------------------------------------------
There are two string variables, Activity and PersonID in the first column. They are "ID columns". In the other columns (index >= 3), there are only numeric values. 
All numeric columns are sensor data which can be grouped by prefix, middle part, suffix.

Naming Convention of numeric columns
------------------------------------------------
*Prefix values:* 

    t - measurements in the time domain 
      
      
    f - Measurements in the frequency domain

*Middle Part values:*

    Sensor type and measurement

*Suffix values:*

     mean: Arithmetic Mean value
    
     std: Standard deviation
 
Standard Units of measure of these data types should be  m/s² (meters per seconds squared). But actually it is unknown what the units are (it could be intensities or uncorrected acceleration values).

Column definitions
------------------------------------------------
There are these columns with their R datatypes:
<pre>
Col. 1 -  Activity    -- character

Col. 2 -  PersonID    -- character

Col. 3 -  tBodyAcc-mean-X -- numeric

Col. 4 -  tBodyAcc-mean-Y -- numeric 

Col. 5 -  tBodyAcc-mean-Z -- numeric

Col. 6 -  tBodyAcc-std-X -- numeric

Col. 7 -  tBodyAcc-std-Y -- numeric

Col. 8 -  tBodyAcc-std-Z -- numeric

Col. 9 -  tGravityAcc-mean-X -- numeric

Col. 10 -  tGravityAcc-mean-Y -- numeric

Col. 11 -  tGravityAcc-mean-Z -- numeric

Col. 12 -  tGravityAcc-std-X -- numeric

Col. 13 -  tGravityAcc-std-Y -- numeric

Col. 14 -  tGravityAcc-std-Z -- numeric

Col. 15 -  tBodyAccJerk-mean-X -- numeric

Col. 16 -  tBodyAccJerk-mean-Y -- numeric

Col. 17 -  tBodyAccJerk-mean-Z -- numeric

Col. 18 -  tBodyAccJerk-std-X -- numeric

Col. 19 -  tBodyAccJerk-std-Y -- numeric

Col. 20 -  tBodyAccJerk-std-Z -- numeric

Col. 21 -  tBodyGyro-mean-X -- numeric

Col. 22 -  tBodyGyro-mean-Y -- numeric

Col. 23 -  tBodyGyro-mean-Z -- numeric

Col. 24 -  tBodyGyro-std-X -- numeric

Col. 25 -  tBodyGyro-std-Y -- numeric

Col. 26 -  tBodyGyro-std-Z -- numeric

Col. 27 -  tBodyGyroJerk-mean-X -- numeric

Col. 28 -  tBodyGyroJerk-mean-Y -- numeric

Col. 29 -  tBodyGyroJerk-mean-Z -- numeric

Col. 30 -  tBodyGyroJerk-std-X -- numeric

Col. 31 -  tBodyGyroJerk-std-Y -- numeric

Col. 32 -  tBodyGyroJerk-std-Z -- numeric

Col. 33 -  tBodyAccMag-mean -- numeric

Col. 34 -  tBodyAccMag-std -- numeric

Col. 35 -  tGravityAccMag-mean -- numeric

Col. 36 -  tGravityAccMag-std -- numeric

Col. 37 -  tBodyAccJerkMag-mean -- numeric

Col. 38 -  tBodyAccJerkMag-std -- numeric

Col. 39 -  tBodyGyroMag-mean -- numeric

Col. 40 -  tBodyGyroMag-std -- numeric

Col. 41 -  tBodyGyroJerkMag-mean -- numeric

Col. 42 -  tBodyGyroJerkMag-std -- numeric

Col. 43 -  fBodyAcc-mean-X -- numeric

Col. 44 -  fBodyAcc-mean-Y -- numeric

Col. 45 -  fBodyAcc-mean-Z -- numeric

Col. 46 -  fBodyAcc-std-X -- numeric

Col. 47 -  fBodyAcc-std-Y -- numeric

Col. 48 -  fBodyAcc-std-Z -- numeric

Col. 49 -  fBodyAccJerk-mean-X -- numeric

Col. 50 -  fBodyAccJerk-mean-Y -- numeric

Col. 51 -  fBodyAccJerk-mean-Z -- numeric

Col. 52 -  fBodyAccJerk-std-X -- numeric

Col. 53 -  fBodyAccJerk-std-Y -- numeric

Col. 54 -  fBodyAccJerk-std-Z -- numeric

Col. 55 -  fBodyGyro-mean-X -- numeric

Col. 56 -  fBodyGyro-mean-Y -- numeric

Col. 57 -  fBodyGyro-mean-Z -- numeric

Col. 58 -  fBodyGyro-std-X -- numeric

Col. 59 -  fBodyGyro-std-Y -- numeric

Col. 60 -  fBodyGyro-std-Z -- numeric

Col. 61 -  fBodyAccMag-mean -- numeric

Col. 62 -  fBodyAccMag-std -- numeric

Col. 63 -  fBodyBodyAccJerkMag-mean -- numeric

Col. 64 -  fBodyBodyAccJerkMag-std -- numeric

Col. 65 -  fBodyBodyGyroMag-mean -- numeric

Col. 66 -  fBodyBodyGyroMag-std -- numeric

Col. 67 -  fBodyBodyGyroJerkMag-mean -- numeric

Col. 68 -  fBodyBodyGyroJerkMag-std -- numeric
</pre>
