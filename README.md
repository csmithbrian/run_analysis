# run_analysis
An R script to download data on a Samsung accelerometer study and produce rudimentary analysis.
To use, download script and place in your working directory, then source in R using "source("run_analysis.R")".
Script will install and load all packages needed to run (consisting of dplyr and reshape2).
Tidy dataset of averages of each measure by Subject and activity will be placed into dataframe titled "tidyset" as well as written to a txt file in your working directory called "tidyset.txt".
Full extracted data will be placed in datafram titled "extracted_data".
