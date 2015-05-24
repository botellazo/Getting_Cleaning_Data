
## Uploading de libraries we need to work with the data
##

    library(data.table)
    library(dplyr)   

##
## Reading the files containing the names of features and activities
##

    feat_names <- read.table("UCI HAR Dataset/features.txt")
    activ_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

##
## Reading files containing train data
##


    subj_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
    activ_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
    feat_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

##
## Reading files containing test data
##


    subj_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
    activ_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
    feat_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

##
## In this section we are row binding thee files for train and test of subjects,
##    

    subj <- rbind(subj_train, subj_test)
    activ <- rbind(activ_train, activ_test)
    feat <- rbind(feat_train, feat_test)

##
## Giving names to the columns 
##    
    
    colnames(feat) <- t(feat_names[2])

##
##  Merging data
##
    
    colnames(activ) <- "Activity"
    colnames(subj) <- "Subject"
    complete_Data <- cbind(feat,activ,subj)
	
	
	
## PART 2
##
## Extracts only the measurements on the mean and standard deviation for each measurement    
##
    
    

## PART 3
## Uses descriptive activity names to name the activities in the data set
## 

  

## PART 4
## 
## Appropriately labels the data set with descriptive variable names
##

## PART 5
##
##  create a second, independent tidy data set with the average of 
##  each variable for each activity and each subject
##
    
