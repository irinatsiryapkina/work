rm(list=ls())
R_LIBS= ("/home/R/library")

options(scipen=999)


library (data.table)
library (dplyr)
library (kSamples)
library (ggplot2)
library (shiny)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge/")

#load the anderson-darling functions
source ("get.ad.R")

#load the study design
load ("study.design.RDA")

#make sure column names match code
setnames (vbsa.design, c("factor", "run_id", "value"))


#load the study results
#load ("wwtp.results.RDA") #this is the whole output for total energy from sludge from ca
#make the names match code
#setnames (temp, c("run_id", "factor", "value"))

#for faster analysis I sampled the original output (10%) and sorted by 
load ("sampled.sorted.wwtp.total.RDA") #these data are sorted by produciton level "result"

out$index <- seq(from = 1, to = nrow(out), by = 1) #add sequence to allow ordered plotting

#shiny

ui <- fluidPage(
  titlePanel ("LSA of CA Sludge Total Energy Using Anderson-Darling"),
  selectInput("state", "Choose a state:",
              list(`East Coast` = c("NY", "NJ", "CT"),
                   `West Coast` = c("WA", "OR", "CA"),
                   `Midwest` = c("MN", "WI", "IA"))
              ),
              textOutput("result"),
  fluidRow(
    column(width = 4,
           plotOutput("plot1", height = 400, width = 600,
                      brush = brushOpts(
                        id = "plot1_brush",
                        fill = "pink",
                        stroke = "black",
                        clip = TRUE,
                        delay = 1000
                      )
           )
    )
  ),
  
    fluidRow (
       column(width = 6,
          h4("Anderson-Darling"),
          tableOutput("ad.results") 
    )
  ),

  #column(width = 6,
         #h4("Selected points"),
         #verbatimTextOutput("brush_info"),
         
         tags$style(type="text/css",
                    ".shiny-output-error { visibility: hidden; }",
                    ".shiny-output-error:before { visibility: hidden; }"
         )

    )
  

server <- function(input, output) {
  output$plot1 <- renderPlot({
    ggplot(out, aes(index, result)) + geom_point(color = "light blue")
  })
  
  #output$brush_info <- renderPrint({
    #brushedPoints(out, input$plot1_brush)
  #})  
  
  output$ad.results <- renderTable ({
    
    df <- as.data.table ( brushedPoints(out, input$plot1_brush))
    
    get.ad (selection = df, design = vbsa.design, boots = 5, design.melted = TRUE)
      
    
  })
}
  

shinyApp(ui, server)

