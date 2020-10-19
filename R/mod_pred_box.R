#' pred_box UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_pred_box_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinyWidgets::useShinydashboard(),
    tags$style(".small-box.bg-green { background-color: #409932 !important; color: #FFFFFF !important; }"),
    tags$style(".small-box.bg-red { background-color: #B50945 !important; color: #FFFFFF !important; }"),
    h2(tags$strong("2")),
    h4("Predict"),
    actionButton(ns("predict_button"), "Predict current drawing",icon = icon("brain"),
                 style="color: #E6EFFF; background-color: #73777F; border-color: #73777F"),
    tags$br(),tags$br(),
    h2(tags$strong("3")),
    h4("Results"),
    shinydashboard::valueBoxOutput(ns("yes_result"),width = 12),
    tags$br(),tags$br(),
    shinydashboard::valueBoxOutput(ns("no_result"),width = 12)
  )
}
    
#' pred_box Server Function
#'
#' @noRd 
mod_pred_box_server <- function(input, output, session, r){
  ns <- session$ns
  
  observeEvent(input$predict_button,{
    if(!is.null(r$x_pred)){
      waiter::waiter_show(html = tagList(
        div(
          style="color: #000000;",
          h4("Compute prediction"),
          waiter::spin_loaders(37,color = "#000000")
        )),color = "#E6EFFF")
      pred_mat <- YesNoDetect::build_matrix(r$x_pred,r$y_pred)
      pred_array <- as.array(pred_mat) %>%
        keras::array_reshape(., dim = c(1,dim(.), 1))
      pred_vec <- as.numeric(keras::predict_proba(r$model,pred_array))
      names(pred_vec) <- c("x","y")
      pred_vec <- round(pred_vec,3)
      r$pred_yes <- pred_vec[2]
      r$pred_no <- pred_vec[1]
      waiter::waiter_hide()
    }
  })
  
  output$yes_result <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(r$pred_yes,subtitle = "Probability for yes",icon = icon("check"),
                             color = "green",width = 12)
  })
  output$no_result <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(r$pred_no,subtitle = "Probability for no",icon = icon("times"),
                             color = "red",width = 12)
  })
}
    
## To be copied in the UI
# mod_pred_box_ui("pred_box_ui")
    
## To be copied in the server
# callModule(mod_pred_box_server, "pred_box_ui", r)
 
