# libraries
library(plyr)
library(dplyr)

# Extracting info for train and test is common code.
make_ds <- function(x_file, y_file, subject_file, feature_list) {
    x_data <- read.table(x_file)[feature_list]
    activities <- read.table(y_file)
    subjects <- read.table(subject_file)
    tbl <- cbind(subjects, activities, x_data)
    return(tbl)
}

# move into the directory containing the data
setwd("./UCI_HAR_Dataset")

# get names of desired features (any mean or std)
features <- read.table("features.txt", header = FALSE)
mean_std <- grep("mean\\(\\)|std\\(\\)", features[, 2])
fnames <- features[mean_std, 2]

# make data frames for train and test
train <- make_ds("./train/X_train.txt", "./train/y_train.txt",
        "./train/subject_train.txt", mean_std)
test <- make_ds("./test/X_test.txt", "./test/y_test.txt",
        "./test/subject_test.txt", mean_std)

# merge train and test and give the result column names
allData <- rbind(train, test)
names <- c("subject", "activity", as.character(fnames))
n2 <- gsub("-mean\\(\\)[-]*", "Mean", names)
names <- gsub("-std\\(\\)[-]*", "StdDev", n2)
colnames(allData) <- names

# Use activity names instead of numbers
activities <- read.table(activity_labels.txt, headers = FALSE)
colnames(activities) <- c("activity", "Activity")
z <- merge(x = activities, y = allData, by = "activity", y.all = TRUE)
allData <- z[, -1]

# make a new tidy data set with the average of each variable by
# activity and subject
tidy_data <- ddply(allData, .(subject, Activity), function(x) { colMeans(x[, -c(1,2)]) }
write.table(tidy_data, "../tidy_data.txt", row.name = FALSE)

