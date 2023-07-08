library(dplyr)

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
