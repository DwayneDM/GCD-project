#set working directory
#download and unzip the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# Step1. Merges the training and the test sets to create one data set.
t1 <- read.table("train/X_train.txt")
dim(t1)
t2 <- read.table("test/X_test.txt")
dim(t2)
X <- rbind(t1, t2)
dim(X) # 10299*561

t3 <- read.table("train/subject_train.txt")
t4 <- read.table("test/subject_test.txt")
S <- rbind(t3, t4)
dim(t3)
dim(t4)
dim(S) # 10299*1

t5 <- read.table("train/y_train.txt")
t6 <- read.table("test/y_test.txt")
Y <- rbind(t5, t6)
dim(t5)
dim(t6)
dim(Y) # 10299*1

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("features.txt")
dim(features) # 561*2
indices_ms <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
length(indices_ms) # 66
X <- X[, indices_ms]
dim(X) # 10299*66
names(X) <- features[indices_ms, 2]
names(X) <- gsub("\\(|\\)", "", names(X))
names(X) <- tolower(names(X))

# 3. Uses descriptive activity names to name the activities in the data set.
activity <- read.table("activity_labels.txt")
activity[, 2] = gsub("_", "", tolower(as.character(activity[, 2])))
Y[,1] = activity[Y[,1], 2]
names(Y) <- "activity"

# 4. Appropriately labels the data set with descriptive activity names.
names(S) <- "subject"
cleanData <- cbind(S, Y, X)
dim(cleanData) # 10299*68
write.table(cleanData, "merged_data.txt") # write out the 1st dataset

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
uniqueSubjects = unique(S)[,1]
subjectlen = length(unique(S)[,1])
activitylen = length(activity[,1])
numCols = dim(cleanData)[2]
result = cleanData[1:(subjectlen*activitylen), ]

row = 1
for (s in 1:subjectlen) {
  for (a in 1:activitylen) {
    result[row, 1] = uniqueSubjects[s]
    result[row, 2] = activity[a, 2]
    temp <- cleanData[cleanData$subject==s & cleanData$activity==activity[a, 2], ]
    result[row, 3:numCols] <- colMeans(temp[, 3:numCols])
    row = row+1
  }
}
write.table(result, "data_with_means.txt") # write out the 2nd dataset
head(result) # a look at the dataset
