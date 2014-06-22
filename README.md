Getting and Cleaning Data - R Course Project
=======================

This repo contains a single R script that processes data as required by  the [Coursera course "Getting and Cleaning Data"][1] project/assigment of week 3.
Instructions given in the [assignment instructions][2]. (You need to be logged in with Coursera to read that).  

Main Features
-------------
In RStudio, or on the command line: Run the script `run_analysis.R` to process selected data-files in the subdirectory 
`UCI HAR Dataset` 



### Assumptions

This script assumes that there exists a readable directory `UCI HAR Dataset` in the directory where the run_analysis.R file resides. The data provided by the instructor need to be extracted into this subdirectory (which got created by extracting the zipfile with the input data). The R script should reside in the **parent directory** of `UCI HAR Dataset` to work properly.

 I have added some code to check for the existance of the directory but this is somewhat untested (e.g., on Windows),



[1]: https://www.coursera.org/course/getdata
[2]: https://class.coursera.org/getdata-004/human_grading
