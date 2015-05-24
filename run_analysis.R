##
## Uploading de libraries we need to work with the data
##

    library(data.table)
    library(dplyr)   
run_analysis<-function(){
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

##
## Extracts only the measurements on the mean and standard deviation for each measurement    
##
    
    col_Mean_STD <- grep(".*Mean.*|.*Std.*", names(complete_Data), ignore.case=TRUE)

    ask_columns <- c(col_Mean_STD, 562, 563)
    dim(complete_Data)

    xtrac_Data <- complete_Data[,ask_columns]
    dim(xtrac_Data)

##
## Uses descriptive activity names to name the activities in the data set
## 

    xtrac_Data$Activity <- as.character(xtrac_Data$Activity)
      for (i in 1:6){
        xtrac_Data$Activity[xtrac_Data$Activity == i] <- as.character(activ_labels[i,2])
      }

    xtrac_Data$Activity <- as.factor(xtrac_Data$Activity)

## 
## Appropriately labels the data set with descriptive variable names
##

    names(xtrac_Data)

    names(xtrac_Data)<-gsub("Acc", "Accelerometer", names(xtrac_Data))
    names(xtrac_Data)<-gsub("Gyro", "Gyroscope", names(xtrac_Data))
    names(xtrac_Data)<-gsub("BodyBody", "Body", names(xtrac_Data))
    names(xtrac_Data)<-gsub("Mag", "Magnitude", names(xtrac_Data))
    names(xtrac_Data)<-gsub("^t", "Time", names(xtrac_Data))
    names(xtrac_Data)<-gsub("^f", "Frequency", names(xtrac_Data))
    names(xtrac_Data)<-gsub("tBody", "TimeBody", names(xtrac_Data))
    names(xtrac_Data)<-gsub("-mean()", "Mean", names(xtrac_Data), ignore.case = TRUE)
    names(xtrac_Data)<-gsub("-std()", "STD", names(xtrac_Data), ignore.case = TRUE)
    names(xtrac_Data)<-gsub("-freq()", "Frequency", names(xtrac_Data), ignore.case = TRUE)
    names(xtrac_Data)<-gsub("angle", "Angle", names(xtrac_Data))
    names(xtrac_Data)<-gsub("gravity", "Gravity", names(xtrac_Data))

    names(xtrac_Data)

##
##  create a second, independent tidy data set with the average of 
##  each variable for each activity and each subject
##
    
    xtrac_Data$Subject <- as.factor(xtrac_Data$Subject)
    xtrac_Data <- data.table(xtrac_Data)

    tidy_Data <- aggregate(. ~Subject + Activity, xtrac_Data, mean)
    tidy_Data <- tidy_Data[order(tidy_Data$Subject,tidy_Data$Activity),]
    write.table(tidy_Data, file = "Tidy_tarea.txt", row.names = FALSE)
}


