#' save_box UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_save_box_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2(tags$strong("2")),
    h4("Label the drawing"),
    radioButtons(ns("labels"),label = "Coose the label:",
                 choiceValues = c("y","x",""),inline = TRUE,
                 choiceNames = c(emo::ji_glue(":white_check_mark:"),emo::ji_glue(":x:"),"None selected"),
                 selected = ""),
    tags$br(),tags$br(),
    h2(tags$strong("3")),
    h4("Save to database"),
    "Works only if the drawing is labeled.", 
    tags$br(),
    "After your drawing is saved it vanishes.",
    tags$br(),
    "Caution: this step can not be undone!",
    tags$br(),tags$br(),
    actionButton(ns("save"), "Save",icon = icon("save"),
                 style="color: #3EC73A; background-color: #FFFFFF; border-color: #FFFFFF")
  )
}
    
#' save_box Server Function
#'
#' @noRd 
mod_save_box_server <- function(input, output, session, r, r_id){
  ns <- session$ns
  x_name <- paste("x",r_id,sep = "_")
  y_name <- paste("y",r_id,sep = "_")
  
  observeEvent(input$save, handlerExpr = {
    if((input$labels %in% c("x","y")) & (!is.null(r[[x_name]]))){
      mat <- YesNoDetect::build_matrix(r[[x_name]],r[[y_name]])
      YesNoDetect::append_row_db(mat,input$labels)
      #reset
      r[[x_name]] <- NULL; r[[y_name]] <- NULL
      updateRadioButtons(session,"labels",selected = "")
    }
  })
 
}
    
## To be copied in the UI
# mod_save_box_ui("save_box_ui_1")
    
## To be copied in the server
# callModule(mod_save_box_server, "save_box_ui_1",r , r_id)
 
