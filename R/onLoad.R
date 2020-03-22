#' Adds assets from "inst/srcjs/" to "tychobratools/" front end
#'
#' @importFrom shiny addResourcePath
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath("tychobratools", system.file("srcjs", package = "tychobratools"))
}
