# define path below working directory of general files
path_features <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",sep="")
path_activity_labels <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt",sep="")

# define path below working directory of train files
path_train_labels <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt",sep="")
path_train_set <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt",sep="")
path_train_subject <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt",sep="")

# define path below working directory of test files
path_test_labels <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt",sep="")
path_test_set <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt",sep="")
path_test_subject <- paste(getwd(),"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt",sep="")

#Read files
features <- read.table(path_features)
activity_labels <- read.table(path_activity_labels)

train_labels <- read.table(path_train_labels, 
                           colClasses="numeric", col.names="Activity")
train_set <- read.table(path_train_set, 
                        colClasses="numeric", col.names = features[,"V2"])
train_subject <- read.table(path_train_subject, 
                            colClasses="numeric", col.names="Subject")

test_labels <- read.table(path_test_labels, 
                          colClasses="numeric", col.names="Activity")
test_set <- read.table(path_test_set, 
                       colClasses="numeric", col.names = features[,"V2"])
test_subject <- read.table(path_test_subject, 
                           colClasses="numeric", col.names="Subject")



#bind activities and subjects to obsevations 
test <- cbind(test_subject,test_labels,test_set)
train <- cbind(train_subject,train_labels,train_set)

#bind train and test observetions (1)
dataset <- rbind(test,train)


#Select only mean and std measures (2)

dataset_select <- dataset[,c(grep("Activity",colnames(dataset)),
                             grep("Subject",colnames(dataset)),
                             grep("mean",colnames(dataset)),
                             grep("std",colnames(dataset)))]


#Replace IDs of Activities with names in dataset (3): 
dataset_select_n = merge(dataset_select, activity_labels,
                         by.x="Activity",
                         by.y="V1", sort=FALSE)
dataset_select_n[,"Activity"] <- NULL

#Rename column of activities' names (4)
colnames(dataset_select_n)[81] <- "Activity_name"
#Reorder columns
dataset_select_n <- dataset_select_n[c(1,81,2:80)]

##Create the tidy dataset (5)

fsub <- factor(dataset_select_n$Subject)
fact <- factor(dataset_select_n$Activity_name)
ds<-aggregate(x=dataset_select_n,by=list(fsub,fact),FUN = "mean")
ds[,"Activity_name"] <- NULL
ds[,"Subject"] <- NULL
#Renaming "Group1" and "Group2" columns
colnames(ds)[1] <- "Subject"
colnames(ds)[2] <- "Activity_name"

##Creating the files
#write.table(dataset_select_n,file="dataset.txt",row.name=FALSE)
#write.table(ds,file="tidy_dataset.txt",row.name=FALSE)





