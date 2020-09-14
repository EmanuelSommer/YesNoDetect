#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  r <- reactiveValues(x_db=NULL, y_db=NULL)
  
  callModule(mod_draw_box_server, "draw_box_db",r = r,r_id = "db")
}
