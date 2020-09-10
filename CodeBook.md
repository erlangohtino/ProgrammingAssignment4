---
title: "CodeBook of tidy dataset from Assignment 4 - Getting and Cleaning Data Course"
author: "Emilio González"
date: "10/9/2020"
output: html_document
---

This dataset is obtained from the work by Reyes et al [1] on Human Activity Recognition Using Smartphones.

In that work, a set of experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity has been captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. **In the tidy dataset, both train and test datasets are included together**

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

For each record it is provided:

- An identifier of the subject who carried out the experiment.
- Its activity label. 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 67-feature vector with mean and standard deviation of the time and frequency domain variables. 

Notes: 

- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

## Variable details:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tbodyaccmeter-xyz and tgravityaccmeter-xyz) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tbodyaccmeterjerk-xyz and tbodygyrojerk-xyz). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tbodyaccmetermag, tgravityaccmetermag, tbodyaccmeterjerkmag, tbodygyromag, tbodygyrojerkmag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fbodyaccmeter-xyz, fbodyaccmeterjerk-xyz, fbodygyro-xyz, fbodyaccmeterjerkmag, fbodygyromag, fbodygyrojerkmag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern: '-xyz' is used to denote 3-axial signals in the X, Y and Z directions. 

- tbodyaccmeter-xyz
- tgravityaccmeter-xyz
- tbodyaccmeterJerk-xyz
- tbodygyro-xyz
- tbodygyrojerk-xyz
- tbodyaccmetermag
- tgravityaccmeterMag
- tbodyaccmeterjerkmag
- tbodygyromag
- tbodygyrojerkmag
- fbodyaccmeter-XYZ
- fbodyaccmeterJerk-xyz
- fbodygyro-xyz
- fbodyaccmetermag
- fbodyaccmeterJerkmag
- fbodygyromag
- fbodygyrojerkmag

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation

All these values are referred to two index variables:

- subject: Id. of the person carrying out the activity: 1:30.
- activity: description of the activity: {WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING}

## Construction of the dataset from original files:

The tidy dataset was built binding the subject, measurement vector and activity label rows from original files subject_set.txt, X_set.txt and y_set.txt respectively, where set is both 'test' and 'train', and then making some cleaning arrangements, namely:

- Labelling the temporal output with the name of the original features, plus 'subject', 'activity' and 'dataset'.
- Getting only the mean() and std() records from the original dataset
- Replacing the activity values (1:6) with descriptive names ('WALKING','SITTING', etc)
- Tidying up some variable names: replacing 'Acc' by 'Accmeter' (accelerometer) -because 'Acc' is not descriptive enough-, and lowering the case of all variable names.

## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012