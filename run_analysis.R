#package management
#opt <- options(warn = -1)
list.of.packages <- c("dplyr","reshape2")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
require(dplyr)

if(!file.exists("./data")){dir.create("./data")}
if(!file.exists("./data/UCI HAR Dataset")){
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
print("Downloading file...")
download.file(fileUrl,destfile="./data/getdata-projectfiles-UCI HAR Dataset.zip")
print("Download finished. Unzipping...")
unzip("./data/getdata-projectfiles-UCI HAR Dataset.zip",exdir = "./data")
print("Unzip finished.")}
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./data/UCI HAR Dataset/features.txt")
activity_names <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

#apply variable names from features.text to x_train & x_test
for (i in 1:561){
        names(x_test)[i] <- as.character(features$V2[i])
        names(x_train)[i] <- as.character(features$V2[i])
}

#merge/clean/label data
names(subject_train)[1] <- "Subject"
names(subject_test)[1] <- "Subject"
x_test$Group <- "Test"
x_train$Group <- "Train"
x_test <- cbind(subject_test,x_test)
x_train <- cbind(subject_train,x_train)
x_merged <- rbind(x_train,x_test)
y_merged <- rbind(y_train,y_test)
names(y_merged)[1] <- "activity_id"
names(activity_names)[1] <- "activity_id"
names(activity_names)[2] <- "activity_label"
xy_merged <- cbind(y_merged,x_merged)

#extract just the means and std dev using an index of variables containing "mean" or "std"
meanStdCols <- grep("mean|std",names(xy_merged),value = FALSE)
idCols <- c(1,2,564)
extracted_data_index <- c(idCols,meanStdCols) 
extracted_data <- xy_merged[extracted_data_index]
extracted_data <- merge(x = extracted_data,y = activity_names,by.x = "activity_id",by.y = "activity_id")

#rename the variables
legalnames <- make.names(names(extracted_data)[4:82],unique = TRUE)
names(extracted_data)[4:82] <- legalnames

# Create the tidy dataset of means by melting data to long form and dcasting a mean on Subject and activity_label
tidyset <- melt(extracted_data,id.vars = c("Subject","activity_label"),measure.vars = 4:82) %>% dcast(Subject+activity_label~variable,mean)
write.table(x = tidyset,file = "tidyset.txt",row.names = FALSE)









