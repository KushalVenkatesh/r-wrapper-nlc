R Wrapper for Natural Language Classifier Service
=================================================

The goal of this project is implementing a wrapper to use the IBM Watson Natural Language Classifier service with R Language.

The IBM Watson™ Natural Language Classifier service uses machine learning algorithms to return the top matching predefined classes for short text inputs. The service employs a new set of technologies known as "deep learning" to get the best performance possible. Deep learning algorithms offer state of the art approaches in image and speech recognition, and the Natural Language Classifier now applies the technologies to text classification.

R is a free software environment for statistical computing and graphics. R provides a wide variety of statistical (linear and nonlinear modelling, classical statistical tests, time-series analysis, classification, clustering, …) and graphical techniques, and is highly extensible. One of R’s strengths is the ease with which well-designed publication-quality plots can be produced, including mathematical symbols and formulae where needed. 

Motivation
----------

Which this wrapper anyone (who knows R) can easily create, evaluate and publish his experiments with NLC using R. The idea behind this project is encapsulate all NLC API REST into R functions. 

Structure
---------

All NLC functions are defined in r_wrapper_nlc.R file. The main functions are:

* setCredentials (user, passwd)
* createClassifier (trainingData, language, name)
* listClassifiers ()
* classify (classifierId, text)
* deleteClassifier (classifierId)
* deleteAllClassifiers (classifiersId)
* statusClassifier (classifierId)

Besides these functions, there are other functions related to the evaluation. Functions related to the model evaluation are defined in model_evaluation.R script. These functions are:

* test (classifierId, testDataset)

Other functions are comming.

Pre-requirements
----------------

The pre-requirement is:

* You must have the curl command instaled in your machine. If you are using a Unix like (Linux, Mac OS) system, probably the curl command is already instaled. Otherwise, you can download a source archive [here](http://curl.haxx.se/download.html).

We suggest to you use RStudio enviroment to improve your productivity. This project already has a Rproj file (r-wrapper-nlc.Rproj).

Running an example
------------------

This wrapper can be used to create and validate models using Natural Language Classifier Service. An example is
presented in script example_weather.R. To run a complete analysis you can:

* Open the file scripts/example_weather.R
* Load all necessary libraries:

````
library(xlsx)
library(jsonlite)
library(caret)
source('scripts/r_wrapper_nlc.R')
source('scripts/model_evaluation.R')
````

* Set the language of NLC and temporary directory:

````
language <- 'en'
directory <- 'weather'
````

* Pre-processing, filtering and cleaning the dataset:

````
dataset <- read.csv('dataset/weather_data_train.csv', header = FALSE)
names(dataset) <- c('text','class')
sapply(dataset, class)
dataset$text <- as.character(dataset$text)
````

* Set up the credentials of NLC and, if necessary, cleaning old NLC instances. In order to
set the credentials, you need to replace <USERNAME> and <PASSWORD> by the correct NLC 
credentials. 

````
setCredentials("<USERNAME>", "<PASSWORD>")
classifiers <- as.data.frame(fromJSON(listClassifiers()))
deleteAllClassifiers(classifiers$classifiers.classifier_id)
````

You may need to validate your model using a N-fold cross validation or other type
of validation method. In example_weather.R script I used a 5-fold cross validation. 

At the of this script there are some plot examples that can be useful too.


