#' use_tychobra_js
#'
#' function to load some custom js \code{shiny} and \code{shinydashboard} apps
#'
#' @param show_window_icon boolean that deafults to `TRUE`.  Determines whether or
#' not to show Tychobra logo icon in browser tab
#'
#' @importFrom shiny singleton tags
#'
#' @export
#'
use_tychobra_js <- function(show_window_icon = TRUE) {

  if (show_window_icon) {
    out <- tags$div(
      shiny::singleton(
        shiny::tags$head(
          shiny::tags$link(rel="icon", href="https://res.cloudinary.com/dxqnb8xjb/image/upload/v1510505618/tychobra-logo-blue_d2k9vt.png"),
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
  } else {
    out <- tags$div(
      shiny::singleton(
        shiny::tags$head(
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
  }

  out
}
