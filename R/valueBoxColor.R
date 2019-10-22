#' Change the color of a value box
#'
#' @param value The value to be displayed
#' @param subtitle The text below the value to be displayed
#' @param icon An icon tag created by icon
#' @param backgroundColor The background color of the value box
#' @param textColor The text color of the box
#' @param width The width of the box
#' @param href Option for a link
#'
#' @return HTML for a value box with a custom color
#'
#' @importFrom htmltools div h3 p a
#'
#' @export
#'
#' @examples
#' value <- "5%"
#' subtitle <- "Credibility Percentage"
#' backgroundColor <- "#c6077d"
#'
#' valueBoxColor(value, subtitle, backgroundColor = backgroundColor)
valueBoxColor <- function (value, subtitle, icon = NULL, backgroundColor = "#7cb5ec", textColor = "#FFF", width = 4, href = NULL) {

  boxContent <- div(
    class = paste0("small-box"),
    style = paste0("background-color: ", backgroundColor, "; color: ", textColor, ";"),
    div(
      class = "inner",
      h3(value),
      p(subtitle)
    ),
    if (!is.null(icon)) {
      div(class = "icon-large", icon)
    }
  )
  if (!is.null(href)) {
    boxContent <- a(href = href, boxContent)
  }
  div(
    class = if (!is.null(width)) paste0("col-sm-", width),
    boxContent
  )
}
