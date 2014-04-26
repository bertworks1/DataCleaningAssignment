## Repository Contents

This repository includes three files:

* This README.md file, which explains the contents of the repository and instructs how to use the script file.
* The run_analysis.R file, which contains the script used for processing and cleaning the source data.
* The CodeBook.md file, which contains descriptions of the data.

## Running the Script 

The script may executed using the source("run_analysis.R") command from the R console.

The script makes use of the R data.table package, so that package must be loaded before running the script.

The data processed by the script was obtained from 
  <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
The script assumes that this file has already been downloaded and all files extracted into a local copy of the directory tree defined in the .zip file; i.e., into a directory tree with top directory "UCI HAR Dataset" and sub-directories "test" and "train". In order to run the script, the R working directory must be set to the parent directory of "UCI HAR Dataset" (i.e., one level up from "UCI HAR Dataset").

The script will write two csv-formatted files to the working directory: 
* "extracted_data.csv" contains the data initially extracted from the source data files and combined into a tidy table. 
* "summary_data.csv" contains the mean of each variable in the first file, grouped by subject and activity. 
These files use commas for separators, periods for decimal points, and CRLF ('\r\n') for end-of-line indicators. See CodeBook.md for descriptions of the data. 

See the comments in run_analysis.R for additional details. 