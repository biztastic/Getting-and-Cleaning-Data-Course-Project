# Getting and Cleaning Data Course Projectless 
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a 
# data set. The goal is to prepare tidy data that can be used for later analysis. You will be 
# graded by your peers on a series of yes/no questions related to the project. You will be 
# required to submit: 1) a tidy data set as described below, 2) a link to a Github repository
# with your script for performing the analysis, and 3) a code book that describes the variables, 
# the data, and any transformations or work that you performed to clean up the data called 
# CodeBook.md. You should also include a README.md in the repo with your scripts. This repo 
# explains how all of the scripts work and how they are connected.

# One of the most exciting areas in all of data science right now is wearable computing - see 
# for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop 
# the most advanced algorithms to attract new users. The data linked to from the course website 
# represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full 
# description is available at the site where the data was obtained:
  
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



# File Download: 
  
project_data<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_name<-"UCI HAR Dataset.zip"

download.file(project_data,file_name, mode="wb")
unzip(file_name, files=NULL, exdir=".")

# Read Tables

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt") 

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.

combined_subjects<- rbind(subject_test, subject_train)
combined_x <- rbind(X_test, X_train)
combined_y <- rbind(y_test, y_train)

combined_data<-cbind(combined_subjects,combined_y,combined_x)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

included_features<-grep("mean()|std()", features[,2]) 
combined_data<-combined_data[,c(1,2,included_features)]

# 3. Uses descriptive activity names to name the activities in the data set

combined_data[, 2] <- activity_labels[combined_data[,2], 2]

# 4. Appropriately labels the data set with descriptive variable names. 

clean_features <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
colnames(combined_data)<-c('subject','activity',clean_features[included_features])
combined_data[, 2] <- as.character(combined_data[, 2])

# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

#Install reshape2
install.packages('reshape2')
library(reshape2)

result<-melt(combined_data, id=c('subject','activity'))
result_mean<-dcast(result, subject+activity ~ variable, mean)
write.table(result_mean, file=file.path("tidy.txt"), row.names=FALSE, quote=FALSE)




