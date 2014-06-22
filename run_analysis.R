# run_analysis.R


#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


# F U N C T I O N S
###################################################################
## a simple helper function reporting on presence of NA Values in numeric data frame
# input: colsums of data frame, rowcount, colcount
msg_parse_result <- function(colsums, r, c){
        #rndv <- as.integer(abs(rnorm(n=10)) * 10)
        #colsums[rndv]<- rndv
        #colsums
        good.flag <- all(colsums == 0)
        msg <- sprintf("There are  %s NA values in your dataset of length n = %s rows x %s columns",  sum(colsums[colsums != 0]),r, c)
        if(! good.flag){
                warning(paste0("Bad! ", msg))
        } else{
                message(paste0("Good! No NAs found. ", msg))
        }
}

###################################################################
## a simple helper function for testing and setting the working directory
# input: a dirname string
check_directory <- function(dirname){
        rcflag = FALSE
        if (file.exists(dirname)){
                message(sprintf("Good: Subdir '%s'' found. Assuming it contains *.txt data files with the Samsung dataset.", dirname))
        } else {
                ## Set home directory
                d = "/home/knut/Documents/coursera/datascience/getting_data/R-course--getting-data--project"
                if(! file.exists(d)){
                        warning(sprintf("Directory '%s' not found. Enter full path to its parent directory on your computer.", d ), immediate.=TRUE)
                        n <- FALSE;
                        while(! n){
                                cat("Path (Ctrl-C to exit):")
                                d <- readLines(con="stdin", n=1)
                                n <- ifelse(! file.exists(d),FALSE, TRUE)
                                #if(n == "0"){break}  # breaks when hit enter
                                
                        }
                        setwd(d)
                        warning(paste0("Now inside working directory", getwd()), immediate.=TRUE)
                } else {
                        setwd(d)
                }
                rcflag = TRUE
        }
        
        
        if(! file.exists(dirname)){      
                stop(paste0("Subdir '", dirname, "' not found. Must already exist and contain *.txt data files. Create the directory and put unzipped files there."))
                
                #message("You can run helper script download-and-extract.R to download and unzip necessary data files")
                #source("download-and-extract.R")
                #message(paste0("Subdir ", dirname, " not found,. Must already exist and contain data files."))
                #message("You can run helper script download-and-extract.R to download and unzip necessary data files")
                #source("download-and-extract.R")
        }
        rcflag
        
}
###################################################################
# these functions do a lot of heavy lifting (memory-intensive file I/O)
#
# Input: a data frame of file names (full paths)
# output: a single data frame containing contents of files, all were read in all and appended  
# WORKS!  returns df with 561 columns/variables
read_data <- function(df, colclasses=NA, nRow=NA){
        do.call("rbind",lapply(df ,
                               FUN=function(files){
                                       read.table(files, colClasses = colclasses)}))
}
# DOES NOT WORK with Samsung Dataset! - fixed width format returns only 128 columns
read_data_fwf <- function(df, colclasses=NA, nRow=NA){
        do.call("rbind",lapply(df ,
                               FUN=function(files){
                                       read.fwf(files, widths=rep(16, 128), nrow=nRow, strip.white=TRUE,comment.char = "",
                                                stringsAsFactors=FALSE,
                                                header=FALSE)}))
}
###################################################################
# Input: a dataframe/vector of file names
# output:  a data frame  with 2 columns called FeatureId and FeatureName, 
# and only -mean() and std() columns and their indexes
filter_featurenames <- function(df){
        featuresfile.list <- df[grep( "features.txt", df)]
        
        features <- do.call("rbind",lapply(featuresfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("FeatureID", "FeatureName"))}))
        features[grep( "mean\\(\\)|std\\(\\)", features$FeatureName, perl=TRUE),]
        
}

###################################################################
###################################################################
# Main part of script
###################################################################
###################################################################
# make sure there is no rounding in display
options(digits=15)

## We assume file has been downloaded and extracted already
subdir <- "UCI HAR Dataset"
dataset_found <- check_directory(subdir)
###read in all filenames (as full paths) extracted from the zip-file, will filter this list of strings many times, later on.
file.list <- list.files(subdir, full.names=TRUE, recursive=TRUE, pattern="*.txt")



