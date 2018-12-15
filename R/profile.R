#' profile_icon
#'
#' server logic for placing profile icon in header bar of shinydashboard.
#'
#' @param input no value needed for thos arguement
#' @param output no value needed for this arguement
#' @param session no value needed for this arguement
#' @param user optional reactive value representing user to override session$user
#'
#' @export
profile_icon <- function(input, output, session, user = NULL) {
  output$auth_user <- renderText({
    out <- "Guest"
    if (!is.null(user())) {
      out <- user()
    } else if (!is.null(session$user)) {
      session$user
    }
    out
  })
}

#' profile_icon_ui
#'
#' ui code for `profile_icon`. Should be placed in the the `header` arguement to
#' `dashboardPage()`
#'
#' @param id character string identifying the module
#'
#'
#' @export
profile_icon_ui <- function(id) {
  ns <- NS(id)

  tags$li(
    class = "dropdown",
    tags$a(
      href="#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      tags$i(
        class = "fa fa-user"
      )
    ),
    tags$ul(
      class = "dropdown-menu",
      tags$li(
        textOutput(ns("auth_user")),
        style='padding: 3px 20px;'
      ),
      tags$li(
        a(
          icon("sign-out"),
          "Logout",
          href="__logout__"
        )
      )
    )
  )
}


#' profile_icon_cloud_ui
#'
#' ui code for `profile_icon` for cloud.tychobra.com. Should be placed in the the `header`
#' argument to `dashboardPage()`
#'
#' @param id character string identifying the module
#'
#' @import shinyjs
#'
#' @export
profile_icon_cloud_ui <- function(id) {
  ns <- NS(id)

  shinyjs::hidden(tags$li(
    id = ns("id"),
    class = "dropdown",
    tags$a(
      href="#",
      class = "dropdown-toggle",
      `data-toggle` = "dropdown",
      tags$i(
        class = "fa fa-user"
      )
    ),
    tags$ul(
      class = "dropdown-menu",
      tags$li(
        textOutput(ns("auth_user")),
        style='padding: 3px 20px;'
      ),
      tags$li(
        a(
          icon("sign-out"),
          "Sign Out",
          href="#",
          id = "submit_sign_out"
        )
      )
    )
  ))
}

#' profile_icon_cloud
#'
#' server logic for placing profile icon in header bar of shinydashboard.
#'
#' @param input no value needed for thos arguement
#' @param output no value needed for this arguement
#' @param session no value needed for this arguement
#' @param user optional reactive value representing user to override session$user
#'
#' @export
profile_icon_cloud <- function(input, output, session, user = NULL) {
  ns <- session$ns

  observeEvent(user(), {

    print(list("user" = user()))
    if (is.null(user())) {
      shinyjs::hide("id")
    } else {
      shinyjs::show("id")
    }

  }, ignoreNULL = FALSE)



  output$auth_user <- renderText({
    req(user())
    user()
  })
}
