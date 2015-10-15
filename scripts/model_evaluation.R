library(jsonlite)
source('scripts/r_wrapper_nlc.R')

test <- function(classifierId, testDataset){
  # Using all examples from testDataset to test the classifier. 
  #
  # Args:
  #   classifierId: a character value that represents the classifier's id
  #   testDataset: a data.frame with text and correct classes
  # Returns:
  #   A data.frame with these attributes: real class, predicted class and 
  #   confidence about predicted class
  result <- data.frame(realClass = 0, predicted = 0, confidence = 0)
  for (i in 1:nrow(testDataset)){
    tryCatch(
      {
        x <- fromJSON(classify(classifierId, testDataset[i,1]))
        ri <- c(paste(testDataset[i,2]), x$top_class, x$classes$confidence[1])
        result <- rbind(result, ri)
      },
      error = function(e) print(i)
    )
  }
  return(result[-1,])
}