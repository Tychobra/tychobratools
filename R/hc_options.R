#' hc_btn_options
#'
#' options to only include specific download buttons in the highcharter download button
#'
#' @export
#'
#' @importFrom htmlwidgets JS
#' @importFrom shiny addResourcePath
#'
#' @examples
#' library(highcharter)
#'
#' # must be opened in a browser to work
#'
#' \dontrun{
#' highcharter::hchart(rnorm(100)) %>%
#'   highcharter::hc_exporting(
#'     enabled = TRUE,
#'     filename = "example-file",
#'     formAttributes = list(target = "_blank"),
#'     buttons = hc_btn_options()
#'   )
#' }
#'
#'
hc_btn_options <- function() {

  list(
    contextButton = list(
      menuItems = list(
        list(
          text = "Export to PDF",
          onclick = htmlwidgets::JS(
            "function () {
              this.exportChart({
                type: 'application/pdf'
              });
            }"
          )
        ),
        list(
          text = "Export to PNG",
          onclick = htmlwidgets::JS(
            "function () {
              this.exportChart(null, {
                chart: {
                  backgroundColor: '#FFFFFF'
                },
              });
            }"
          )
        )
      )
    )
  )
}



#' hc_global_options
#'
#' Alters `highcharter` global options
#'
#' Currently only change thousands separator from space to comma
#'
#' @export
hc_global_options <- function() {
  hcoptslang <- getOption("highcharter.lang")
  hcoptslang$thousandsSep <- ","
  options(highcharter.lang = hcoptslang)
}


#' hc_default_colors
#'
#' @return a character vector of the hex for Highcharts colors
#'
#' @export
hc_default_colors <- function() {
  c(
    "#7cb5ec",
    "#434348",
    "#90ed7d",
    "#f7a35c",
    "#8085e9",
    "#f15c80",
    "#e4d354",
    "#2b908f",
    "#f45b5b",
    "#91e8e1"
  )
}
