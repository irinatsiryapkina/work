#rm (list = ls()) 

library (data.table)
library (dplyr)
library (kSamples)
library (ggplot2)
library (shiny)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge/")

source ("get.ad.R")

box_directory <- "~/Box Sync/WESyS_Project/"
study_design_root_dir <- "~/Box Sync/WESyS_Project/Study_Designs/FY18"
wesys_data_root_dir <- "~/Box Sync/WESyS_Project/data_wte/vbsa"
study_extension <- "fixedfactornew"

#ca.sludge.old <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/ca/sludge/fixedfactornew/results/ca.sludge.total.energy.sampled.csv")
#ca.biogas <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/ca/biogas/fixedfactornew/results/ca.biogas.total.energy.sampled.csv")
#rotus.sludge <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/rotus/sludge/fixedfactornew/results/rotus.sludge.total.energy.sampled.csv")
#rotus.biogas <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/rotus/biogas/fixedfactornew/results/rotus.biogas.total.energy.sampled.csv")

#print("Loading ca.sludge data")
#ca.sludge <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/ca/sludge/fixedfactornew/results/ca_sludge_1pct.csv")
#print("Loading ca.biogas data")
#ca.biogas <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/ca/biogas/fixedfactornew/results/ca_biogas_1pct.csv")
# print("Loading rotus.sludge data")
# rotus.sludge <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/rotus/sludge/fixedfactornew/results/rotus_sludge_1pct.csv")
# print("Loading rotus.biogas data")
# rotus.biogas <- read.csv("~/Box Sync/WESyS_Project/data_wte/vbsa/rotus/biogas/fixedfactornew/results/rotus_biogas_1pct.csv")

#ca.sludge$region <- "CA"
#ca.sludge$type <- "sludge"
# rotus.sludge$region <- "ROTUS"
# rotus.sludge$type <- "sludge"
# ca.biogas$region <- "CA"
# ca.biogas$type <- "biogas"
# rotus.biogas$region <- "ROTUS"
# rotus.biogas$type <- "biogas"

#ca.sludge.total <- aggregate(ca.sludge$value, by=list(run_id=ca.sludge$run_id), FUN=sum)
#ca.sludge.total <- aggregate(ca.sludge$value, by=list(run_id=ca.sludge$run_id, factor=ca.sludge$factor, source=ca.sludge$source), FUN=sum)


#data <- rbind(rotus.biogas, rotus.sludge, ca.biogas, ca.sludge)
data <- ca.sludge

# #pre-process biogas 
#print('Filtering energy type lists')
# biogas_list <- ca.biogas
# biogas_list <- biogas_list[-grep('HTL', biogas_list$factor), ]
# biogas_list <- biogas_list[-grep('Fuel', biogas_list$factor), ]
# biogas_list <- biogas_list[-grep('FUEL', biogas_list$factor), ]
# biogas_list <- biogas_list[-grep('potential', biogas_list$factor), ]
# biogas_list <- unique(biogas_list$factor)

#sludge_list <- ca.sludge
#sludge_list <- sludge_list[grep('WWTP', sludge_list$factor), ]
#sludge_list <- sludge_list[-grep('potential', sludge_list$factor), ]
#sludge_list <- unique(sludge_list$factor)

ui <- fluidPage(
  titlePanel("Local Sensitivity Analysis of WESyS Using Anderson-Darling"),
  sidebarLayout(
    sidebarPanel(sliderInput("resultInput", "Energy (quads)", min = 0, max = 0.06,
                             value = c(0, 0.06), pre = ""),
                 uiOutput("regionOutput"),
                 uiOutput("typeOutput"),
                 #uiOutput("variableOutput"),
                 #uiOutput("timeOutput"),
                 uiOutput("pvalueOutput"),
                 uiOutput("bootsOutput")
                ), 
    mainPanel(tabsetPanel(type = "tabs",
                          tabPanel("Select Points of Interest (B)", 
                                   plotOutput("bplot",
                                              click = "plot_click",
                                              dblclick = "plot_dblclick",
                                              hover = "plot_hover",
                                              brush = "plot_brush"
                                             ),
                                   verbatimTextOutput("info")
                                  ),
                          tabPanel("Select Points for Comparison (B-bar)", 
                                   plotOutput("bbarplot",
                                              click = "plot_click_bbar",
                                              dblclick = "plot_dblclick_bbar",
                                              hover = "plot_hover_bbar",
                                              brush = "plot_brush_bbar"
                                             ),
                                   verbatimTextOutput("infobbar")
                                  ),
                          tabPanel("Anderson-Darling Results",
                                   tableOutput("ad_results")
                                  )
                       )
              )
  )
)

