#' Build a 28x28 matrix from the two coordinate vectors x and y corresponding to the two axis of the Yes and No boxes.
#'
#' First round the vectors and then output binary matrix indicating which points are drawn (the pixels)
#'
#' @param x numeric vector with domain [1,28] / corresponding to the x axis of the box
#' @param y numeric vector with domain [1,28] / corresponding to the y axis of the box
#'
#' @return a 28x28 matrix of 0 and 1
#' @export
#'
#' @import dplyr
#'
#' @author Emanuel Sommer
#' @examples
#' build_matrix(c(1, 1, 3.3, 5, 27.9), c(1, 1, 7.000012, 5.555, 28))
build_matrix <- function(x, y) {
  x <- round(x)
  y <- round(y)
  x[x > 28] <- 28
  x[x < 1] <- 1
  y[y > 28] <- 28
  y[y < 1] <- 1
  y <- 29 - y # invert plot y axis to get index
  df <- data.frame(x = x, y = y) %>%
    dplyr::distinct()
  mat <- matrix(rep(0, 28^2), nrow = 28, ncol = 28)
  for (row_ind in seq(dim(df)[1])) {
    mat[df$y[row_ind], df$x[row_ind]] <- 1
  }
  return(mat)
}
