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
    waiter::waiter_show_on_load(html = tagList(waiter::spin_loaders(37),
                                               h4("Initialization"),
                                               h5("Loading the database may take a moment.")),
                                color = "#1AA7ED"),
    fullPage(
      center = TRUE,
      opts = list(
        sectionsColor = c(
          "#1AA7ED",
          "#1AA7ED",
          "#1AA7ED",
          "#1AA7ED"
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
        h3("Web applicaton for the prediction of handwritten yes or no boxes using a convolutional neural network."),
        h4(strong("Database:"),"Explore and amend the database which is the foundation of the modeling process."),
        h4(strong("Model:"),"The current model architecture, stats and valuaton metrics."),
        h4(strong("Predict:"),"Challenge the model with your drawings and recieve prediction probabilities."),
        "Disclaimer: This application is built as a desktop application and thus is not fully operational on touchscreens.",
        tags$br(),
        "Written in R by Emanuel Sommer. For feedback and issues visit me on GitHub.",
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

