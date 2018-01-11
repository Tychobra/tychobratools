#' page_loading_ui
#'
#' html and css to show page loading animation
#'
#' @import shiny
#' @import htmltools
#'
#' @export
#'
#' @return html shiny.tag
#'
page_loading_ui <- function() {

  tags$div(
    id="floatingCirclesG",
    tags$div(class="f_circleG", id="frotateG_01"),
    tags$div(class="f_circleG", id="frotateG_02"),
    tags$div(class="f_circleG", id="frotateG_03"),
    tags$div(class="f_circleG", id="frotateG_04"),
    tags$div(class="f_circleG", id="frotateG_05"),
    tags$div(class="f_circleG", id="frotateG_06"),
    tags$div(class="f_circleG", id="frotateG_07"),
    tags$div(class="f_circleG", id="frotateG_08")
  )
}
