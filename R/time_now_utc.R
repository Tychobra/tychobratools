
#' get the current POSIXct timestamp in UTC
#'
#'
#'
#' @importFrom lubridate with_tz
#'
#' @export
#'
#' @examples
#'
#' time_now_utc()
#'
time_now_utc <- function() {
  lubridate::with_tz(Sys.time(), tzone = "UTC")
}
