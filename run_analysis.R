# run_analysis.R


#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each . 


# F U N C T I O N S
###################################################################
## a simple helper function reporting file I/O
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
# these functions do a lot of heavy lifting (memory-intensive file I/O)
# DOES NOT WORK! - returns only 128 columns
read_data_fwf <- function(df){
        do.call("rbind",lapply(df ,
                               FUN=function(files){
                                       read.fwf(files, widths=rep(16, 128), nrow=10, strip.white=TRUE,comment.char = "",
                                                stringsAsFactors=FALSE,
                                                header=FALSE)}))
}

# WORKS!  returns df with 561 columns/variables
read_data <- function(df, colclasses=NA){
        do.call("rbind",lapply(df ,
                               FUN=function(files){
                                       read.table(files, colClasses = colclasses)}))
}

###################################################################

filter_featurenames <- function(df){
        featuresfile.list <- file.list[grep( "features.txt", file.list)]
        
        features <- do.call("rbind",lapply(featuresfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("FeatureID", "FeatureName"))}))
        features[grep( "mean\\(\\)|std\\(\\)", features$FeatureName, perl=TRUE),]
        
}


###################################################################
# Main part of script
###################################################################

# make sure there is no rounding in display
options(digits=15)

## We assume file has been downloaded and extracted already

d = "/home/knut/Documents/coursera/datascience/getting_data/R-course--getting-data--project"
if(! file.exists(d)){
        warning(sprintf("Directory '%s' not found. Enter full path to directory on your computer.", d ), immediate.=TRUE)
        n <- FALSE;
        while(! n){
                cat("Path (Ctrl-C to exit):")
                d <- readLines(con="stdin", n=1)
                n <- ifelse(! file.exists(d),FALSE, TRUE)
                #if(n == "0"){break}  # breaks when hit enter
                
        }
        setwd(d)
        warning(paste0("Now inside ", getwd()), immediate.=FALSE)
}
setwd(d)
d1 = "UCI HAR Dataset"
if(! file.exists(d1)){      
        stop(paste0("Subdir ", d1, " not found,. Must already exist and contain *.txt data files."))
        
        #message("You can run helper script download-and-extract.R to download and unzip necessary data files")
        #source("download-and-extract.R")
        #message(paste0("Subdir ", d1, " not found,. Must already exist and contain data files."))
        #message("You can run helper script download-and-extract.R to download and unzip necessary data files")
        #source("download-and-extract.R")
}

###read in all files extracted from the zip-file, will filter this many times later.
file.list <- list.files(d1, full.names=TRUE, recursive=TRUE, pattern="*.txt")



############################################################################################################################
# get the feature list of mean and stddev
###########################################################################################################################

fms <- filter_featurenames(file.list)

# 
# FeatureID                     FeatureName
# 1           1               tBodyAcc-mean()-X
# 2           2               tBodyAcc-mean()-Y





############################################################################################################################
#Merge the training and the test sets to create one data set.
############################################################################################################################

datafile.list <- file.list[grep( "X_", file.list)]

# find column types  
n <- 1
datafiles.initially <- head(datafile.list,n)
#data.initially <- read_data_fwf(datafiles.initially)
data.initially <- read_data(datafiles.initially)
classes <- sapply(data.initially, class)

n <- length(datafile.list)
datafile.use <- head(datafile.list,n)
datafile.use 
#data <- read_data_fwf(datafile.use)
data <- read_data(datafile.use, classes)
head(data)
msg_parse_result(colSums(is.na(data)), nrow(data),  length(names(data))) # check that there are no NAs in the dataset


############################################################################################################################
#Extract only the measurements on the mean and standard deviation for each measurement. 
############################################################################################################################
data <- data[,fms$FeatureID]

############################################################################################################################
#Appropriately label the data set with descriptive variable names. 
############################################################################################################################
names(data) <- fms$FeatureName
head(data, 1)

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






