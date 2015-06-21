This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The run_analysis.R script cleans the data as follows:

Merges the training and test sets to create one data set. This is done using rbind. First, train/X_train.txt is merged with test/X_test.txt, the result of which is a 10299x561 data frame, as in the original description ("Number of Instances: 10299" and "Number of Attributes: 561”). Then train/subject_train.txt with test/subject_test.txt, the result of which is a 10299x1 data frame with subject IDs. Third, train/y_train.txt is merged with test/y_test.txt, the result of which is also a 10299x1 data frame with activity IDs.

Read the features.txt file from and stored the data in a variable called features. Extract only the measurements on the mean and standard deviation for each measurement.. The result is a 10299x66 data frame, because only 66 out of 561 attributes are measurements on the mean and standard deviation (a 66 indices list). Then we clean the column names of the subset.

Read the activity_labels.txt file from the folder and store the data in a variable called activity. Then apply descriptive activity names to name the activities in the data set: walking, walkingupstairs, walkingdownstairs, sitting, standing, laying. The data set is labelled with descriptive names: all feature names and activity names are converted to lower case, underscores and brackets () are removed. 

Then it merges the 10299x66 data frame containing features with the 10299x1 data frames containing activity labels and subject IDs. 

The result written out to “merged_data.txt” in the current working directory. This is a 10299x68 data frame with the first column containing subject IDs, the second column activity names, and the last 66 columns are measurements. Subject IDs are integers from 1 to 30.

Finally, the script creates a second, independent tidy data set with the average of each measurement for each activity and each subject. After performing two for-loops, the result is saved as “data_with_means.txt” in the current working directory. It is a 180x68 data frame, with the first column containing subject IDs, the second column activity names, and then the averages for each of the 66 attributes are in columns 3 to 68. There are 30 unique subjects and 6 unique activities, so we get 180 rows in this data set with averages.
