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
#' @importFrom shinycssloaders withSpinner
with_tychobra_spinner <- function(obj,
                                  src = system.file('assets/tychobra_spinner.gif', package = "tychobratools"),
                                  ...) {

  shinycssloaders::withSpinner(ui_element = obj, image = src, ...)

}

