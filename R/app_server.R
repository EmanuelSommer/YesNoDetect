#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  #################### global ##############################
  # connect to googlesheets account
  googlesheets4::gs4_auth(cache = "secrets",email = "emanuelsommer8@gmail.com")
  # reactive list for communication between modules
  r <- reactiveValues(x_db=NULL, y_db=NULL)
  r$current_db <- YesNoDetect::get_current_db() # df containing current db
  
  ###################### db ################################
  # amend data base section
  callModule(mod_draw_box_server, "draw_box_db",r = r,r_id = "db")
  callModule(mod_save_box_server, "save_box_ui",r = r , r_id = "db")
  
  # explore database section
  callModule(mod_explore_db_server, "explore_db_ui", r = r)
  
  ##################### model ##############################
  ##################### predict ############################
}
