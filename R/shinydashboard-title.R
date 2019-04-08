#' displays Tychobra logo next to shinydsahbord title
#'
#' @param title string - the title
#'
#' @import htmltools
#' @import shiny
#'
#' @export
#'
tychobra_title <- function(title) {
  shiny::titlePanel(
    htmltools::HTML(
      paste0(
        htmltools::tags$a(
          href = "https://tychobra.com",
          htmltools::tags$img(
            src="https://res.cloudinary.com/dxqnb8xjb/image/upload/v1510505618/tychobra-logo-blue_d2k9vt.png",
            height = '50px',
            alt='Tychobra Logo',
            style='margin-top: -20px; float: left;'
          )
        ),
        htmltools::tags$span(title, style='float: left; font-size: 40px !important; margin-top: -18px !important; margin-left: 10px; padding-top: 0 !important;')
      )
    ),
    windowTitle = title
  )
}
