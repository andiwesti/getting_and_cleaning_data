# Code book of final assignment

## Source files and their variables
features.txt - List of 561 measure consisting of all recorded features including statistical calculations for each feature. For the purpose of this assignment only the mean and standard deviation (std) for each feature are used. The last seven feature have been excluded even if they have the word Mean in them as they follow a separate pattern compared to the other features.

X_test.txt - Actual measurements of the features of the accelerometer for 30 subjects doing six types of physical activities. 
Size: 561 columns, 2947 rows 

y_test.txt - List of the activites related to the measurements in the X_test.txt file
Size: 1 column, 2947 rows

subject_test.txt - List of the subjects (persons) related to the measurements in the X_test.txt file
Size: 1 column, 2947 rows

The same three files as above also exist for the train data with 7352 rows each.

## Output file
data_tidy.txt - The final tidy data set with average of mean and standard deviation grouped by subject (test person), activity and feature.
Size: 5 columns, 5940 rows

## Coding convention
The R programming language is used for this project. The dplyr and reshape2 packages are used to reshape data.
Each step of the coding is carefully explained in the run_analys.R file and highlighted here below.

### 1. Read feature table and clean feature names
List of feature loaded from the features.txt file into a data frame. The features names are cleaned are stored as strings.

### 2. Read feature measurement, activities and subject for both test and train data
For both test and train data all data is loaded from the source files described above. All data is stored as numericals.

### 3. Select columns that include the mean and standard deviation based in name of the feature
The columns are reduced to include only those which have calculation for statistical mean and standard deviation (std).

### 4. Merging of data
The data is first merged column wise to include subject activiy and measures. After that the test and train data rows are combined to file which includes all data.

### 5. Prepare tidy data
A tidy data set is prepared with these steps with the help of piping with dplyr:
1. group data by activity and subject
1. summarize all columns and return the mean
1. regroup measures from columns to be elements of a single variable column
1. create new column to identify if element is mean or standard deviation
1. remove .mean and .sub from the description of the measures
1. regroup elements to show average of mean and standard deviation on the same line for each measure

## Variables in the output file data_tidy.txt
Finally the three last column names are renamed to be more descriptive. The final variables are:
activity
1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

subject
Number 1-30 for respective test person

feature 
Name of the feature recored by the accelerometer

mean-average
Average of the means grouped by activity, subject and feature. No scaling is used for the numbers.

std-average
Average of the standard deviations grouped by activity, subject and feature. No scaling is used for the numbers.

