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
  r <- reactiveValues(x_db=NULL, y_db=NULL,x_pred=NULL,y_pred=NULL, # these record the drawings
                      pred_yes = NULL,pred_no = NULL) # these save the predictions
  # r$current_db <- YesNoDetect::get_current_db() # df containing current db
  r$current_labels <- YesNoDetect::get_current_labels()
  # get current cnn
  r$model <- keras::load_model_tf("modeling/current_cnn")
  # hide waiter
  waiter::waiter_hide()
  ###################### db ################################
  # amend data base section
  callModule(mod_draw_box_server, "draw_box_db",r = r,r_id = "db")
  callModule(mod_save_box_server, "save_box_ui",r = r , r_id = "db")
  
  # explore database section
  callModule(mod_explore_db_server, "explore_db_ui", r = r)
  
  ##################### model ##############################
  callModule(mod_model_stats_server, "model_stats_ui_1")
  ##################### predict ############################
  callModule(mod_draw_box_server, "draw_box_pred",r = r,r_id = "pred")
  callModule(mod_pred_box_server, "pred_box_ui", r = r)
  
  session$onSessionEnded(function(){
    keras::k_clear_session()
  })
}
