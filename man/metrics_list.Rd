% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data_documentation.R
\docType{data}
\name{metrics_list}
\alias{metrics_list}
\title{Model metrics list}
\format{
A list of 6 elements
\describe{
 \item{trainable_params}{Numeric value for the number of trainable parameters of the model}
 \item{test_acc}{Numeric value for the test accuracy}
 \item{size_test_set}{Integer value for the size of the test set}
 \item{size_training_data}{Integer value for the size of the training set}
 \item{loss}{Character value for name of the loss function used}
 \item{size_training_data}{Character value for the name of the optimizer used}
}
}
\usage{
metrics_list
}
\description{
Contains the most important model metrics of the current convolutional neural network.
}
\keyword{datasets}
