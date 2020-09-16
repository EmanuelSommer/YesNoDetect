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
      fullSection(
        menu = "intro",
        h1("YesNoDetect"),
        h2("Shiny Applicaton for the prediction of handwritten Yes or No boxes. 
           Moreover feeding the database of the Neural Network used to predict the boxes"),
        "links and more details"
      ),
      fullSection(
        menu = "db",
        fullSlide(
          fullContainer(
            h1("Explore the database"),
            h2("summary statistics"),
            fullRow(
              fullColumn(width = 4,
                h2("distribution bar plot")
              ),
              fullColumn(width = 4,
                "first mean plot"
              ),
              fullColumn(width = 4,
                "second mean plot"
              )
            )
          )
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
      fullSection(
        menu = "model",
        h1("The current model"),
        h2("To be done.")
      ),
      fullSection(
        menu = "pred",
        h1("Predict!"),
        h2("To be done.")
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