############################################################################################################################
# get the feature list of mean and stddev measurements (66 of 561 columns)
###########################################################################################################################

fms <- filter_featurenames(file.list)
#returns
# 
# FeatureID                     FeatureName
# 1           1               tBodyAcc-mean-X
# 2           2               tBodyAcc-mean-Y
# ...
# with gaps  
# 543 
# 1   2   3   4   5   6  41  42  43  44  45  46  81  82  83  84  85  86 121 122 123 124 125 126 161 162 163 164 165 166 201 202 214 215 227 228 240



############################################################################################################################
#Merge the training and the test sets to create one data set.
############################################################################################################################

datafile.list <- file.list[grep( "X_", file.list)]

# find column types  , sample 1 file
n <- 1
datafiles.sampled <- head(datafile.list,n)
#data.sampled <- read_data_fwf(datafiles.sampled)
#to get datatypes of columns, sample 2 rows from 1 file first
nr <- 2
data.sampled <- read_data(datafiles.sampled, nRow=2)
classes <- sapply(data.sampled, class)

n <- length(datafile.list)
datafile.use <- head(datafile.list,n)
datafile.use 
#data <- read_data_fwf(datafile.use)
data <- read_data(datafile.use, classes)

# check that there are no NAs in the dataset
msg_parse_result(colSums(is.na(data)), nrow(data),  length(names(data))) 
message(sprintf("Data as read from input files (contains many more rows and  columns, ncol= %i)", ncol(data)))
head(data[,1:5])
############################################################################################################################
#Extract only the measurements on the mean and standard deviation for each measurement. 
############################################################################################################################
data <- data[,fms$FeatureID]

############################################################################################################################
#Appropriately label the data set with descriptive variable names. 
############################################################################################################################
#names(data) <- fms$FeatureName
# add better labels, in-place remove´al of braces.  mean() => mean
names(data) <- lapply(fms$FeatureName, FUN=function(x){x <- gsub("\\(\\)", "", x); x})

message("Extracted and labeled only the measurements on the mean and standard deviation for each measurement. Values from input files:")
head(data)

#############################################################################################################################
#Use descriptive activity names to name the activities in the data set
############################################################################################################################
activitieslabelsfile.list <- file.list[grep( "activity", file.list)]
activities_labels <- lapply(activitieslabelsfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("Act.code", "Act.label"))})
activities_labels

activitiesfile.list <- file.list[grep( "/y_", file.list)]
activities <- do.call("rbind",lapply(activitiesfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("Act.code"))}))
head(activities, 5)
range(activities)
mergedActivities <- merge(activities, activities_labels, by.x ="Act.code", by.y="Act.code", all=TRUE, sort=FALSE)

# for consistency reasons, also make a two-column data frame from vector of person-ids 
subjectlabelfile.list <- file.list[grep( "subject_", file.list)]
subjects <- do.call("rbind",lapply(subjectlabelfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("SubjID"))}))
subjects$SubjLabel <- sprintf("Person_%02i",subjects$SubjID) 

unique(subjects[order(subjects$SubjLabel),])



############################################################################################################################
#Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
############################################################################################################################
#add subject data to the left of the 561-features -data frame
unaggData <- cbind(activities, subjects, mergedActivities, data)

head(unaggData[,1:8])        
## average the data sets

aggData <- aggregate(data, by=list(unaggData$Act.label, unaggData$SubjLabel), FUN = mean)
names(aggData)[1] <- c("Activity")
names(aggData)[2] <- c("PersonID")

options(digits=2)
aggData[order(aggData$Activity, aggData$PersonID),1:8]
outfile <- "tidy-sensordata--mean-stddev--by-activity-and-person.txt"
message(sprintf("Now writing out tidy data set to disk as tab-sep .txt-file; \n filename ='%s', \n %i rows x %i columns", outfile, nrow(aggData), ncol(aggData)))
write.table(aggData, file = outfile, sep = "\t", row.names = FALSE)


