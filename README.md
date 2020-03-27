# Overview
This project includes the files for the Programming assignment week 4 with the purpose of reshaping data of measurements for features of accelerometrs collected by 30 test persons. The objective was to prepare a tidy data set of the measurment including the average of all mean and standard deviation for each feature.

## Study
The data is part of a study on how the movement of acceleormeters placed on the human body can be measured. 
The source data for this project is stored in the UCI Machine learning repository and has been collected by 

1. Smartlab - Non-Linear Complex Systems Laboratory DITEN - Università degli Studi di Genova, Genoa (I-16145), Italy.

1. CETpD - Technical Research Centre for Dependency Care and Autonomous Living Universitat Politècnica de Catalunya (BarcelonaTech). Vilanova i la Geltrú (08800), Spain

According to the UCI Machine learning repository this is the information about the project.

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## Files included in the project
1. Readme.md - This file

1. Codebook.md - Explanation of the code and the variables used to reshape the data

1. run_analysis.R - The R code used to to reshape and prepare the tidy data set

1. data_tidy.txt - The final tidy data set with average of mean and standard deviation grouped by subject (test person), activity and feature.

