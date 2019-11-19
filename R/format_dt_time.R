#' format_dt_time
#'
#' @param col_num the column number to format.  `col_num` uses 1 based column indexing, so
#' the first column is column `1`.
#'
#' @export
#'
#' @importFrom htmlwidgets JS
#'
#' @examples
#' format_dt_time(5)
#'
format_dt_time <- function(col_num) {

  col_num_js <- col_num - 1

  htmlwidgets::JS(
    "function(row, data) {",

    paste0("var date_string = data[", col_num_js, "]"),
    "if (date_string === null) return",

    "// convert time last signed in to time if time last signed in is today",
    "// or to date if time last signed in is a date prior to today",
    "function is_today(date) {
              var today = new Date()
              return date.getDate() == today.getDate() &&
              date.getMonth() == today.getMonth() &&
              date.getFullYear() == today.getFullYear()
            }",

    "// convert date string to a JS date",
    "var date_local = new Date(date_string)",
    "var date_is_today = is_today(date_local)",

    "var out = null",
    "if (date_is_today === true) {
              out = date_local.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit'})
            } else {
              out = date_local.toLocaleDateString()
            }",

    paste0("$('td:eq(", col_num_js, ")', row).html(out)"),

    "}"
  )

}
