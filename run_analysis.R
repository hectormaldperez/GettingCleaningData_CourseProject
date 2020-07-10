# GettingCleaningData_CourseProject

#Load the following packages: 
library(downloader)
library(dplyr)
library(tidyr)

####1#####
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download(fileUrl, dest="Getting_CleaningData/W4_courseProject/dataset.zip", mode="wb") 
unzip ("Getting_CleaningData/W4_courseProject/dataset.zip", exdir = "./")
unlink(fileUrl)

#attributes
df1<-read.table("UCI HAR Dataset/train/X_train.txt", header=F)
df2<-read.table("UCI HAR Dataset/test/X_test.txt", header=F)

#lables for activity 
df1$activity<-as.numeric(readLines("UCI HAR Dataset/train/y_train.txt"))
df2$activity<-as.numeric(readLines("UCI HAR Dataset/test/y_test.txt"))

#labels for volunteer ID 
df1$subject<-as.numeric(readLines("UCI HAR Dataset/train/subject_train.txt"))
df2$subject<-as.numeric(readLines("UCI HAR Dataset/test/subject_test.txt"))

merged<-merge(df1,df2, all=TRUE)

####2####
mergedData1<-gather(merged, factor_key=TRUE)%>% group_by(key) %>%
  filter((key!="activity") & (key!="subject"))%>%
 summarise(mean= mean(value), sd= sd(value)) 

####3####
merged<-merged%>%
mutate(activity=factor(activity, labels=c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))

####4####
names<-(readLines("UCI HAR Dataset/features.txt"))
names<-append(names,c("activity","subject"), after = length(names))
features<- make.unique(sub("^[0-9.*]+ ", "", names), sep="&") # gsub would repeat over as many existing iterations 
#unique(features)
#duplicated(features)
temp<-gsub("Acc","acceleration_", features)
temp<-gsub("Gyro","gyroscope_", temp)    
temp<-sub("^t","time_", temp)             
temp<-sub("^f","frequency_", temp)  
temp<-gsub("Mag","_magnitude", temp)  
temp<-gsub("BodyBody","body_", temp)  
temp<-gsub("_Body","_body_", temp)  
temp<-gsub("tBody","time_body_", temp)
temp<-gsub("std","sd", temp)
temp<-gsub("bandsenergy","bandsEnergy", temp)
temp<-gsub("maxinds","maxInds()", temp)
#temp<-gsub("[()][0-9]","()", temp)
temp<-gsub('[&][1]$','_y', temp)
temp<-gsub('[&][2]$','_z', temp)
temp<-gsub("-","_", temp)  
temp<-gsub("__","_", temp)  
temp<-tolower(temp)
temp 
names(merged)<-temp
names(merged)

####5####
final<-merged%>%gather(varible, value,-activity,-subject)%>% group_by(activity,subject)%>% summarise(mean=mean(value)) #its summarise not summarize 
write.table(final, "tidy_ucr_data.txt", row.name=FALSE)
#in plyr it was summarize, in dplyr its summarise 





