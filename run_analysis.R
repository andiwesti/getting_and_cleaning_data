
library(dplyr)
library(reshape2)
library(gdata)

feature_names <- read.table('./UCI HAR Dataset/features.txt') %>%
  select(2)%>%
  mutate(V2 = sub('^t|^f',"",V2))%>%
  mutate(V2 = gsub('\\(|)',"",V2))

features_count <- nrow(feature_names)

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

test_feature_select <- select(test_feature,grep('(mean)$|(mean\\.)|(std)$|(std\\.)',names(test_feature),value=TRUE))
train_feature_select <- select(train_feature,grep('(mean)$|(mean\\.)|(std)$|(std\\.)',names(train_feature),value=TRUE))

test_merged <- cbind(test_subject, test_activity, test_feature_select)
train_merged <- cbind(train_subject, train_activity, train_feature_select)

data_merged <- rbind(test_merged,train_merged)


data_tidy <- data_merged %>%
  group_by(activity,subject) %>%
  summarise_all(mean) %>%
  melt(id=c('activity','subject')) %>%
  mutate(variable_short = regmatches(variable, regexpr('(mean)|(std)', variable))) %>%
  mutate(variable = gsub('(.mean)|(.std)',"",variable)) %>%
  dcast(activity + subject + variable ~ variable_short) %>%
  print

write.fwf(data_tidy,'./data_tidy.txt')
