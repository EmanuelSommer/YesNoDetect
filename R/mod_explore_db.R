#' explore_db UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_explore_db_ui <- function(id){
  ns <- NS(id)
  tagList(
    shinyWidgets::useShinydashboard(),
    h1("Overview of the database"),
    tags$br(),tags$br(),
    fluidRow(tags$style(".small-box.bg-yellow { background-color: #73777F !important; color: #FFFFFF !important; }"),
             tags$style(".small-box.bg-green { background-color: #409932 !important; color: #FFFFFF !important; }"),
             tags$style(".small-box.bg-red { background-color: #B50945 !important; color: #FFFFFF !important; }"),
             column(3),
             column(width = 2,
                    shinydashboard::valueBoxOutput(ns("yes_valuebox"),width = NULL)
             ),
             column(width = 2,
                    shinydashboard::valueBoxOutput(ns("no_valuebox"),width = NULL)
             ),
             column(width = 2,
                    shinydashboard::valueBoxOutput(ns("total_valuebox"),width = NULL)
             ),
             column(3),
    ),
    tags$br(),tags$br(),
    fluidRow(class = "eda_plots_row",
             column(1),
             column(width = 4,style = "background-color: #E6EFFF;color: #E6EFFF;",
                    plotOutput(ns("label_dist_plot"),width = "400px",height = "300px")
             ),
             column(width = 3,style = "background-color:#E6EFFF;color:#E6EFFF;",
                    plotOutput(ns("average_yes_plot"),width = "282px",height = "300px")
             ),
             column(width = 3,style = "background-color:#E6EFFF;color:#E6EFFF;",
                    plotOutput(ns("average_no_plot"),width = "282px",height = "300px")
             ),
             column(1),
    ),tags$head(tags$style(".eda_plots_row{height:300px;background-color: #E6EFFF;color: #E6EFFF}")),
    actionButton(ns("refresh_db"), "Reload database",icon = icon("cloud-download-alt"),
                 style="color: #E6EFFF; background-color: #73777F; border-color: #73777F")
  )
}
    
#' explore_db Server Function
#'
#' @noRd 
mod_explore_db_server <- function(input, output, session, r){
  ns <- session$ns
  
  output$label_dist_plot <- renderPlot({
    YesNoDetect::plot_label_dist(data.frame(label = r$current_labels))
  })
  # the following two plots are not refreshed every session because this would require the whole database to be comupted which overloads
  # the memory capacity of the server
  output$average_yes_plot <- renderPlot({
    YesNoDetect::average_yes_plot
  })
  output$average_no_plot <- renderPlot({
    YesNoDetect::average_no_plot
  })
  # refresh db
  observeEvent(input$refresh_db, handlerExpr = {
    waiter::waiter_show(html = tagList(
      div(
        style="color: #000000;",
        waiter::spin_loaders(37,color = "#000000"),
        h4("Reload database")
      )),color = "#E6EFFF")
    r$current_labels <- YesNoDetect::get_current_labels()
    waiter::waiter_hide()
  })
  
  output$total_valuebox <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(length(r$current_labels),subtitle = "Total boxes",icon = icon("database"),
                             color = "yellow",width = NULL)
  })
  output$yes_valuebox <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(sum(r$current_labels == "y"),subtitle = "Yes boxes",icon = icon("check"),
                             color = "green",width = NULL)
  })
  output$no_valuebox <- shinydashboard::renderValueBox({
    shinydashboard::valueBox(sum(r$current_labels == "x"),subtitle = "No boxes",icon = icon("times"),
                             color = "red",width = NULL)
  })
}
    
## To be copied in the UI
# mod_explore_db_ui("explore_db_ui")
    
## To be copied in the server
# callModule(mod_explore_db_server, "explore_db_ui", r)
 