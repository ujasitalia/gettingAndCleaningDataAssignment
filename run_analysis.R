# filename <- "getdata_dataset.zip"
# 
# ## Download and unzip the dataset:
# if (!file.exists(filename)){
#     fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
#     download.file(fileURL, filename, method="curl")
# }  
# if (!file.exists("UCI HAR Dataset")) { 
#     unzip(filename) 
# }

#----> 1 : Merges the training and the test sets to create one data set. <------#

# 1.1 reading data : 

#train data
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#test data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#labels
features <- read.table('./UCI HAR Dataset/features.txt')
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')

#assigning column names
colnames(x_train) <- features[, 2]
colnames(x_test) <- features[, 2]
colnames(y_train) <- "activityId"
colnames(y_test) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(subject_test) <- "subjectId"
colnames(activityLabels) <- c("activityId", "subjectId")

# 1.2 merging data :

mrg_train <- cbind(y_train, subject_train, x_train)
mrg_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(mrg_train, mrg_test)

#-----> 2. Extracts only the measurements on the mean and standard deviation for each measurement. <-----#
colNames <- colnames(setAllInOne)
requiredColumns <- (
                        (grepl("activityId", colNames)) |
                        (grepl("subjectId", colNames)) |
                        (grepl("mean..", colNames)) |
                        (grepl("std..", colNames))
                    )

#creating dataset of only mean and std columns in it
setForMeanAndStd <- setAllInOne[ , requiredColumns]

#----> 3. Uses descriptive activity names to name the activities in the data set <-------#

setWithActivityNames <- merge(setForMeanAndStd, activityLabels, by=c('activityId','subjectId'), all.x=TRUE)


#-----> 4. Appropriately labels the data set with descriptive variable names. <------# 

colnames(setWithActivityNames) <- gsub("-mean", "Mean", colnames(setWithActivityNames))
colnames(setWithActivityNames) <- gsub("-std", "Std", colnames(setWithActivityNames))
colnames(setWithActivityNames) <- gsub("[-()]", "", colnames(setWithActivityNames))


#-----> 5. From the data set in step 4, creates a second, independent tidy data  
#          set with the average of each variable for each activity and each subject. <------#
 
setWithActivityNames$activityId <- factor(setWithActivityNames$activityId, levels = activityLabels[,1], labels = activityLabels[,2])
setWithActivityNames$subjectId <- as.factor(setWithActivityNames$subjectId)

mel <- melt(setWithActivityNames, id = c("activityId", "subjectId"))
me  <- dcast(mel, activityId + subjectId ~ variable, mean)

write.table(me, "tidyDataSet.txt", row.names = FALSE, quote = FALSE)

