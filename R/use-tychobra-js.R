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
          shiny::tags$link(rel="icon", href="http://res.cloudinary.com/dxqnb8xjb/image/upload/c_scale,w_20/v1510505618/tychobra-logo-blue_d2k9vt.png"),
          shiny::tags$script(
            src = file.path("tychobratools", "tychobra-shinydashboard.js")
          )
        )
      )
    )
  )
}
