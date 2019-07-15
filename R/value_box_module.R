#' value_box_module_ui
#' 
#' @param icon An icon made by the shiny icon function
#' @param backgroundColor A hex color code string
#' @param textColor A hex color code string
#' @param width A number between 1 and 12
#' @param href A url
#' 
#' @import shiny
#' @import shinydashboard
#' 
#' @export
#'
value_box_module_ui <- function(id, icon = NULL, backgroundColor = "#7cb5ec", textColor = "#FFF", width = 4, href = NULL) {
  ns <- NS(id)

  boxContent <- shiny::div(
    class = paste0("small-box"),
    style = paste0("background-color: ", backgroundColor, "; color: ", textColor, ";"),
    shiny::div(
      class = "inner",
      shiny::h3(
        style = "height: 40.91px;",
        shiny::textOutput(ns("value"))
      ),
      shiny::div(
        shiny::p(shiny::textOutput(ns("subtitle"))),
        style = "font-size: 15px; height: 20.91px; margin-bottom: 10px"
      )
    ),
    if (!is.null(icon)) {
      shiny::div(class = "icon-large", icon)
    }
  )
  if (!is.null(href)) {
    boxContent <- shiny::a(href = href, boxContent)
  }
  shiny::div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    boxContent
  )
}

#' value_box_module
#' 
#' @param value The value to be displayed in the value box
#' @param subtitle The subtitle to be displayed in the value box
#' 
#' @export
#' 
value_box_module <- function(input, output, server, value, subtitle) {
  value_prep <- reactive({
    if (is.null(value())) {
      ""
    } else {
      value()
    }
  })
  
  output$value <- shiny::renderText(value_prep())
  
  subtitle_prep <- reactive({
    if (is.null(subtitle())) {
      ""
    } else {
      subtitle()
    }
  })
  
  output$subtitle <- shiny::renderText(subtitle_prep())
}
