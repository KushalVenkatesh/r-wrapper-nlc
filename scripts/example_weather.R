#
# The goal of this is demonstrate the use of r-wrapper-nlc 
# 
#


library(jsonlite)
source('scripts/r_wrapper_nlc.R')

setCredentials("25e8a197-c9a0-40c6-853c-2fefbb2f604e", "w0vUBjAKLCt9")

createClassifier('dataset/train.csv', 'pt-br', 'My Classifier')

classifiers <- as.data.frame(fromJSON(listClassifiers()))

statusClassifier <- fromJSON(statusClassifier(classifiers[2,1]))
statusClassifier$status

result <- fromJSON(classify(classifiers[2,1], "Vai ter aula hoje?"))

deleteClassifier(classifiers[1,1])
