CourseProject
=============

Getting and Cleaning Data Course Project Repo

Executing run_analisys.R does the following:

 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

To run the script, run_analysis.R has to be in your working directory, and the data files have to be unpacked in your working directory.  The script is looking for a /UCI HAR DataSet directory in the working directory,

The result of running the script is:

>reading features
>trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
>testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
> 
>Merges the training and the test sets to create one data set.
>data <- rbind(trainingData,testData)
> 
>Appropriately labels the data set with descriptive variable names. 
>columnNames<-read.table("./UCI HAR Dataset/features.txt")
>colnames(data)<-columnNames[,2]
> 
> Extracts only the measurements on the mean and standard deviation for each measurement.
> meansData <- data[, grep("mean",colnames(data))]
> stdData <-data[,grep("std",colnames(data))]
> data <- cbind(meansData,stdData)
> 
> #3. Uses descriptive activity names to name the activities in the data set
> actTrainLabel <- read.table("./UCI HAR Dataset/train/y_train.txt")
> actTestLabel <- read.table("./UCI HAR Dataset/test/y_test.txt")
> activityLabel<-rbind(actTrainLabel,actTestLabel)
> data["Activity"]<-activityLabel
> activityname <-read.table("./UCI HAR Dataset/activity_labels.txt")
> activities <- factor(newdata$Activity,labels=activityname$V2)
> data["Activity"]<-activities
> 
> #5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
> train_subj<-read.table("./UCI HAR Dataset/train/subject_train.txt")
> test_subj<-read.table("./UCI HAR Dataset/test/subject_test.txt")
> subjects <- rbind(train_subj,test_subj)
> data["subject"]<-subjects$V1
> 
> library(reshape2)
> reshaped_data <-melt(data,id=c("subject","Activity"))
> data_mean <- dcast(reshaped_data,subject + Activity ~ variable,mean)
> write.table(data_mean,"./UCI HAR Dataset/cleandata.txt",row.names=FALSE,quote=FALSE)
> #reading features
> trainingData <- read.table("./UCI HAR Dataset/train/X_train.txt")
> testData <- read.table("./UCI HAR Dataset/test/X_test.txt")
