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

All NLC functions are defined in r-wrapper.R file. The main functions are:

* setCredentials (user, passwd)
* createClassifier (trainingData, language, name)
* listClassifiers ()
* classify (classifierId, text)
* deleteClassifier (classifierId)
* deleteAllClassifiers (classifiersId)
* statusClassifier (classifierId)

Besides these functions, there are other functions related to the evaluation. Functions related to the model evaluation are defined in ModelEvaluation.R script. These functions are:

* test (classifierId, testDataset)

Other functions are comming.

Pre-requirements
----------------

The pre-requirement is:

* You must have curl command instaled in your machine.

We suggest to you use RStudio enviroment. This project already has a Rproj file (r-wrapper.Rproj).
