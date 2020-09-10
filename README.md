---
title: "Assignment 4 - Getting and Cleaning Data Course"
author: "Emilio González"
date: "10/9/2020"
output: html_document
---


This is my resolution of Assignment 4 from the 'Getting and Cleaning Data Course' from the Johns Hopkins University.

A script named **run_analysis.R** is provided, which prepares tidy data from a wearable devices 
dataset, that can be used for later analysis. This script does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Usage

To use the script, first make sure that you download the script on your working directory.
I will assume this is **~/R/projects/ProgrammingAssignment4/**. To set it, type
```
setwd(~/R/projects/ProgrammingAssignment4/)
```

Once you have it loaded, source it:
```
source('~/R/projects/ProgrammingAssignment4/run_analysis.R')
```

The output, a data frame called **SummaryTotal**, is a tidy dataset with the means of the variables
recorded by 30 subjects doing 6 types of activities with a Samsung Galaxy S smartphone. The description of this tidy dataset is provided in document **CodeBook.md**


A full description of the experiment is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Enjoy the review!