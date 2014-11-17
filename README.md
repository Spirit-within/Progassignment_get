Progassignment_get
==================
repo for coursera's "getting and reading data" course project.
==================

The repo contains the following files:

- 'run_analysis.R' : Script to create a tidy dataset file from the Samsung data unzipped in working directory
- 'CodeBook.md' : Description of variables in the output file of 'run_analysis.R' (tidy_dataset.txt)
- 'README.md'

Script:
+ It is assumed for running this script that data was already downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

+ It is also assumed that the folder was unzipped in the working directory without modification to folders and subfolders' names:
==> example: path for features.txt is "/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt"

+ The script assigns a path to the needed files and read them into R using read.table.
+ The read files are:
    - features.txt          =>  features
    - activity_labels.txt   =>  activity_labels

    - y_train.txt           =>  train_labels
    - X_train.txt           =>  train_set                     
    - subject_train.txt     =>  train_subject

    - y_test.txt            =>  test_labels
    - X_test.txt            =>  test_set
    - subject_test.txt      =>  test_subject

+ while reading X_train.txt and X_test.txt, the script sets the names of the columns for belonging r variables from 'features'
+ data is then combined using following scheme:

 ![Merging Test and Train data](https://github.com/Spirit-within/Progassignment_get/blob/RUN_ANALYSIS/Merge_scheme.png)

+ from the dataset above, a subset is created, taking only variables that are a mean or a standard deviation
+ Activity column values are replaced with names 
+ The tidy dataset is then created using aggregare function.

