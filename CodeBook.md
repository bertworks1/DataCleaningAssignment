### Data Source and Description

The source data for this project was downloaded from this URL:  
&nbsp;&nbsp;&nbsp;<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The data was originally compiled as part of a study by Jorge L. Reyes-Ortiz, et al, documented in this paper:  
&nbsp;&nbsp;&nbsp;*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.*   
&nbsp;&nbsp;&nbsp;*Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.*   
&nbsp;&nbsp;&nbsp;*International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.*   

The original data set was comprised of 561 motion data features derived from linear acceleration and angular velocity measurements (along with the raw inertial data). The measurements were taken from 3-axis smartphone acclerometers and rate gyros. The study comprised 30 test subjects, each performing 6 movement activities (lying, sitting, standing, walking, going up and down stairs). Multiple data points were collected for each subject in each activity, resulting in a total of 10299 data points, which were split into training and test sets. The subject ID and activity for each data point were stored in separate files. For additional details, see the files included in the source zip file (especially *README.txt* and *features_info.txt*).


### Subset of Relevant Data

This project required only the features representing the mean and standard deviation data for each data point. These were identified based on the feature names used in the source data. In particular, feature names containing the text strings "mean()", "std()", or "meanFreq()" were deemed relevant and the associated data was extracted for processing. This resulted in a reduced feature set containing 79 of the original 561 features. Data from both the training and test sets was extracted and combined in the output data. The raw inertial data in the original data set (in sub-directories named "Inertial Signals") was not processed since it does not represent mean or standard deviation data. 


### Interpretation of Column Names

The requirements for this project did not specify that the column names should conform to any particular standards. Therefore, the column names were chosen to be similar to the feature names in the original data set, with minor changes to make them more "R-friendly". (In particular, parenthesis were eliminated and dashes were replaced by periods.) Readability in column names was sacrificed somewhat in the interest of conciseness. However, the names all conform to a pattern which can be readily decyphered. The names are derived by combining one option from each bracketed set shown below. Where curly brackets are shown, either the component within the first curly brackets or the component in the second curly brackets is used, but not both in the same name.

&nbsp;&nbsp;&nbsp;[*t, f*][*Body, Gravity*][*Acc, AccJerk, Gyro, GyroJerk*]{*Mag*}.[*mean, meanFreq, std*]{.[*X, Y, Z*]}

The first component indicates whether the data is time-based (t) or frequency-based (f). The second component indicates whether the component is attributed to body motion or gravity. The third component indicates the source of the data: accelerometer (Acc), rate gyro (Gyro), or the corresponding time-derivatives (AccJerk and GyroJerk). The fourth component (optional) indicates that the data is a 3D magnitude, as opposed to a single-axis value. The fifth component indicates the type of data: mean, mean frequency, or standard deviation. The sixth component (optional) indicates the axis for single-axis data.

For example, the name "*tBodyAcc.mean.Z*" would translate to "*the mean of time-based body acceleration along the Z axis*."

In addition to the 79 feature columns named as described above, there are two columns representing the subjects and activities, named "subject" and "activity". Subjects are identified only by an integer ID, ranging from 1 to 30. 

One additional note: Although the data in the summary output (see below) represents average values (rather than point-wise values) for each parameter for each subject and activity, the column names used in the summary output are the same as in the extracted output. No additional modifier (such as "mean" or "average") was used, again in the interest of conciseness. 


### Output/Result Files

Two output files are written in csv format, with commas for separators, periods for decimal points, and CRLF ('\r\n') for end-of-line indicators. The first file ("*extracted_data.csv*") contains the tidied data extracted from the source data. It contains the 79 extracted features -- plus the subject ID and activity -- for each of the 10299 data points in the combined test and training sets. The second file ("*summary_data.csv*") contains the same data averaged by subject and activity. It contains the mean of each of the 79 features (variables) for each permutation of subject and activity (30 x 6 = 180 permutations). 
