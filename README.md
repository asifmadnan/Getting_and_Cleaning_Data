# Getting and Cleaning Data - Course Project

Getting and Cleaning Data Coursera Final Assignment.
Before analysing the data, I've downloaded the necessary data set.
The data should be downloaded in the `.\data` sub-directory under the working directory.

The R script, `run_analysis.R`, does the following:
 
1. Load the activity and feature information.
3. Loads both the training and test datasets, keeping only those columns which
   represent the target attributes (mean or standard deviation).
4. Loads the activity and subject data for each dataset, and merges those
   columns with the dataset (train and test).
5. Merges the two datasets (train and test).
6. Converts the `activity` and `subject` columns into factors.
7. Creates a tidy dataset that consists of the average (mean) value of each
   target variable for each subject and activity pair.

The end result is saved in the file `tidy.txt`.

Original Data source

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Article about the data source and its related applications

http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
