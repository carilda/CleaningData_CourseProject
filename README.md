# CleaningData_CourseProject
Course project for Getting and Cleaning Data class

## The data

Data from the project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The file was unzipped,
renamed without spaces and moved into the github project directory.

## The process

### Creating the data sets from the .txt files
Make tables for train and test by reading in the relevant .txt files: 
- tx/X_tx.txt
- tx/y_tx.txt
- tx/subject_tx.txt
where "tx" is to be replaced by either "train" or "test" for each of the three .txt files.

These files are passed into a function, make_ds, along with a list of the
desired columns (means and std devs only), and a data frame is returned.

### Make a single data set and make nice column names
The two data frames, train and test are merged into one and assigned column
names with a bit of the cruft in the names removed. Merge in the names of
the activities and remove the numerical activity column

### Create the final tidy data set and write out to file
Using the existing data frame, take the mean of each column grouped by 
activity name and subject to create the tidy_data data frame.  Write
it out to disk using write.table

