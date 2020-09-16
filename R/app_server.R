#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # reactive list for communication between modules
  r <- reactiveValues(x_db=NULL, y_db=NULL)
  # connect to googlesheets account
  googlesheets4::gs4_auth(cache = "secrets",email = "emanuelsommer8@gmail.com")
  
  # first level modules
  callModule(mod_draw_box_server, "draw_box_db",r = r,r_id = "db")
  callModule(mod_save_box_server, "save_box_ui",r = r , r_id = "db")
}
