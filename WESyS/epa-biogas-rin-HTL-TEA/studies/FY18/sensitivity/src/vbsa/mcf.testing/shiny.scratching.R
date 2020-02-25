rm(list=ls())
R_LIBS= ("/home/R/library")

library (shiny)

ui <- fluidPage(
  
  numericInput (inputId = "num", label = "X min", value = 0,
                min = -300, max = 1, step = 1),
  
  numericInput (inputId = "num2", label = "Y min", value = 0,
                min = -1, max = 1, step = 0.01),
  
  plotOutput ("results")#add the type of object here - table, plot
)

server <- function (input, output) {
  
  output$results <- renderPlot ({hist (rnorm (input$num))})
}

shinyApp (ui = ui, server = server)
