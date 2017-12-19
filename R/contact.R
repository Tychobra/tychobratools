#' contact_ui
#'
#' ui for contact dropdown button in shinydashboard
#'
#' @param contacts
#'
#' @import htmltools
#'
#' @export
contact_ui <- function(contacts = list(
    list(
      name = "Elon Musk",
      phone = "555-555-5555",
      email = "elon.musk@tychobra.com"
    )
  )
) {

  len <- length(contacts)

  htmltools::tags$li(
    class = "dropdown",
    tags$a(
      href="#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      div(
        tags$i(
          class = "fa fa-phone"
        ),
        " Contact",
        style = "display: inline"
      )
    ),
    tags$ul(
      class = "dropdown-menu",
      lapply(contacts, function(contact_info) {
        htmltools::tagList(
          htmltools::tags$li(
            contact_info$name,
            style = "padding: 3px 20px;"
          ),
          htmltools::tags$li(
            htmltools::tags$a(
              htmltools::tags$i(
                class = "fa fa-envelope"
              ),
              href = paste0("mailto:", contact_info$email),
              contact_info$email
            )
          ),
          htmltools::tags$li(
            htmltools::tags$a(
              htmltools::tags$i(
                class = "fa fa-phone"
              ),
              href = "#",
              contact_info$phone
            )
          ),
          #br(),
          hr()
        )
      })
    )
  )
}
