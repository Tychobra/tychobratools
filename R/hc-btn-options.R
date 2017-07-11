#' hc_btn_options
#'
#' options to only include specific download buttons in the highcharter download button
#'
#' @export
hc_btn_options <- function() {
  list(
    contextButton = list(
      menuItems = list(
        list(
          text = "Export to PDF",
          onclick = JS(
            "function () { this.exportChart({
              type: 'application/pdf'
            }); }"
          )
        ),
        list(
          text = "Export to SVG",
          onclick = JS(
            "function () { this.exportChart({
              type: 'image/svg+xml'
            }); }"
          )
        )
      )
    )
  )
}
