# custom configuration for the `shinytoastr::toastr_*()` functions
toast_custom_defaults <- list(
  position = "bottom-center",
  progressBar = TRUE,
  timeOut = 4000,
  closeButton = TRUE,

  # same as defaults
  title = "",
  newestOnTop = FALSE,
  preventDuplicates = FALSE,
  showDuration = 300,
  hideDuration = 1000,
  extendedTimeOut = 1000,
  showEasing = c("swing", "linear"),
  hideEasing = c("swing", "linear"),
  showMethod = c("fadeIn", "slideDown", "show"),
  hideMethod = c("fadeOut", "hide")
)


#' show toast message
#'
#' A wrapper around the `shinytoastr::toast_*()` functions that uses our preferred default argument
#' values.
#'
#' @param type length 1 character vector.  Valid values are "success", "error", "warning", and "info"
#' @param message the toast message
#' @param .options other options to pass to the `shinytoastr::toast_*()` function
#'
#' @export
#'
#' @import shinytoastr
#'
#' @return `invisible()`
#'
show_toast <- function(type, message, .options = list()) {

  args_list <- c(message, toast_custom_defaults)
  args_out <- modifyList(args_list, .options)

  function_name <- paste0("toastr_", type)

  do.call(function_name, args_out)

  invisible()
}
