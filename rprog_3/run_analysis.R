# Getting and Cleaning Data Course Project
#
# 2015 Daniel Molnar soobrosa@gmail.com

# set working directory to uncompressed dataset

setwd("Desktop/r/rprog_3/UCI HAR Dataset")

# "Merges the training and the test sets to create one data set."
# read.table took care of the simple and double spaces
# I tried to avoid extra libraries -- in this one I failed --
# so rbind was a natural choice to concat the two datasets

test = read.table("test/X_test.txt")
train = read.table("train/X_train.txt")
merged = rbind(test, train)

# "Appropriately labels the data set with descriptive variable names."
# I named the columns of merged as the transposed 2nd row from reading features.txt

features = read.table("features.txt")
feature_names = t(features)[2, ]
colnames(merged) <- feature_names

# "Extracts only the measurements on the mean
# and standard deviation for each measurement."
# I presumed that each measurement name that ends with '-mean()' or '-std()'
# is a calculated one that fits the description, so I regexed them
# and subsetted the merged table to these columns

select = c(grep("-mean\\(\\)", feature_names), grep("-std\\(\\)", feature_names))
extract = merged[, select]

# "Uses descriptive activity names to name the activities in the data set"
# when I wanted to have proper 'activity' and 'subject' columns
# I found that I can't use 'merge' on to decode activity number to names
# as it changes the order of rows so I ended up using
# my first non-default library, 'plyr' to be able to use 'join'
# 'subject' was easier with a simple 'cbind'

library(plyr)

ytest = read.table("test/y_test.txt")
ytrain = read.table("train/y_train.txt")
ymerged = rbind(ytest, ytrain)
ylabels = read.table("activity_labels.txt")
extract$activity <- join(ymerged, ylabels)[, 2]

stest = read.table("test/subject_test.txt")
strain = read.table("train/subject_train.txt")
smerged = rbind(stest, strain)
colnames(smerged) <- 'subject'
extract <- cbind(extract, smerged)

# "From the data set in step 4, creates a second, independent tidy data set
# with the average of each variable for each activity and each subject."
# after playing around with reshape, melt and acast, I found using 'dplyr'
# and 'tidyr' ends up with a readable code

# calculate the average
library(dplyr)
summary <- extract %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# produce tidy dataset
library(tidyr)
tidied <- summary %>% gather(subject, activity)

# fix up column names and dump the output
colnames(tidied) <- c("subject", "activity", "measurement", "average")
write.table(tidied, "tidy.txt", row.names = FALSE)

