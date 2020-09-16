#' Return current state of database as dataframe
#'
#' @return dataframe with the current state of the database
#' @export
#'
#' @author Emanuel Sommer
get_current_db <- function(){
  googlesheets4::read_sheet("1FNtRCnRvzYjxvcSVqGtgpypZuJS7gf10oDn3-6nXXDs")
}

#' Add a labeled matrix containing the handwritten box data to the database
#'
#' @param mat numeric matrix containing the handwritten box data
#' @param label label either x for No or y for Yes (character)
#'
#' @return does not return something
#' @export
#'
#' @author Emanuel Sommer
append_row_db <- function(mat,label){
  # flatten by row
  temp_num <- as.numeric(t(mat))
  temp <- as.data.frame(matrix(temp_num,nrow = 1,byrow = TRUE))
  names(temp) <- paste0("V",1:784)
  temp$label <- label
  googlesheets4::sheet_append("1FNtRCnRvzYjxvcSVqGtgpypZuJS7gf10oDn3-6nXXDs",temp)
} 
