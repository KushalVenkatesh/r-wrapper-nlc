
# URL's NLC service
url <- "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers"

setCredentials <- function(user, passwd){
  # Setting the credentials of NLC service
  #
  # Args:
  #  user: username of NLC credentials
  #  passwd: password of NLC credentials
  #
  # Returns:
  #  Nothing. Just set up the global variables 
  #  username and password
  username <<- user
  password <<- passwd
}

printCredentials <- function(){
  # Print the credentials of NLC service
  #
  # Args:
  #  None.
  #
  # Returns:
  #  Just print the username and password of
  #  NLC service
  print(paste(username, password))
}

createClassifier <- function(trainingData, language, name){
  # Create a classifier with CSV data through  
  # POST /v1/classifiers method
  #
  # Args:
  #  trainingData: path to the CSV file.
  #  language: set up the language ('en', 'pt-br' or 'es') that 
  #    will be used in the NLC. 
  #  name: some text that specifies the name of classifier 
  #
  # Returns:
  #  JSON result with classifier_id and other informations
  command <- paste('curl -u "',
                   username,
                   '":"',
                   password,
                   '" -F training_metadata="{\\"language\\":\\"',
                   language,
                   '\\",\\"name\\":\\"',
                   name,
                   '\\"}" -F training_data=@',
                   trainingData,   
                   ' ',
                   url, sep = "")
  return(system(command, intern = TRUE))  
}

listClassifiers <- function(){
  # Retrieves the list of classifiers for the user.
  # This function uses the method GET /v1/classifiers
  #
  # Args:
  #  None.
  #
  # Returns:
  #  A JSON result with a list of classifiers
  command <- paste('curl -u "',
                   username,
                   '":"',
                   password, 
                   '" ',
                   url, sep = "")
  return(system(command, intern = TRUE))
}

classify <- function(classifierId, text){
  # Return label information for the input.
  # This function uses the method POST
  # /v1/classifiers/{classifierId}/classify
  #
  # Args:
  #   classifierId: a character that represents the classifier's id that 
  #     will be used in this classification task.
  #   text: a text that will be classified by the classifier.
  # 
  # Returns:
  #   A JSON result with the classification result of "text" using 
  #     the "classifierId".
  command <- paste('curl -X POST -u "',
                   username,
                   '":"',
                   password,
                   '" -H "Content-Type:application/json" -d "{\\"text\\":\\"',
                   text,
                   '\\"}"',
                   ' "',
                   url,
                   '/',
                   classifierId,
                   '/classify"', sep = "")
  return(system(command, intern = TRUE))
}

deleteClassifier <- function(classifierId){
  # Deletes a classifier represented by classifierId.
  # This method calls DELETE /v1/classifiers/{classifierId}
  #
  # Args:
  #   classifierId: a character that represents the classifier's id
  # 
  # Returns:
  #   A empty JSON string.
  #
  command <- paste('curl -X DELETE -u "',
                   username,
                   '":"',
                   password, 
                   '" "',
                   url,
                   '/',
                   classifierId,
                   '"',
                   sep = "")
  return(system(command, intern = TRUE))  
}

deleteAllClassifiers <- function(classifiersId){
  # Delete all classifiers that are in vector classifiersId  
  #
  # Args:
  #  classifiersId: a vector that contains classifier's ids.
  #
  # Returns:
  #  None.
  #
  for(classifier in classifiersId){
    deleteClassifier(classifier)
  }
}

statusClassifier <- function(classifierId){
  # Returns the training status of a classifier.
  # This function calls GET /v1/classifiers/{classifierId}
  #
  # Args:
  #   classifierId: a character that represents the classifier's id
  #
  # Returns:
  #   A JSON result with the status information.
  command <- paste('curl -u "',
                   username,
                   '":"',
                   password, 
                   '" "',
                   url,
                   '/',
                   classifierId,
                   '"',
                   sep = "")
  return(system(command, intern = TRUE))  
}