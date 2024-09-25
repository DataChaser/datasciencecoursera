#Set working directory
setwd('D:/Courses/Data_Science/John_Hopkins_Specialization/Course3')

#Download and unzip the dataset
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

#Load the necessary data
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

#Load training data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

#Load test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")

#Merge the training and test sets
subject <- rbind(subject_train, subject_test)
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
merged_data <- cbind(subject, y_data, x_data)

#Extract measurements on the mean and standard deviation
mean_std_columns <- grepl("mean\\(\\)|std\\(\\)", features$feature)
x_data_mean_std <- x_data[, mean_std_columns]

#Merge the selected columns with subject and activity data
merged_mean_std <- cbind(subject, y_data, x_data_mean_std)

#Use descriptive activity names to name the activities in the data set
merged_mean_std$activity <- activities[merged_mean_std$activity, 2]

#Label the data set with descriptive variable names
names(merged_mean_std) <- gsub("^t", "Time", names(merged_mean_std))
names(merged_mean_std) <- gsub("^f", "Frequency", names(merged_mean_std))
names(merged_mean_std) <- gsub("Acc", "Accelerometer", names(merged_mean_std))
names(merged_mean_std) <- gsub("Gyro", "Gyroscope", names(merged_mean_std))
names(merged_mean_std) <- gsub("Mag", "Magnitude", names(merged_mean_std))
names(merged_mean_std) <- gsub("BodyBody", "Body", names(merged_mean_std))

#Create a second, independent tidy dataset with the average of each variable for each activity and each subject
library(dplyr)
tidy_data <- merged_mean_std %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

#Write the tidy data to a text file
write.table(tidy_data, "tidy_data.txt", row.name = FALSE)
