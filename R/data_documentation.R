#' Model metrics list
#'
#' Contains the most important model metrics of the current convolutional neural network.
#'
#' @format A list of 6 elements
#' \describe{
#'  \item{trainable_params}{Numeric value for the number of trainable parameters of the model}
#'  \item{test_acc}{Numeric value for the test accuracy}
#'  \item{size_test_set}{Integer value for the size of the test set}
#'  \item{size_training_data}{Integer value for the size of the training set}
#'  \item{loss}{Character value for name of the loss function used}
#'  \item{size_training_data}{Character value for the name of the optimizer used}
#' }
#'
"metrics_list"

#' The average yes box plot
#'
#' A ggplot2 object that visualizes the average yes box.
#'
"average_yes_plot"

#' The average no box plot
#'
#' A ggplot2 object that visualizes the average no box.
#'
"average_no_plot"
