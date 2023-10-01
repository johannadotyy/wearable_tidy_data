# wearable_tidy_data
repo contains raw data, code book, script to tidy data, tidy data for Getting and Cleaning data course

Information about the data and variables can be found ing CodeBook.Rmd

The run_analysis.R script does the following:
1. Loads all the test and train data (6 separate data tables)
2. Extracts only feature variables related to mean/standard deviation
        + Also provides names to all variables in data tables
3. Combines the test and train data into a single data table
4. Creates a new data table containing the average of each variable for each combination of subject and activity
