getwd()
#setwd("/Users/fredd/Documents/Coursera/UCI HAR Dataset")
#user must ensure the working directory is the "UCI HAR Dataset"
list.files()

#store the column headers from //features.txt
features_head <- readLines("features.txt")
#used to remove any white space or numbers in headers--deletes everything
#prior to the first text character
features_head <- gsub("^\\P{L}*", "", features_head, perl = TRUE)

#go into the test folder
setwd("./test")

### we are going to create 3 df and then merge at the end ###

# 1. Subject data
df_sub <- read.table("subject_test.txt")
#df_sub <- read.table(file.choose())

#Go ahead and add the column header
names(df_sub) <- "Subject"

# 2. activity data
df_act <- read.table("y_test.txt")
names(df_act) <- "Activity_Label"

#3. the feature data
df_fea <- read.table("x_test.txt")
#use the header titles from "features.txt"
names(df_fea) <- features_head

#combine all three df into one -- appending by columns (later we will append by rows)
df_new <- cbind(df_sub, df_act, df_fea)

#have to go back to the base directory to get the training data
setwd("..") #directs up one file
#go into the test folder
setwd("./train")

### we are going to create 3 df and then merge at the end ###

# 1. Subject data
df_sub_train <- read.table("subject_train.txt")
#Go ahead and add the column header
names(df_sub_train) <- "Subject"

# 2. activity data
df_act_train <- read.table("y_train.txt")
names(df_act_train) <- "Activity_Label"

#3. the feature data
df_fea_train <- read.table("x_train.txt")
#use the header titles from "features.txt"
names(df_fea_train) <- features_head

#combine all three df into one -- appending by columns (later we will append by rows)
df_new_train <- cbind(df_sub_train, df_act_train, df_fea_train)

#combine test and training df together into one dataframe
df_combine <- rbind(df_new,df_new_train)
setwd("..")

##### PART 2 #####

#keep only columns with mean() and std() -- don't forget to include the first two columns
df2 <- df_combine[ ,grepl("Subject|Activity_Label|mean()|std()", names(df_combine))]

##### PART 3 #####
#first make an index (or key) dataframe to use
activity_df <- read.table("activity_labels.txt")
names(activity_df) <- c("Number", "Activity")

#lets replace the values in our working dataframe ("df2)
df2$Activity_Label <- activity_df$Activity[match(df2$Activity_Label,
                                               activity_df$Number)]

##### Part 4 #####
#I completed part 4 when I imported the data -- oops!!

##### Part 5 #####
#this is the final dataframe -- aggreated with means
#Combined mean across all activities
#df_final <- aggregate(.~Subject, df2[,-2], mean)
#OR mean of subset in each activity
df_final2 <- aggregate(.~Subject+Activity_Label, df2, mean)

##### Saving final product #####
write.csv (df_final2, file = "foo.csv")

##### in order to read csv #####
tidy_df <- read.csv("foo.csv", row.names = 1)
