#' options for DT buttons
#'
#' @param filename function that returns the filename for the downloaded file
#' @param cols columns to download.  Passed to exportOptions
#'
dt_buttons_options <- function(
  filename = function() paste0("file-", Sys.Date(), ".xlsx"),
  cols = NULL
) {

  out <- list(
    list(
      extend = "excel",
      text = "Download",
      title = paste0("golf_carts-", Sys.Date()),
      exportOptions = list(
        columns =
      )
    )
  )

  if (!is.null(cols)) {
    out[[1]][[1]]$exportOptions <- list(
      columns = cols
    )
  }

  out
}
