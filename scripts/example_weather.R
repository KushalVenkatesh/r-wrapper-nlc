#
# The goal of this script is demonstrate the use of r-wrapper-nlc
# with the weather dataset from NLC example 
# (https://www.ibm.com/smarterplanet/us/en/ibmwatson/developercloud/doc/nl-classifier/get_start.shtml)
# 
#

library(xlsx)
library(jsonlite)
library(caret)
source('scripts/r_wrapper_nlc.R')
source('scripts/model_evaluation.R')

language <- 'en'
directory <- 'weather'

#
# Pre-processing: cleaning and filtering data.
#

dataset <- read.csv('dataset/weather_data_train.csv', header = FALSE)
names(dataset) <- c('text','class')
sapply(dataset, class)
dataset$text <- as.character(dataset$text)

#
# Set up the credentials of NLC and cleaning the NLC instance
#

setCredentials("3b651ba2-026d-4312-9b0b-6932dd50e6cd", "cwZgnJIkdhPb")
classifiers <- as.data.frame(fromJSON(listClassifiers()))
deleteAllClassifiers(classifiers$classifiers.classifier_id)

#
# 5 Fold Cross Validation
# Each fold is created considering the class distributions
#

set.seed(1234)
x <- createFolds(dataset$class, k = 5, list = FALSE)

# Creating 5 classifiers and 5 test sets
for (i in 1:5){
  train <- dataset[x != i, ]
  file_name <- paste("train",i,".csv",sep="")
  write.csv(train, file = paste("dataset",directory,file_name, sep="/"), row.names = FALSE)
  createClassifier(paste("dataset",directory,file_name, sep="/"),
                   language,
                   paste('Train',i,'-',language,sep=""))  
}

#
# Get the status from all classifiers 
# We only can test models when classifier's status is equal to available
#
classifiers <- as.data.frame(fromJSON(listClassifiers()))
for(i in 1:5){
  status_classifier <- fromJSON(
    statusClassifier(
      classifiers[classifiers$classifiers.name == paste('Train',i,'-',language,sep=""),1]))
  print(status_classifier$status)  
}


# Testing classifiers
results <- NULL
accr <- rep(0,5)
for(i in 1:5){
  result <- test(classifiers[classifiers$classifiers.name == paste('Train',i,'-',language,sep=""),1], 
                 dataset[x == i, ])
  accr[i] <- sum(result$realClass == result$predicted) / nrow(result)
  results <- rbind(results, result)
}
rm(result)

# Calculating average accuracy and standard deviation 
accr_mean <- mean(accr)
accr_sd <- sd(accr)

#
# Creating some plots
#

results$realClass <- as.factor(results$realClass)
results$predicted <- as.factor(results$predicted)
results$confidence <- as.numeric(results$confidence)
results$answer <- as.factor(
  ifelse(results$realClass == results$predicted, "hit", "miss"))

barplot(sort(table(dataset$class)),
        main="Class distribution in dataset",
        xlab="Unique class ID",
        ylab="Number of question-answer pairs",
        col="blue")

par(mfrow=c(2,1))
hist(results[results$answer == 'hit',c('confidence')],
     xlim=c(0,1), col='green', breaks = 100,
     main="Hits - Confidence", xlab="Confidence")
hist(results[results$answer == 'miss',c('confidence')],
     xlim=c(0,1), col='red', breaks = 100,
     main="Misses - Confidence", xlab="Confidence")

par(mfrow=c(1,1))
boxplot(results$confidence ~ results$answer, 
        col="cyan", main="Confidence versus accuracy",
        ylab="Confidence", xlab="Accura")

plot(results$realClass, results$answer, col=c('green','red'),
     xlab="Classes", ylab="Accuracy", 
     main="Accuracy per class")
