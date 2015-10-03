library(jsonlite)
source('scripts/r-wrapper.R')

test <- function(classifierId, testDataset){
  # Using all examples from testDataset to test the classifier. 
  #
  # Args:
  #   classifierId: a character value that represents the classifier's id
  #   testDataset: 
  # Returns:
  #   A data.frame with XXXX
  result <- data.frame(realClass = 0, predicted = 0, confidence = 0)
  for (i in 1:nrow(testDataset)){
    x <- fromJSON(classify(classifierId, testDataset[i,1]))
    ri <- c(paste(testDataset[i,2]), x$top_class, x$classes$confidence[1])
    result <- rbind(result, ri)
  }
  return(result[-1,])
}