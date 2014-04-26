# (This script requires the data.table package.)

# This script assumes that the relevant data files have been 
# extracted (unzipped) into a directory tree with top directory 
# "UCI HAR Dataset" and sub-directories "test" and "train". 
# Furthermore, the working directory is assumed to be the 
# parent directory of "UCI HAR Dataset".

base         = "UCI HAR Dataset"
feature_file = file.path(base, "features.txt")
label_file   = file.path(base, "activity_labels.txt")
X_train      = file.path(base, "train", "X_train.txt")
X_test       = file.path(base, "test",  "X_test.txt")
subj_train   = file.path(base, "train", "subject_train.txt")
subj_test    = file.path(base, "test",  "subject_test.txt")
y_train      = file.path(base, "train", "y_train.txt")
y_test       = file.path(base, "test",  "y_test.txt")

# This script cleans the data by extracting and combining the 
# required data, and relabeling columns and data where needed to 
# enhance readability. The training and test data are merged.
# Note that the data is extracted first (before merging) in 
# order to reduce the amount of memory required. In fact, the
# extraction is incorporated into the read process.

# First, identify the columns of the measurement data (in
# files "X_test.txt" and "X_train.txt") that should be read  
# by identifying the column names (from file "features.txt")
# that contain "mean()", "std()", or "meanFreq()". [The 
# requirements were not entirely clear as to what data is 
# needed, only that mean and std data should be kept. It is 
# assumed here that mean data includes mean frequency data 
# as well as component (X, Y, Z) data.]
# The requirements do not specify that the column headers 
# should conform to tidy data standards, so that is not
# done here. However, the column names from the original 
# data set will be modified by eliminating parenthesis and
# changing dashes to periods to provide better accessibility.
# Also, the names with "BodyBody" were corrected.

features = read.table(feature_file, colClasses=c("NULL", "character"))
                      
columnNames = gsub("()", "", 
              gsub("BodyBody", "Body", 
              gsub("-",".",features[,])), fixed=TRUE)
                      
keepText = "mean\\(\\)|std\\(\\)|meanFreq\\(\\)"

columnStatus = ifelse(grepl(keepText, features[,]), "numeric", "NULL")

measurements = rbindlist(list(
    read.table(X_train, col.names=columnNames, colClasses=columnStatus),
    read.table(X_test,  col.names=columnNames, colClasses=columnStatus)))
    
# Read the subject data.

subjects = rbindlist(list(read.table(subj_train), read.table(subj_test)))
    
setnames(subjects, 1, "subject")
    
# Read the activity data, then replace the numeric codes with
# text labels based on the mapping in file "activity_labels.txt".

labels = read.table(label_file, colClass=c("NULL", "character"))

activities = rbindlist(list(read.table(y_train), read.table(y_test)))
    
setnames(activities, 1, "activity")

activities$activity = labels[activities$activity,]

# Combine all the data components into one data table. 
# Create another table with just the means of each variable 
# by subject and activity. Write both tables to csv files. 

all = cbind(subjects, activities, measurements)

write.csv(all, "extracted_data.csv", quote=FALSE, row.names=FALSE)

means = aggregate(subset(all, select=3:ncol(all)), 
                  by=list(subject=all$subject, activity=all$activity), mean)
                  
write.csv(means, "summary_data.csv", quote=FALSE, row.names=FALSE)



