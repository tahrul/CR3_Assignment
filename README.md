==================================================================
Signal data consolidating, cleaning and summarizing from smartphone (Samsung Galaxy S II) on the waist (using its embedded accelerometer and gyroscope). 30 subject was used in the experiment where data collected for 6 types of activities for each subject.

Version 1.0
==================================================================
Tahrul Amin
==================================================================

At the beginning of the assignment, all the required packages has been imported that includes ''data.table','plyr'.'reshape2','dplyr'

#Assignent part-1
## Merges the training and the test sets to create one data set

all the data files related to signal data, activity, subject has been read from both test and train dataset.

all subject rows from both test & train data  (have equal # of column) has been merged using rbind.

all activity rows from both test & train data  (have equal # of column) has been merged using rbind.

all signal data has been merged in a single dataset using rbind.
----------------------------------------------------------------
#Assignent part-2
#Extracts only the measurements on the mean and standard deviation for each measurement

reading variable names from feature.txt file (total 561 variables)

reading activity type from activity_labels.txt file

Merge all subject, activity, signal measurement data (all have same # of row (7352 rows) )

matching pattern (using 'grep' function) from the single dataset column names to select only the measurements on the mean and standard deviation for each measurement (along with subject and activity number)
----------------------------------------------------------------
#Assignent part-3
##Use descriptive activity names to name the activities in the data set

Inner join (using common column 'activityNum')between single dataset and activity label to include descriptive activity name
----------------------------------------------------------------
#Assignment part-4
#Label the dataset with descriptive variable names

Labelling variables based on description from feature_info.txt file. 'gsub' function used to replace by meaningful variable name using regular expression inside
----------------------------------------------------------------
#Assignment part-5
#Create a second, independent tidy data set with the average of each variable for each activity and each subject

'ddply' package has been used to calculate the average of mean,std variables for each activity and corresponding subjects. Total 180 combination will be created (30 subject * 6 type of activities)  
----------------------------------------------------------------


License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
