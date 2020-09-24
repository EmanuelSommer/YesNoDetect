#' draw_box UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_draw_box_ui <- function(id){
  ns <- NS(id)
  tagList(
    h4(emo::ji_glue("Draw either Yes :white_check_mark: or No :x:")),
    "Click once to start drawing and click once again to stop drawing",
    tags$br(),tags$br(),
    column(12,align = "center",
           plotOutput(ns("plot"), width = "300px", height = "300px",
                      hover=hoverOpts(id = ns("hover"), delay = 50,
                                      delayType = "throttle", clip = TRUE, nullOutside = TRUE),
                      click=ns("click")),
           tags$br()),
    tags$br(),
    actionButton(ns("reset"), "Reset drawing",icon = icon("redo"),
                 style="color: #1AA7ED; background-color: #FFFFFF; border-color: #FFFFFF")
  )
}
    
#' draw_box Server Function
#'
#' @noRd 
mod_draw_box_server <- function(input, output, session, r, r_id){
  ns <- session$ns
  x_name <- paste("x",r_id,sep = "_")
  y_name <- paste("y",r_id,sep = "_")
  draw = reactiveVal(FALSE)
  
  # start drawing
  observeEvent(input$click, handlerExpr = {
    temp <- draw()
    draw(!temp)
    if(!draw()) {
      r[[x_name]] <- c(r[[x_name]], NA)
      r[[y_name]] <- c(r[[y_name]], NA)
    } 
  })
  
  # reset
  observeEvent(input$reset, handlerExpr = {
    r[[x_name]] <- NULL; r[[y_name]] <- NULL
    draw(FALSE)
  })
  
  # record drawing
  observeEvent(input$hover, {
    if (draw()) {
      r[[x_name]] <- c(r[[x_name]], input$hover$x)
      r[[y_name]] <- c(r[[y_name]], input$hover$y)
    }
  })
  
  # output plot
  output$plot= renderPlot({
    par(bg = NA,mar = c(0,0,0,0))
    plot(x=r[[x_name]], y=r[[y_name]], xlim=c(0, 28), ylim=c(0, 28), ylab="", xlab="", type="l", lwd=10,
         frame.plot = TRUE,xaxt = "n",yaxt = "n")
  })
}
    
## To be copied in the UI
# mod_draw_box_ui("draw_box_ui_1")
    
## To be copied in the server
# callModule(mod_draw_box_server, "draw_box_ui_1")
 
