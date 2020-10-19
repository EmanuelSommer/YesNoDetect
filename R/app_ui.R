#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import fullPage
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    waiter::use_waiter(),
    shinyWidgets::useShinydashboardPlus(),
    waiter::waiter_show_on_load(html = tagList(
      div(
        style="color: #000000;",
        waiter::spin_loaders(37,color = "#000000"),
        h4("Initialization"),
        h5("Loading the database.")
      )),color = "#E6EFFF"),
    fullPage(
      center = TRUE,
      opts = list(
        sectionsColor = c(
          "#E6EFFF",
          "#E6EFFF",
          "#E6EFFF",
          "#E6EFFF"
        )
      ),
      menu = c(
        "Start" = "intro",
        "Database" = "db",
        "Model" = "model",
        "Predict" = "pred"
      ),
      ################################ START ###################################
      fullSection(
        menu = "intro",
        # img = "www/app_background_brain.png", #potential background image - currently not active
        h1(emo::ji_glue("Handwritten :white_check_mark: and :x: detector")),
        tags$br(),tags$br(),
        h4("Prediction of your handwritten yes or no boxes using a convolutional neural network."),
        h4(strong("Database:"),"Explore and amend the database which is the foundation of the modeling process."),
        h4(strong("Model:"),"The current model architecture, stats and valuation metrics."),
        h4(strong("Predict:"),"Challenge the model with your handwritten boxes!"),
        tags$br(),tags$br(),
        "Disclaimer: This application is built as a desktop application and thus is not fully operational on touchscreens.",
        tags$br(),
        "Written in R by Emanuel Sommer. For the code, issues and feedback visit me on",
        tags$a(href = "https://github.com/EmanuelSommer","GitHub.",style = "color: #0E5FF0"),
        tags$br(),tags$br(),
        shinydashboardPlus::socialButton("https://github.com/EmanuelSommer",type = "github")
      ),
      ################################ DATABASE ################################
      fullSection(
        menu = "db",
        fullSlide(
          mod_explore_db_ui("explore_db_ui")
        ),
        fullSlide(
          fullContainer(
            h1("Amend the database"),
            fullColumn(width = 6,
                       h2(tags$strong("1")),
                       mod_draw_box_ui("draw_box_db")
                       ),
            fullColumn(width = 6,
                       mod_save_box_ui("save_box_ui"))
          )
        )
      ),
      ################################ MODEL ###################################
      fullSection(
        menu = "model",
        fullSlide(
          h1("The model architecture"),
          tags$br(),tags$br(),
          img(src = "www/cnn_scheme.png",width = "900px")
        ),
        fullSlide(
          mod_model_stats_ui("model_stats_ui_1")
        )
      ),
      ################################ PREDICT #################################
      fullSection(
        menu = "pred",
        fullContainer(
          h1("Predict!"),
          fullColumn(width = 6,
                     h2(tags$strong("1")),
                     mod_draw_box_ui("draw_box_pred")
          ),
          fullColumn(width = 6,
                     mod_pred_box_ui("pred_box_ui")
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'YesNoDetect'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

