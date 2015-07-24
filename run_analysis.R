#package management
#opt <- options(warn = -1)
list.of.packages <- c()
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("UCI HAR Dataset")){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
print("Downloading file...")
download.file(fileUrl,destfile="./data/getdata-projectfiles-UCI HAR Dataset.zip")
print("Download finished. Unzipping...")
unzip("./data/getdata-projectfiles-UCI HAR Dataset.zip")}
print("Unzip finished.")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
features <- read.table("UCI HAR Dataset/features.txt")

#apply variable names from features.text to x_train & x_test
for (i in 1:561){
        names(x_test)[i] <- levels(features$V2)[i]
        names(x_train)[i] <- levels(features$V2)[i]
}

#merge subjects to x_test & x_train
names(subject_train)[1] <- "Subject"
names(subject_test)[1] <- "Subject"
x_test <- cbind(subject_test,x_test)
x_train <- cbind(subject_train,x_train)
