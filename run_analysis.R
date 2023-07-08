library(plyr)

# Import for fread()
library(data.table)

# Make data directory if it doesn't already exist
if(!dir.exists("./data")) {
    dir.create("./data")
    
    # Pull data into R the same way we have been all course
    # 
    # Keeping this within the if/else as it's the only data that will be used
    # in this project, so it won't be downloaded every time
    url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(url = url, "accelerometersMessy")
    unzip("accelerometersMessy", exdir = "./data")
}

# Suck in each individual data set into its own table
subjectTest <- fread(file = "./data/UCI HAR Dataset/test/subject_test.txt")
xTest <- fread(file = "./data/UCI HAR Dataset/test/x_test.txt")
yTest <- fread(file = "./data/UCI HAR Dataset/test/y_test.txt")
subjectTrain <- fread(file = "./data/UCI HAR Dataset/train/subject_train.txt")
xTrain <- fread(file = "./data/UCI HAR Dataset/train/X_train.txt")
yTrain <- fread(file = "./data/UCI HAR Dataset/train/y_train.txt")

features <- fread(file = "./data/UCI HAR Dataset/features.txt")
activities <- fread(file = "./data/UCI HAR Dataset/activity_labels.txt")

# PART 1
# Mash it all together to get one data table
fullMessy <- as.data.frame(cbind(rbind(subjectTest, subjectTrain),
                   rbind(yTest, yTrain), rbind(xTest, xTrain)))

# PART 4
# Appropriately name columns, first two manually and all others from features
colnames(fullMessy)[1:2] <- c("Subject", "Activity")
endIndex <- ncol(fullMessy)
colnames(fullMessy)[3:endIndex] <- as.data.frame(features)[, 2]
rm(endIndex)

# PART 2
# Remove parts of the data table that aren't mean, std, activity, or subject
fullMessy <- fullMessy[, grepl("mean()|std()|Activity|Subject",
                               colnames(fullMessy)) & 
                           !grepl("meanFreq", colnames(fullMessy))]

# PART 3
# Labeling data with activity names
fullMessy$Activity <- factor(fullMessy$Activity,
                             levels = as.data.frame(activities)[, 1], 
                             labels = as.data.frame(activities)[, 2])

tidy <- ddply(fullMessy, c("Subject", "Activity"),
              .fun = function(x) {colMeans(x[, -c(1:2)])})

# PART 5
# Dump a summary to the console and then create a csv with the result
str(tidy)
write.csv2(tidy, "./data/tidy.txt", row.names = FALSE)
