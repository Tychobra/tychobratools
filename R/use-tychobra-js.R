#' use_tychobra_js
#'
#' function to load some custom js \code{shiny} and \code{shinydashboard} apps
#'
#' @import shiny
#'
#' @export
#'
use_tychobra_js <- function() {

  shiny::addResourcePath("tychobratools", system.file("srcjs", package = "tychobratools"))

  return(
    tags$div(
      shiny::singleton(
        shiny::tags$head(
          shiny::tags$link(rel="icon", href="https://res.cloudinary.com/dxqnb8xjb/image/upload/v1509563497/tychobra-logo-blue_dacbnz.svg"),
          shiny::tags$script(
            src = file.path("tychobratools", "tychobra-shinydashboard.js")
          ),
          shiny::tags$link(
            rel = "stylesheet",
            href = file.path("tychobratools", "loading.css")
          )
        )
      )
    )
  )
}
