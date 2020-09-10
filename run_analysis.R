## Assignment 4 - Getting and Cleaning Data Course

## C) Emilio Gonzalez, September 2020.

## The goal of this script is to prepare tidy data from a wearable devices 
## dataset, that can be used for later analysis.
## Please read CodeBook.md for a description of the tidy dataset.

library(stringr)
library(dplyr)

## Get data from the Internet (if not already done)
if (!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("./data/wearabledata.zip")){
    print("Downloading zip")
    download.file(fileUrl,"./data/wearabledata.zip",method="curl")
}
print("Unzipping data")
unzip("./data/wearabledata.zip",exdir="./data")

# store feature variable names and activity names for later use
features<-read.table("./data/UCI HAR Dataset/features.txt")
activities<-read.table("./data/UCI HAR Dataset/activity_labels.txt")

## 1. Merge the training and the test sets to create one data set.
print("Creating test dataset")
tmptesttotal<- NULL

# Read sequentially subject, X and y files and insert both data columns and
# labels into temporal table, for 'Test' dataset.
for (file in list.files("./data/UCI HAR Dataset/test")[2:4]){

    tmpname<-sub("_test.txt","",file)
    file<-paste("./data/UCI HAR Dataset/test/",file,sep="")
    tmptest<-read.table(file)

    if(is.null(tmptesttotal)){
        tmptesttotal<-tmptest
        tmpnames<-tmpname
    }else if(tmpname=="X"){
        tmptesttotal<-cbind(tmptesttotal,tmptest)
        tmpnames<-append(tmpnames,features[,2])
    }else{
        tmptesttotal<-cbind(tmptesttotal,tmptest)
        tmpnames<-append(tmpnames,"activity")
    }
}
# Finally, insert type of dataset ("Test")
tmptesttotal<-cbind(tmptesttotal,"Test")
tmpnames<-append(tmpnames,"dataset")

print("Creating train dataset")
tmptraintotal<-NULL
# Read sequentially subject, X and y files and insert both data columns and
# labels into temporal table, for 'Train' dataset.
for (file in list.files("./data/UCI HAR Dataset/train")[2:4]){
    
    tmpname<-sub("_train.txt","",file)
    file<-paste("./data/UCI HAR Dataset/train/",file,sep="")
    tmptrain<-read.table(file)
    
    if(is.null(tmptraintotal)){
        tmptraintotal<-tmptrain
        tmpnames<-tmpname
    }else if(tmpname=="X"){
        tmptraintotal<-cbind(tmptraintotal,tmptrain)
        tmpnames<-append(tmpnames,features[,2])
    }else{
        tmptraintotal<-cbind(tmptraintotal,tmptrain)
        tmpnames<-append(tmpnames,"activity")
    }
}
# Finally, insert type of dataset, this time "Train"
tmptraintotal<-cbind(tmptraintotal,"Train")
tmpnames<-append(tmpnames,"dataset")

# Now this appropriately labels the temporal data set
# with descriptive variable names.
names(tmptesttotal)<-tmpnames
names(tmptraintotal)<-tmpnames

print("Appending both datasets")
tmptotal<-rbind(tmptraintotal,tmptesttotal)

## 2. Extract only the measurements on the mean and standard deviation for each 
##    measurement.
print("Selecting subset")
total<-select(tmptotal,subject,activity,dataset,
              contains("mean()")|contains("std()"))

## 3. Use descriptive activity names to name the activities in the data set
print("Tidying up dataset. Intermediate table displayed on screen.")
total<-mutate(total,activity=activities[activity,2])

## 4. Appropriately labels the data set with descriptive variable names.
# 'subject','activity' and 'dataset' already used. 
# In general, original variable names convention seems fine.
# Some improvements will be done:
# . 'Acc' will be substituted by 'Accmeter'
# . Lowercase will be forced
total <- rename_with(total,
                     ~ tolower(gsub("Acc", "Accmeter", .x, fixed = TRUE)))
View(total)

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
# This is to get a data frame with appropriate col labels and correct row size:
SummaryTotal<-select(total,-dataset)
SummaryTotal<-slice_head(SummaryTotal,n=30*6)

print("Creating tidy data set. Final table displayed on screen.")
print("If you want to print final table to a file you can use write.table")
print("Example: write.table(SummaryTotal,file='./data/SummaryTotal.txt',row.name=FALSE)")
# Now iterating to compute means per pair (subject,activity):
for (subject in 1:30){
    for (ilabel in 1:6){
        # Filter by activity and subject
        filtered<-filter(total,subject==subject & activity==activities[ilabel,2])
        # Numeric values are from column 4 of 'total' data frame onwards
        colmeans<-colMeans(filtered[4:length(names(filtered))])
        # A vector with subject, activity and computed means will be inserted
        # for each pair (subject,activity)
        SummaryTotal[(subject-1)*6+ilabel,] <-
            c(subject,activities[ilabel,2],colmeans)
    }
}
View(SummaryTotal)