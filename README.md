# Course-Project
Course Project for "Getting and Cleaning Data"

*** Before running the "run_analysis.R" script - ensure the working directory is the base data file (..//UCI HAR Dataset_
You can change the working directory by:
setwd("where your data is located")

Additionally, the final product is called foo.csv - if you open in Excel, there will be row numbers
Otherwise, I encourage you to open the csv file using:
  tidy_df <- read.csv("foo.csv", row.names=1)
This should result in a dataframe titled "tidy_df" with 180 rows of 81 variables
There are 180 rows since I calculated the "mean" within each subset of "activities"

# Explination of R.Script #
There are comments within the R.Script, but I'll summarize here.

First we ensure the working directory is the data file
I stored the column headers in a list (features_head); and removed the numbers prior to the heading titles

Then we moved into the Test Directory
1. read the subject numbers
2. read the activity data
3. read the features data
4. used cbind to merge all the dataframes into one.

Repeated steps for the Training Data
except during step 4. we had to use rbind to add rows (not columns)

At this point I have a dataframe with 10,299 rows and 563 columns

# Step 2
I only kept the columns that had mean() or std() within the column header

# Step 3
Using a seperate dataframe as the key we changed the Activities - currently denoted with numbers into the descriptive variable names

# Step 4
I already added the column headers when I read the .txt files

# Step 5
At this point I calculated the mean values for each subject within the subset of each activity (30 subjects x 6 activities = 180 rows)

# Last Step
Saving the tidy dataframe as foo.csv

