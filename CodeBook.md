# Getting and Cleaning Data Course Project

- Explains the overall structure of the dataset as well as contains a description of the measured variables and transformations of data performed by item #2 in this list. 

The data set is the Human Activity Recognition Using Smartphones Data Set from UCI's Machine Learning Repository. The data contains a total of 10299 observations for 561 measured varibles stratified into train (30%, N=2947) and test subsets (70%, N=7352). The 561 measured variables, are named features in this data set. The data on features comes from the accelerometer and gyroscope 3-axial raw signals captured at constant frequency (f=50Hz) over time (t). The accelration data was then stratified into body and gravity acceration signals. Importantly, '-x,-y,-z' are used to denote the dimension for which the feature was measured. 

For both train and test subsets, there are three additional text files used for genrating a tidy data set. The first contains label names for all the measured variables in the dataset (features.txt), the second contains the labels for subject (N=1-30) each observation in the train and test data sets belongs to, and lastly, a text file with the labels for which activity level (1-6: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).

The run_analysis.R file contains items numbered 1-5 which do the following:

**1.** Merges the train and test subsets into 1 merged data set 

- Uses the fileUrl to collect the zip filed data, downloads the zipfile and then unzips the file. 
- Adds activity and subject labels to each of the train and test subsets.
- Merges the train and test subsets into a single merged file, "mergedData"

**2.** Summarizes the merged data set from item #1, providing the mean and standard deviation for each of the 561 features measured 

- Gathers the data and groups by key to yield the mean and standard deviation for each one of the features measured.

**3.** Combines the merged data set an the metadata on subject and activity labels

- The row entries for the activity columnare relabeled with the string assigned to each number 1-6 which represents the type of actiity each subject was performing when the data was collected.  

**4.** Renames the labels for each of the 561 features

- A number of variable tranformations were performed in order to ensure that: 1) each column header had a unique name, 2) each row entry was a unique observation, 3) that only one value is found in each row for each column. 
- Additionally, for consitency, all of the letters were made to be lower case and x,y,z labels were added to the end of some of the names in the feature.txt file. 

**5.** Creating an independent tidy data set for each activity and subject

- Summarises a set of 561 varibles from the Human Activity Recognition Using Smartphones Data Set sorted by activity and subject varibles. Average feature values were reported for each feature sorted by activity and subject. 

