#' With Tychobra Spinner
#'
#' Simple wrapper around [shinycssloaders::withSpinner()] that uses the Tychobra
#' custom spinner.
#'
#' @param obj A UI element that should be wrapped with a spinner when the
#'   corresponding output is being calculated.
#' @param src image source path or URL
#'
#' @inheritDotParams shinycssloaders::withSpinner
#'
#' @return HTML spinner
#'
#' @export
#'
#' @importFrom shiny addResourcePath
#' @importFrom shinycssloaders withSpinner
#'
with_tychobra_spinner <- function(
  obj,
  src = "tychobra_spinner.gif",
  ...
) {
  shiny::addResourcePath("tychtools", system.file("assets", package = "tychobratools"))

  src_out <- file.path("tychtools", src)

  shinycssloaders::withSpinner(ui_element = obj, image = src_out, ...)
}

