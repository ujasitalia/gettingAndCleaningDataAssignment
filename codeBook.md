The original data was transformed by :

1.    Merging the training and the test sets to create one data set.
2.    Extracting only the measurements on the mean and standard deviation for each measurement.
3.    Using descriptive activity names to name the activities in the data set
4.    Appropriately labeling the data set with descriptive activity names.
5.    Creating a second, independent tidy data set with the average of each variable for each activity and each       subject.

Information about "run_analysis.R": 

The "run_analysis.R" file contains the code that performs the above 5 steps on the datasets in the folder "UCI HAR Dataset"

Information about variables :

1. x_train, y_train, x_test, y_test, subject_train and subject_test contain the data from the downloaded files.
2. mrg_train, mrg_test contain the merged data of the above files.
3. setAllInOne is the merged data set from the above two data sets.
4. setForMeanAndStd has the data about just mean and std variables from setAllInOne data set.
5. setWithActivityNames is the modified version of setForMeanAndStd with descriptive names.

Information about "tidyDataSet.txt":

this file contains the summary of all data based on the means of each variable.