The project focuses on gathering, combining, cleaning and generating a tidy set. These are the following files that are used:
1. run_analysis.R: This R script is doing all the data gathering, cleaning and extracting a neat, tidy dataset which can be used for analysis
2. tidy_data.txt: This is the extracted clean data file after running the R codes
3. There is also a tidy_data.csv which is the same clean dataset but in a csv format

The script first downloads the data via a given url. This comes in the form of a zip file. The files are unzipped and loaded, all done within the R script. 
The train and test datasets are combined into a single dataset. From there, the measurements are extracted and the mean and standard deviation is each measurement is generated.
Next, we label the variables with descriptive names so that the variables are understandable. 
A dataset is created which has the average of each variable (for each activity and subject), which is then extracted as tidy_data.txt

P.S: Please ignore the HelloWorld.md which is there in the repo. That was uploaded as part of another course within this Specialization.
