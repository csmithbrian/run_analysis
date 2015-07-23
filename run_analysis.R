if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/getdata-projectfiles-UCI HAR Dataset")){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/getdata-projectfiles-UCI HAR Dataset.zip")
unzip("./data/getdata-projectfiles-UCI HAR Dataset.zip")}
#read data
x_train <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")

#read features.txt into list to apply variable names to x_train & x_test
