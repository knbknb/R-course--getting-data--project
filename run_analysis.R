# run_analysis.R

#library(Hmisc) # for describe()
# make sure there is no rounding in display
options(digits=15)

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
featuresfile.list <- file.list[grep( "features.txt", file.list)]

features <- do.call("rbind",lapply(featuresfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="")}))
fms <- features[grep( "mean|std", features$V2, perl=TRUE),]
fms


############################################################################################################################
#Merge the training and the test sets to create one data set.
############################################################################################################################

subjectdatafile.list <- file.list[grep( "X_", file.list)]
n <- 1
subjectdatafiles.initially <- head(subjectdatafile.list,n)
subjectdata.initially <- do.call("rbind",lapply(subjectdatafiles.initially ,
                                                FUN=function(files){#print(files);
                                                        read.fwf(files, widths=rep(16, 128), nrow=10, strip.white=TRUE,comment.char = "",
                                                                 stringsAsFactors=FALSE,
                                                                 header=FALSE)}))
classes <- sapply(subjectdata.initially, class)
classes
n <- length(subjectdatafile.list)
subjectdatafile.use <- head(subjectdatafile.list,n)
subjectdatafile.use 
subjectdata <- do.call("rbind",lapply(subjectdatafile.use,
                                      FUN=function(files){#print(files);
                                              read.fwf(files, widths=rep(16, 128),  strip.white=TRUE,comment.char = "",
                                                       colClasses=classes,stringsAsFactors=FALSE,
                                                       header=FALSE)}))
head(subjectdata)
msg_parse_result(colSums(is.na(subjectdata)), nrow(subjectdata),  length(names(subjectdata))) # check that there are no NAs in the dataset

#- this is not really required for this assignment but I have done it nevertheless.
# ### Merge the sensor data 
# 
# sensordatafile.list <- file.list[grep( "Inertial Signals", file.list)]
# n <- 2
# sensordatafiles.initially <- head(sensordatafile.list,n)
# 
# 
# sensordata.initially <- do.call("rbind",lapply(sensordatafiles.initially ,
#                                                FUN=function(files){#print(files);
#                                                        read.fwf(files, widths=rep(16, 128), nrow=10, strip.white=TRUE,comment.char = "",
#                                                                 stringsAsFactors=FALSE,
#                                                                 header=FALSE)}))
# classes <- sapply(sensordata.initially, class)
# classes
# n <- length(sensordatafile.list)
# sensordatafile.use <- head(sensordatafile.list,n)
# sensordatafile.use 
# 
# 
# sensordata <- do.call("rbind",lapply(sensordatafile.use,
#                                      FUN=function(files){#print(files);
#                                              read.fwf(files, widths=rep(16, 128),  strip.white=TRUE,comment.char = "",
#                                                       colClasses=classes,stringsAsFactors=FALSE,
#                                                       header=FALSE)}))
# head(sensordata)
# msg_parse_result(colSums(is.na(sensordata)), nrow(sensordata),  length(names(sensordata))) # check that there are no NAs in the dataset

############################################################################################################################
#Extract only the measurements on the mean and standard deviation for each measurement. 
############################################################################################################################

#############################################################################################################################
#Use descriptive activity names to name the activities in the data set
############################################################################################################################
activitieslabelsfile.list <- file.list[grep( "activity", file.list)]
activities_labels <- lapply(activitieslabelsfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="", col.names=c("Act.code", "Act.label"))})
activities_labels

activitiesfile.list <- file.list[grep( "/y_", file.list)]
activities <- do.call("rbind",lapply(activitiesfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="")}))
head(activities, 5)
range(activities)
############################################################################################################################
#Appropriately label the data set with descriptive variable names. 
############################################################################################################################

subjectlabelfile.list <- file.list[grep( "subject_", file.list)]


subjectlabelfile.list
subjectlabels <- do.call("rbind",lapply(subjectlabelfile.list , FUN=function(fn) {read.table(fn, header=FALSE, quote="")}))
subjectlabels
range(subjectlabels)



############################################################################################################################
#Create a second, independent tidy data set with the average of each variable 
#for each activity and each subject. 
############################################################################################################################






