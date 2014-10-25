#reading features
trainingData <- read.table("./train/X_train.txt")
testData <- read.table("./test/X_test.txt")

#1. Merges the training and the test sets to create one data set.
data <- rbind(trainingData,testData)

#4. Appropriately labels the data set with descriptive variable names. 
columnNames<-read.table("features.txt")
colnames(data)<-columnNames[,2]

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
meansData <- data[, grep("mean",colnames(data))]
stdData <-data[,grep("std",colnames(data))]
data <- cbind(meansData,stdData)

#3. Uses descriptive activity names to name the activities in the data set
actTrainLabel <- read.table("./train/y_train.txt")
actTestLabel <- read.table("./test/y_test.txt")
activityLabel<-rbind(actTrainLabel,actTestLabel)
data["Activity"]<-activityLabel
activityname <-read.table("activity_labels.txt")
activities <- factor(newdata$Activity,labels=activityname$V2)
data["Activity"]<-activities

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
train_subj<-read.table("./train/subject_train.txt")
test_subj<-read.table("./test/subject_test.txt")
subjects <- rbind(train_subj,test_subj)
data["subject"]<-subjects$V1

library(reshape2)
reshaped_data <-melt(data,id=c("subject","Activity"))
data_mean <- dcast(reshaped_data,subject + Activity ~ variable,mean)
write.table(data_mean,"./cleandata.txt",row.names=FALSE,quote=FALSE)
