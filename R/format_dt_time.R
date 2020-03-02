#' format_dt_time
#'
#' @param col_num the column number to format.  `col_num` uses 1 based column indexing, so
#' the first column is column `1`.
#' @param today_format the format to use for datetimes in the current day.  Valid values are
#' "time" (to only show the time), "date" (to only show the date), and "datetime" (to show
#' the date and the time).  Defaults to "time".
#' @param older_format the format to use for datetimes from days before the current day.  Valid values are
#' "time" (to only show the time), "date" (to only show the date), and "datetime" (to show
#' the date and the time).  Defaults to "date".
#'
#' @export
#'
#' @importFrom htmlwidgets JS
#'
#' @examples
#' format_dt_time(5)
#'
#'
format_dt_time <- function(col_num, today_format = "time", older_format = "date") {

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

      if (today_format === 'time') {
        out = date_local.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit'})
      } else if (today_format === 'date') {
        out = date_local.toLocaleDateString()
      } else {
        out = date_local.toLocaleDateString() + ' ' + date_local.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit'})
      }


    } else {

      if (older_format === 'time') {
        out = date_local.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit'})
      } else if (older_format === 'date') {
        out = date_local.toLocaleDateString()
      } else {
        out = date_local.toLocaleDateString() + ' ' + date_local.toLocaleTimeString([], {hour: 'numeric', minute: '2-digit'})
      }

    }",

    paste0("$('td:eq(", col_num_js, ")', row).html(out)"),

    "}"
  )

}
