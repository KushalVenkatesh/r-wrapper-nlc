library(jsonlite)
source('scripts/r_wrapper_nlc.R')

# Set up the credentials of NLC
setCredentials("<USERNAME>", "<PASSWORD>")

# Train the NLC using a CVS file.
result <- createClassifier('dataset/weather_data_train.csv',
                           'en','Weather Example')
classifiers <- as.data.frame(fromJSON(listClassifiers()))
status_classifier <- fromJSON(
  statusClassifier(classifiers[6,1]))

# Check the status of classifier
status_classifier$status

# Using the classifier
classify(status_classifier$classifier_id, "Is it cold outside?")
result <- fromJSON(classify(status_classifier$classifier_id, "Is it cold outside?"))
