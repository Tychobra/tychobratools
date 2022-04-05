#' DT Responsive Table Callback
#'
#' Function to toggle responsive table on table created with \code{DT} package
#'
#' @param responsive Boolean (default: \code{TRUE}). Whether to make table responsive or not
#'
#' @importFrom DT JS
#'
#' @export
#'
dt_callback <- function(responsive = TRUE) {

  if (isTRUE(responsive)) {
    out <- DT::JS("
      $(table.table().container()).addClass('table-responsive');
      $.fn.dataTable.ext.errMode = 'none';
      return table;
    ")
  } else {
    out <- DT::JS("
      $.fn.dataTable.ext.errMode = 'none';
      return table
    ")
  }

  out
}
