# Read data from training data set and append data from test data set
x_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
x_data <- rbind(x_data, read.table("./UCI HAR Dataset/test/X_test.txt"))

# Read data about activities from training data set and append data from test data set
y_data <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_data <- rbind(y_data, read.table("./UCI HAR Dataset/test/y_test.txt"))

# Read subject data from training data set and append data from test data set
subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subjects <- rbind(subjects, read.table("./UCI HAR Dataset/test/subject_test.txt"))

# Read activity labels
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Read column headers for X data set from features data set
features <- read.table("./UCI HAR Dataset/features.txt")

# Find features containing "mean()" and "std()" to limit columns of tidy output
feature.index <- c(grep("mean()", features[,2], fixed=T), grep("std()", features[,2], fixed=T))
feature.names <- as.character(features[feature.index,2])

# Merge columns from subjects, activities, and subset of features using index
# of feature names that matched above
subsetdata <- cbind(subjects, y_data, x_data[,feature.index])

# Rename the columns of the tidy_data set appropriately
names(subsetdata) <- c("subject","activity",feature.names)

# Calculate mean for all columns except the first two (activity and subject),
# grouped by each activity and subject
tidy_data <- aggregate(subsetdata, by=list(activity,subject), FUN=mean, na.rm=T)[,c(-1,-2)]

# Merge activity data frame to lookup labels for each activity id
tidy_data <- merge(activities, tidy_data, by.x = "V1", by.y = "activity")

# Remove activity id column
tidy_data[1] <- NULL

# Rename activity lookup column to "activity"
names(tidy_data)[1] <- "activity"

# Save tidy_data to a file named "tidy_data_mean.txt"
write.table(tidy_data, file="tidy_data.txt", row.names=FALSE)