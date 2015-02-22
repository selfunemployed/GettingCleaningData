# README

## Steps to reproduce tidy data set

1. Download source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and extract to working directory.
2. Execute run_analysis.R
3. Output TXT file will be saved as "tidy_data.txt" in the working directory

## Explanation of run_analysis.R code

The code performs the following steps to produce the tidy data set. Comments can also be found in the script.

1. Read data from training data set and append data from test data set
2. Read data about activities from training data set and append data from test data set
3. Read subject data from training data set and append data from test data set
4. Read activity labels
5. Read column headers for X data set from features data set
6. Find features containing "mean()" and "std()" to limit columns of tidy output
7. Merge columns from subjects, activities, and subset of features using index of feature names that matched above
8. Rename the columns of the tidy_data set appropriately
9. Calculate mean for all columns except the first two (activity and subject), grouped by each activity and subject
10. Merge activity data frame to lookup labels for each activity id
11. Remove activity id column
12. Rename activity lookup column to "activity"
13. Save tidy_data to a file named "tidy_data_mean.txt"