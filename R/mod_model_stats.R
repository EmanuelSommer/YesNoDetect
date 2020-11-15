#' model_stats UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_model_stats_ui <- function(id) {
  ns <- NS(id)
  tagList(
    shinyWidgets::useShinydashboard(),
    h1("Model stats"),
    tags$br(), tags$br(),
    fluidRow(
      column(1),
      column(
        3,
        shinydashboard::infoBoxOutput(ns("size_train"), width = NULL)
      ),
      column(
        3,
        shinydashboard::infoBoxOutput(ns("size_test"), width = NULL)
      ),
      column(
        4,
        shinydashboard::infoBoxOutput(ns("test_acc"), width = NULL)
      ),
      column(1)
    ),
    tags$br(), tags$br(),
    fluidRow(
      column(1),
      column(
        3,
        shinydashboard::infoBoxOutput(ns("optimizer"), width = NULL)
      ),
      column(
        3,
        shinydashboard::infoBoxOutput(ns("loss"), width = NULL)
      ),
      column(
        4,
        shinydashboard::infoBoxOutput(ns("trainable"), width = NULL)
      ),
      column(1)
    ),
    tags$br(), tags$br(),
    "The model was implemented using the Keras API of Tensorflow."
  )
}

#' model_stats Server Function
#'
#' @noRd
mod_model_stats_server <- function(input, output, session) {
  ns <- session$ns
  my_info_color <- "light-blue"
  output$size_train <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$size_training_data, title = "Training samples", icon = icon("layer-group"),
      color = my_info_color, width = NULL
    )
  })
  output$size_test <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$size_test_set, title = "Testing samples", icon = icon("layer-group"),
      color = my_info_color, width = NULL
    )
  })
  output$test_acc <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$test_acc, title = "Accuracy on test set", icon = icon("bullseye"),
      color = my_info_color, width = NULL
    )
  })
  output$trainable <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$trainable_params, title = "Trainable parameters", icon = icon("project-diagram"),
      color = my_info_color, width = NULL
    )
  })
  output$loss <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$loss, title = "Loss function", icon = icon("project-diagram"),
      color = my_info_color, width = NULL
    )
  })
  output$optimizer <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      value = YesNoDetect::metrics_list$optimizer, title = "Optimizer", icon = icon("project-diagram"),
      color = my_info_color, width = NULL
    )
  })
}

## To be copied in the UI
# mod_model_stats_ui("model_stats_ui_1")

## To be copied in the server
# callModule(mod_model_stats_server, "model_stats_ui_1")
