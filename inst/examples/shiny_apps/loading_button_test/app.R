library(shiny)
library(tychobratools)

ui <- fluidPage(
  fluidRow(
    column(
      12,
      h1("Test App"),
      loading_button(
        "my_loading_button",
        "Loading Button"
      ),
      actionButton(
        "reset",
        "Reset Button"
      )
    )
  )
)

server <- function(input, output, session) {

  observeEvent(input$reset, {

    reset_loading_button("my_loading_button")
  })

}

shinyApp(ui, server)

