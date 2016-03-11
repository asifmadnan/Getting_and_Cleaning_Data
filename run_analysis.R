#loading the required data.table library
library(data.table)

#activity names file
activityFile <- "./data/UCI HAR Dataset/activity_labels.txt"

#getting the activity names
activityLabels <- read.table(activityFile) 
activityLabels[,2] <- as.character(activityLabels[,2])

#feature files
featureFile <- "./data/UCI HAR Dataset/features.txt"

#getting feature names
features <- read.table(featureFile)
features[,2] <- as.character(features[,2])

#target features
##having mean or std in the text
#the following line will filter the index of the target features
targetFeatures <- grep(".*mean*.|.*std*.", features[,2])

#the following line will get the target feature names
targetFeatures.names <- features[targetFeatures,2]

#re assign easy names for the target naems
targetFeatures.names <- gsub("-mean", "Mean", targetFeatures.names)
targetFeatures.names <- gsub("-std", "Std", targetFeatures.names)
targetFeatures.names <- gsub("[-()]", "", targetFeatures.names)


#retrieving tarining data
#original train data has 7352 records of 561 attributes (7352 rows and each row having 561 columns)
#retrieve only the columns representing the target attibutes. In that case, there will be 79 attributes
trainData <- read.table("./data/UCI HAR Dataset/train/X_train.txt")[targetFeatures]

#retrieve train subjects and activities, respenctively
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
trainActivities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")

#include subject and activity with relavant values.Now, trainData has 81 attributes
trainData <- cbind(trainSubjects, trainActivities, trainData)


#retrieving test data
#original test data has 7352 records of 561 attributes (7352 rows and each row having 561 columns)
#retrieve only the columns representing the target attibutes. In that case, there will be 79 attributes
testData <- read.table("./data/UCI HAR Dataset/test/X_test.txt")[targetFeatures]

#retrieve test subjects and activities, respenctively
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
testActivities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")

#include subject and activity with relavant values.Now, trainData has 81 attributes
testData <- cbind(testSubjects, testActivities, testData)

#combining training and test data
allData <- rbind(trainData, testData)

#assigning attribute names
colnames(allData) <- c("subject", "activity", targetFeatures.names)

#factorize combined data with respect to activity, where activity levels and activity lables (names) are from the 
#activity definition table
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

#merge data for each subject for each of the activity, where the other two attributes will be, 
# a feature name and its value
allData.melted <- melt(allData, id = c("subject", "activity"))

#calculate for each subject and for each activity, the means of the all the target attributes
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

#write the calculated means for all the target attributes as tidy data
write.table(allData.mean, "./data/tidy.txt", row.names = FALSE, quote = FALSE)
