0. Download the files and unzip

1. Read data and Merge

Gather information from the downloaded files

activity_labels : Description of activity IDs
features : description(label) of variables 

Combine data into test and train sets then combine into a single table

subject_test : subject IDs for test
X_test : values of variables in test
y_test : activity ID in test

subject_train : subject IDs for train
X_train : values of variables in train
y_train : activity ID in train

combined_subjects: bind of subject_test and subject_train
combined_x: bind of X_train and X_test
combined_y: bind of y_train and y_test

combined_data : bind of combined_subjects, combined_y, combined_x

2. Extract only mean() and std()
Create a vector of only mean and std labels, then use the vector to subset dataSet.

included_features : a vector of only mean and std labels extracted from 2nd column of features

At the end of this step, combined_data will only contain mean and std variables

3. Changing Column label of dataSet
Update the activity names

4. Adding Subject and Activity to the dataSet
update the activity names into strings

clean_features: removes parentheses from labels

5. Rename ID to activity name
install 'reshape2' package

melt the data and output to tidy.txt
