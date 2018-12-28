#' generates sequence of "year_month" strings over a time period that includes all
#' months in the time period
#'
#' @param start_date the start_date for the time period
#' @param end_date the end date for the time period
#'
#' @return character vector with elements in the form "year_month". e.g.
#' c("2018-01", "2018-02")
#'
#' @import lubridate
#'
#' @export
#'
#' @examples
#' start <- as.Date("2018-01-07")
#' end <- as.Date("2018-03-01")
#'
#' year_month_seq(start, end)
#'
year_month_seq <- function(start_date, end_date) {
  start_date <- min(start_date)
  end_date <- as.Date(end_date)

  start_month <- lubridate::floor_date(start_date, "month")

  out <- seq(from = start_month, to = end_date, by = "month")

  out <- substr(out, 1, 7)

  gsub("-", "_", out, fixed = TRUE)
}
