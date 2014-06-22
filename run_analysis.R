# run_analysis.R


#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each . 


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
                        warning(paste0("Now inside ", getwd()), immediate.=FALSE)
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
###read in all files extracted from the zip-file, will filter this many times later.
file.list <- list.files(subdir, full.names=TRUE, recursive=TRUE, pattern="*.txt")



############################################################################################################################
# get the feature list of mean and stddev
###########################################################################################################################

fms <- filter_featurenames(file.list)
#returns
# 
# FeatureID                     FeatureName
# 1           1               tBodyAcc-mean()-X
# 2           2               tBodyAcc-mean()-Y





############################################################################################################################
#Merge the training and the test sets to create one data set.
############################################################################################################################

datafile.list <- file.list[grep( "X_", file.list)]

# find column types  , sample 1 file
n <- 1
datafiles.initially <- head(datafile.list,n)
#data.initially <- read_data_fwf(datafiles.initially)
#sample 2 rows
nr <- 2
data.initially <- read_data(datafiles.initially, nRow=2)
classes <- sapply(data.initially, class)

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
names(data) <- fms$FeatureName
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

subjectlabelfile.list <- file.list[grep( "subject_", file.list)]

subjectlabels <- do.call("rbind",lapply(subjectlabelfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("SubjID"))}))
#cbind(subjectlabels, "SubjName", function(x){paste0("Person") )

 
head(subjectlabels, 3)
range(subjectlabels)



############################################################################################################################
#Create a second, independent tidy data set with the average of each variable 
#for each activity and each . 
############################################################################################################################






