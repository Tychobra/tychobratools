#' Run Loading Button Test App
#'
#' @seealso loading_button
#' @return shiny app
#' @export
#' @importFrom shiny fluidPage fluidRow column actionButton observeEvent shinyApp
#' @importFrom htmltools h1
run_loading_button_test_app <- function(){

  ui <- shiny::fluidPage(
    # shinyjs::useShinyjs(),
    shiny::fluidRow(
      shiny::column(
        12,
        htmltools::h1("Test App"),
        loading_button(
          "my_loading_button",
          "Loading Button"
        ),
        shiny::actionButton(
          "reset",
          "Reset Button"
        )
      )
    ),
    shiny::fluidRow(
      shiny::column(
        12,
        shiny::verbatimTextOutput("text")
      )
    )
  )

  server <- function(input, output, session) {

    output$text <- shiny::renderText({
      paste0("Loading buttons value is ", input$my_loading_button)
    })

    shiny::observeEvent(input$reset, {
      reset_loading_button("my_loading_button")
    })

  }

  shiny::shinyApp(ui, server)

}
