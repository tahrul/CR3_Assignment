## importing all required packages
library("data.table")
library("plyr")
library("reshape2")
library("dplyr")

#Assignent part-1
## Merges the training and the test sets to create one data set
setwd("C:/coursera_project/cr3wk4/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")

#reading data from 30 subjects from both test and train
data_subject_test <- tbl_df(read.table(file.path("./test/subject_test.txt")))
data_subject_train <- tbl_df(read.table(file.path("./train/subject_train.txt")))
#reading six type of activities of all subjects from both test and train
data_activity_test <- tbl_df(read.table(file.path("./test/y_test.txt")))
data_activity_train <- tbl_df(read.table(file.path("./train/y_train.txt")))
#reading all the measurement data/rows from both test and train
data_test <- tbl_df(read.table(file.path("./test/X_test.txt")))
data_train <- tbl_df(read.table(file.path("./train/X_train.txt")))

#merging all subject rows from both test & train data  (have equal # of column)
merged_data_subject <- rbind(data_subject_test, data_subject_train)
setnames(merged_data_subject, "V1", "subject")
#merging all activity rows from both test & train data  (have equal # of column)
merged_data_activity<- rbind(data_activity_test, data_activity_train)
setnames(merged_data_activity, "V1", "activityNum")

#Merge both the test and training sets to create one data set (have equal # of column)
single_table <- rbind(data_train, data_test)
#End of Part1------------------------------------------------------------------------------------------------------

#reading variable names from feature.txt file
data_Features <- tbl_df(read.table(file.path("./features.txt"))) #total 561 variable -> mean, coff etc....
setnames(data_Features, "V1", "featureNum" )
setnames(data_Features, "V2", "featureName")
colnames(single_table) <- data_Features$featureName  #updating variable name in merged signal dataset as per feature list
#reading activity type from activity_labels.txt file
activity_Labels <- tbl_df(read.table(file.path("./activity_labels.txt")))
setnames(activity_Labels, "V1", "activityNum" )
setnames(activity_Labels, "V2", "activityName")

#subject, activity, signal measurement data all have same # of row (7352 rows)
merged_data_Subject_Activity<- cbind(merged_data_subject, merged_data_activity)
single_table <- cbind(merged_data_Subject_Activity, single_table)  #two col added (subj,actv num). so, total col=561+2=563

#Assignent part-2
#Extracts only the measurements on the mean and standard deviation for each measurement
data_mean_std <-single_table[,grepl("mean|std|subject|activityNum",colnames(single_table))] #matching pattern from the single dataset column names
single_table<-data_mean_std  #considering the single set with Mean, STD variables only
#End of Part2------------------------------------------------------------------------------------------------------

#Assignent part-3
##Use descriptive activity names to name the activities in the data set
single_table <- merge(activity_Labels, single_table , by="activityNum", all.x=TRUE) #Inner join to include descriptive activity name
#End of Part3-------------------------------------------------------------------------------------------------------

#Assignment part-4
#Label the dataset with descriptive variable names
# Labelling variables based on description from feature_info.txt file
names(single_table) <- gsub("Acc", "Accelerometer", names(single_table))
names(single_table) <- gsub("Jerk", "JerkSignal", names(single_table))
names(single_table) <- gsub("Gyro", "Gyroscope", names(single_table))
names(single_table) <- gsub("Mag", "Magnitude", names(single_table))
names(single_table) <- gsub("^t", "Time", names(single_table))
names(single_table) <- gsub("^f", "Frequency", names(single_table))
names(single_table) <- gsub("Freq", "Frequency", names(single_table))
#End of Part4-------------------------------------------------------------------------------------------------------

#Assignment part-5
#Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidyData_ddply<- ddply(single_table,c("subject","activityNum"),numcolwise(mean))
write.table(tidyData_ddply,file="tidyData_ddply_4.txt",row.name=FALSE)
#End of Part5-------------------------------------------------------------------------------------------------------