server <- function(input, output) {
  
  output$regionOutput <- renderUI({
    selectInput("regionInput", "Region",
                sort(unique(data$region)),
                selected = "CA")
  })
  
  output$typeOutput <- renderUI({
    selectInput("typeInput", "Type",
                sort(unique(data$type)),
                selected = "sludge")
  })
  
  output$variableOutput <- renderUI({

    if (input$typeInput == "sludge"){
      selectInput("variableInput", "Variable",
                  sort(sludge_list),
                  selected = "")
    }
    #
    # if (input$typeInput == "biogas"){
    #   selectInput("variableInput", "Variable",
    #               sort(biogas_list),
    #               selected = "")
    # }

    # if (input$typeInput == "sludge"){
    #   energy_type <- unique(data$type_energy[grep('WWTP', data$type_energy)])
    #   list_energy_type <- as.data.frame(energy_type)
    #   list_type <- list_energy_type[-grep('potential', list_energy_type$energy_type), ]
    #   selectInput("variableInput", "Variable",
    #               sort(list_type),
    #               selected = "")
    # }
    #
    # if (input$typeInput == "biogas"){
    #   energy_type <- unique(data$type_energy[-grep('HTL', data$type_energy)])
    #   list_energy_type <- as.data.frame(energy_type)
    #   no_htl <- list_energy_type[-grep('Fuel', list_energy_type$energy_type), ]
    #   list_type <- as.data.frame(no_htl)
    #   list_type <- list_type[-grep('FUEL', list_type$no_htl), ]
    #   list_type <- as.data.frame(list_type)
    #   list_type <- list_type[-grep('potential', list_type$list_type), ]
    #   selectInput("variableInput", "Variable",
    #               sort(list_type),
    #               selected = "")
    # }

  })
  
  # output$timeOutput <- renderUI({
  #   selectInput("timeInput", 
  #               "Year of Interest",
  #               sort(unique(data$time)),
  #               selected = "2040")
  # })
  
  output$pvalueOutput <- renderUI({
    numericInput("pvalueInput", 
                 "p-value",
                  1e-8, min = 1e-12, max = 0.05)
  })
  
  output$bootsOutput <- renderUI({
    numericInput("bootsInput", 
                 "Number of bootstraps",
                 10, min = 5, max = 5000)
  })
  
  filtered <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    datafilter <- data %>%
      filter(value >= input$resultInput[1] * 1.055e9,
             value <= input$resultInput[2] * 1.055e9,
             type == input$typeInput,
             region == input$regionInput,
             factor == "WWTP.HTL tot" #input$variableInput
             )
  })
  
  output$bplot <- renderPlot({
    if (is.null(filtered())) {
      return()
    }
    
    plot(filtered()$X, filtered()$value/(1.055e9), 
         main=input$dataset, 
         sub=input$dataset,
         xlab="Run (ordered by total energy produced)", 
         ylab="Total Energy Produced in 2040 (quads/yr)",
         #xlim=c(2015, 2040),#c(0, 6.5e4), 
         #ylim=c(min(data$value/(1.055e9)), max(data$value/(1.055e9)))
         )
    
    #ggplot(filtered(), aes_string(x=filtered()$X, y=filtered()$value, fill=filtered()$value)) +
    #  geom_histogram(alpha=0.5,position="identity")
  })
  
  filteredb <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush)) {
      return(NULL)
    }
    
    datafilter <- data %>%
      filter(value >= input$resultInput[1] * 1.055e9,
             value <= input$resultInput[2] * 1.055e9,
             X < input$plot_brush[1],
             type == input$typeInput,
             region == input$regionInput,
             factor == "WWTP.HTL tot" #input$variableInput
      )
    
    datafilter2 <- data %>%
      filter(value >= input$resultInput[1] * 1.055e9,
             value <= input$resultInput[2] * 1.055e9,
             X > input$plot_brush[2],
             type == input$typeInput,
             region == input$regionInput,
             factor == "WWTP.HTL tot" #input$variableInput
      )
    
    data <- rbind(datafilter, datafilter2)
  })
  
  output$bbarplot <- renderPlot({
    if (is.null(filteredb())) {
      return()
    }
    
    plot(filteredb()$X, filteredb()$value/(1.055e9), 
         main=input$dataset, 
         sub=input$dataset,
         xlab="Run (ordered by total energy produced)", 
         ylab="Total Energy Produced in 2040 (quads/yr)",
         xlim=c(0, 6.5e4), 
         ylim=c(min(data$value/(1.055e9)), max(data$value/(1.055e9))))
    
    #ggplot(filtered(), aes_string(x=filtered()$X, y=filtered()$value, fill=filtered()$value)) +
    #  geom_histogram(alpha=0.5,position="identity")
  })
  
  output$info <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", round(e$x, 0), " y=", round(e$y, 4), "\n")
    }
    xy_range_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("xmin=", round(e$xmin, 0), " xmax=", round(e$xmax, 0), 
             " ymin=", round(e$ymin, 4), " ymax=", round(e$ymax, 4))
    }
    
    paste0(
      "click: ", xy_str(input$plot_click),
      "dblclick: ", xy_str(input$plot_dblclick),
      "hover: ", xy_str(input$plot_hover),
      "brush: ", xy_range_str(input$plot_brush)
    )
  })
  
  output$infobbar <- renderText({
    xy_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("x=", round(e$x, 0), " y=", round(e$y, 4), "\n")
    }
    xy_range_str <- function(e) {
      if(is.null(e)) return("NULL\n")
      paste0("xmin=", round(e$xmin, 0), " xmax=", round(e$xmax, 0), 
             " ymin=", round(e$ymin, 4), " ymax=", round(e$ymax, 4))
    }
    
    paste0(
      "click: ", xy_str(input$plot_click_bbar),
      "dblclick: ", xy_str(input$plot_dblclick_bbar),
      "hover: ", xy_str(input$plot_hover_bbar),
      "brush: ", xy_range_str(input$plot_brush_bbar)
    )
  })
  
  observe({ print(str(filtered())) })
  
  bpoints <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush)) {
      return(NULL)
    }
    
    datafilter <- data %>%
      filter(value >= input$resultInput[1] * 1.055e9,
             value <= input$resultInput[2] * 1.055e9,
             X > input$plot_brush[1],
             type == input$typeInput,
             region == input$regionInput,
             factor == "WWTP.HTL tot" #input$variableInput
      )
  })
  
  observe({ print(str(bpoints())) })
  
  bbarpoints <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush_bbar)) {
      return(NULL)
    }
    
    datafilter <- data %>%
      filter(value >= input$resultInput[1] * 1.055e9,
             value <= input$resultInput[2] * 1.055e9,
             X > input$plot_brush_bbar[1],
             X < input$plot_brush_bbar[2],
             type == input$typeInput,
             region == input$regionInput,
             factor == "WWTP.HTL tot" #input$variableInput
      )
  })
  
  region <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    tolower(input$regionInput)
  })
  
  type <- reactive({
    if (is.null(input$typeInput)) {
      return(NULL)
    }  
    
    input$typeInput
  })
  
  variable <- reactive({
    if (is.null(input$variableInput)) {
      return(NULL)
    }  
    
    input$variableInput
  })
  
  output$ad_results <- renderTable ({
                                     if (is.null(filteredb())) {
                                      return(NULL)
                                     }
                                    
                                    if (is.null (input$plot_brush)) {
                                      print ("B not selected")
                                      return(NULL)
                                    }
                                    
                                    if (is.null (input$plot_brush_bbar)) {
                                      print("B-bar is not selected")
                                      return(NULL)
                                    }
                    
    
                                    df <- as.data.table (bpoints())
                                    bbar <- as.data.table(bbarpoints())
                                    
                                    withProgress(message = "Calculation in progress \n", value = 0, {
                                      region_lower <- tolower(region())
                                      type <- type()
                                      design_filename <- paste("sobol.design", region_lower, type, "vbsa", type, region_lower, study_extension, "RDA", sep=".")
                                      folder_name <- paste("vbsa", type, region_lower, study_extension, sep=".")
                                      print("Loading study design...")
                                      incProgress(0.2, detail = "Loading study design...")
                                      
                                      study_design_file <- paste(study_design_root_dir, "vbsa_design", folder_name, design_filename, sep="/")
                                      selection <- df
                                      design <- study_design_file
                                      load(study_design_file)
                                      colnames(vbsa.design)[which(names(vbsa.design) == "variable")] <- "factor"
                                      colnames(vbsa.design)[which(names(vbsa.design) == "run")] <- "run_id"
                                      
                                      design <- vbsa.design

                                      results <- get.ad (selection = df, bbar = bbar, design = vbsa.design, boots = input$bootsInput, design.melted = TRUE, pvalue=input$pvalueInput)
                                      results_round <- results 
                                      results_round$B.med <-round(results$B.med, 3)
                                      results_round$B.bar.med <-round(results$B.bar.med, 3)
                                      
                                      return(results_round)
                                    })
                                     }, digits=3)
  
}

shinyApp(ui = ui, server = server)