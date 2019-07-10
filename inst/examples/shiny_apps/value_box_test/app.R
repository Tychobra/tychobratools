library(shiny)
library(shinydashboard)

source("../../../../R/value_box_module.R")

ui <- dashboardPage(
  header = dashboardHeader(),
  sidebar = dashboardSidebar(),
  body = dashboardBody(
    fluidRow(
      value_box_module_ui("test", icon = icon("box")),
      valueBoxOutput("original_box")
    ),
    fluidRow(
      column(
        4,
        align = "center",
        numericInput("input_num", "Number", 10)
      ),
      column(
        4,
        align = "center",
        actionButton("update_num", "Update Number")
      )
    )
  )
)

server <- function(input, output) {
  display_number <- reactiveVal()
  
  observeEvent(input$update_num, {
    display_number(input$input_num)
    display_text("Seconds")
  })
  
  display_text <- reactiveVal()
  
  callModule(value_box_module, "test", display_number, display_text)
  
  output$original_box <- renderValueBox({
    valueBox(display_number(), display_text(), icon = icon("box"))
  })
}

shinyApp(ui, server)
