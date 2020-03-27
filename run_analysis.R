
library(dplyr)
library(reshape2)
library(gdata)

# read feature table and clean feature names
feature_names <- read.table('./UCI HAR Dataset/features.txt') %>%
  select(2)%>% # select only second column which includes the feature name
  mutate(V2 = sub('^t|^f',"",V2))%>% # remove t and f letters in the beginning of the feature name
  mutate(V2 = gsub('\\(|)',"",V2)) # remove () from the feature names

# count the number of meatures
features_count <- nrow(feature_names)

# read feature measurement, activities and subject for both test and train data
test_feature <- read.fwf('./UCI HAR Dataset/test/X_test.txt',
                         widths=rep(16,features_count),
                         col.names = feature_names$V2)
test_activity <- read.table('./UCI HAR Dataset/test/y_test.txt',col.names = 'activity')
test_subject <- read.table('./UCI HAR Dataset/test/subject_test.txt',col.names = 'subject')

train_feature <- read.fwf('./UCI HAR Dataset/train/X_train.txt',
                          widths=rep(16,features_count),
                          col.names = feature_names$V2)
train_activity <- read.table('./UCI HAR Dataset/train/y_train.txt',col.names = 'activity')
train_subject <- read.table('./UCI HAR Dataset/train/subject_train.txt',col.names = 'subject')

# select columns that include the mean and standard deviation based in name of the feature
test_feature_select <- select(test_feature,grep('(mean)$|(mean\\.)|(std)$|(std\\.)',names(test_feature),value=TRUE))
train_feature_select <- select(train_feature,grep('(mean)$|(mean\\.)|(std)$|(std\\.)',names(train_feature),value=TRUE))

# merge the columns for subject, activity and feature measure for test and train data respectively
test_merged <- cbind(test_subject, test_activity, test_feature_select)
train_merged <- cbind(train_subject, train_activity, train_feature_select)

# merge the rows for test and train data
data_merged <- rbind(test_merged,train_merged)

# Prepare tidy data
data_tidy <- data_merged %>%
  group_by(activity,subject) %>% # group data by activity and subject
  summarise_all(mean) %>% # summarize all columns and return the mean
  melt(id=c('activity','subject')) %>% # regroup measures from columns to be elements of a single variable column
  mutate(variable_short = regmatches(variable, regexpr('(mean)|(std)', variable))) %>% # create new column to identify if element is mean or standard deviation
  mutate(variable = gsub('(.mean)|(.std)',"",variable)) %>% # remove .mean and .sub from the description of the measures
  dcast(activity + subject + variable ~ variable_short) # regroup elements to show average of mean and standard deviation on the same line for each measure

# rename column names for the variable, mean and std variables
colnames(data_tidy)[3:5] <- c('feature','mean-average','std-average')

# export the tidy data to a text file
write.fwf(data_tidy,'./data_tidy.txt')
