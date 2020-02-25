rm (list = ls()) 

library (data.table)
library (dplyr)
library (kSamples)
library (ggplot2)
library (shiny)
library (ggpubr)

setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/mcf.testing/sludge/")
source ("get.mood.R")

study_design_root_dir <- "~/Box Sync/WESyS_Project/Study_Designs/FY19"
wesys_data_root_dir <- "~/Box Sync/WESyS_Project/data_wte/vbsa"
study_extension <- "q1_12factors_31oct"#"ratereturn.31may.fixpng" #"fixedfactornew"


ui <- fluidPage(
  titlePanel("Local Sensitivity Analysis of WESyS Using Mood"),
  sidebarLayout(
    sidebarPanel(sliderInput("resultInput", "Energy (GJ)", min = 0, max = 6e8,
                             value = c(0, 6e8), pre = ""),
                 uiOutput("regionOutput"),
                 uiOutput("typeOutput"),
                 uiOutput("xaxisdataOutput"),
                 uiOutput("xaxisOutput"),
                 uiOutput("yaxisdataOutput"),
                 uiOutput("yaxisOutput"),
                 uiOutput("alphaOutput")
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
                          tabPanel("Mood Results",
                                   plotOutput("ad_results")
                                  )
                       )
              )
  )
)

server <- function(input, output) {
  
  output$regionOutput <- renderUI({
    selectInput("regionInput", "Region",
                list("joined"), #sort(unique(data$region)),
                selected = "joined")
  })
  
  output$typeOutput <- renderUI({
    selectInput("typeInput", "Type",
                list("all"), #sort(unique(data$type)),
                selected = "all")
  })
  
  
  wesys_data <- reactive({
  if (is.null(input$typeInput) | is.null(input$regionInput)){
    return(NULL)
  }
    withProgress(message = "Loading results \n", value = 0, {
      filename_wesys <- paste("sampled_results", tolower(input$regionInput), input$typeInput, study_extension, "RDA", sep=".")
      folder_wesys <- paste(wesys_data_root_dir, tolower(input$regionInput), input$typeInput, study_extension, "results", sep="/") 
      file <- paste(folder_wesys, filename_wesys, sep="/")
      incProgress(amount=0.5)
      load(file)
      wesys_results <- energy.wtot

      incProgress(amount=0.5)
      return(wesys_results)
    })
  })
  
  study_data <- reactive({
    if (is.null(input$typeInput) | is.null(input$regionInput)){
      return(NULL)
    }
    withProgress(message = "Loading study \n", value = 0, {
      filename_wesys <- paste("sampled_design", tolower(input$regionInput), input$typeInput, study_extension, "RDA", sep=".")
      folder_wesys <- paste(wesys_data_root_dir, tolower(input$regionInput), input$typeInput, study_extension, "results", sep="/") 
      file <- paste(folder_wesys, filename_wesys, sep="/")
      incProgress(amount=0.5)
      load(file)
      study_design <- filtered_design
      colnames(study_design)[which(names(study_design) == "value")] <- "value.factor"
      
      incProgress(amount=0.5)
      return(study_design)
    })
  }) 
  
  energy_list <- reactive({
    if (is.null(wesys_data()$type_energy)){
      return(NULL)
    }
    
    energy_types <- unique(wesys_data()$type_energy)
    #levels(droplevels(energy_types))
  })
  
  output$xaxisdataOutput <- renderUI({
    if(is.null(input$typeInput)){
      return(NULL)
    }
    
    selectInput("xaxisdataInput", "x-axis data",
                list("wesys_results", "study_design"),
                selected = "wesys_results")
    
  })
  
  output$yaxisdataOutput <- renderUI({
    if(is.null(input$typeInput)){
      return(NULL)
    }
    
    selectInput("yaxisdataInput", "y-axis data",
                list("wesys_results"),
                selected = "wesys_results")
    
  })
  
  output$yaxisOutput <- renderUI({
    if(is.null(input$typeInput)){
      return(NULL)
    }
    
    energy_list_executed <- energy_list()
    if (input$xaxisInput == "sorted by energy"){

      v <- selectInput("yaxisInput", "y-axis variable",
                       energy_list_executed[grep("total energy", energy_list_executed$type_energy)],
                       selected = energy_list_executed[grep("total energy", energy_list_executed$type_energy)])
    }
    if (input$xaxisInput != "sorted by energy"){

      v <- selectInput("yaxisInput", "y-axis variable",
                  sort(energy_list_executed),
                  selected = "WWTP.facilities[CHP]")
    }
    
    return(v)
  })

  output$xaxisOutput <- renderUI({
    if(is.null(input$typeInput)){
      return(NULL)
    }
    
    if(is.null(input$xaxisdataInput)){
      return(NULL)
    }
    
    if(input$xaxisdataInput == "wesys_results"){
      out <- selectInput("xaxisInput", 
                  "x-axis variable",
                  list("time", "ordered by energy"), #sort(colnames(wesys_data())),
                  selected = "time"
      )
    }
   
    if(input$xaxisdataInput == "study_design"){
      out <- selectInput("xaxisInput", 
                  "x-axis variable",
                  sort(unique(study_data()$factor)),
                  selected = "Global Inputs.per tonne tipping fee"
      )
    }
    return(out)
  })   
  
  output$alphaOutput <- renderUI({
    numericInput("alphaInput", 
                 "Alpha",
                 0.95, min = 0, max = 1)
  })
  
  filtered <- reactive({
    if (is.null(input$regionInput) | is.null(input$yaxisInput) | is.null(input$xaxisInput) | is.null(input$xaxisdataInput)) {
      return(NULL)
    }  
    
    if(input$xaxisdataInput == "wesys_results"){
      datafilter <- wesys_data() %>%
        filter(value >= input$resultInput[1],
               value <= input$resultInput[2],
               #type == input$typeInput,
               #region == input$regionInput,
               type_energy == input$yaxisInput
               )
      datafilter$order_id <- NA
      if(input$xaxisInput == "ordered by energy"){
        datafilter <- datafilter %>% 
          filter(time == 2040)
        datafilter <- datafilter[order(datafilter$value), ]
        datafilter$order_id <- seq.int(nrow(datafilter))
      }
      return(datafilter)
    }
    
    
    if(input$xaxisdataInput == "study_design"){
      wesysdatafilter <- wesys_data() %>%
        filter(value >= input$resultInput[1],
               value <= input$resultInput[2],
               #type == input$typeInput,
               #region == input$regionInput,
               type_energy == input$yaxisInput,
               time == 2040
        )
      study <- study_data() %>%
        filter(factor == input$xaxisInput
               )
      
      withProgress(message = "Merging study design with results \n", value = 0, {
        incProgress(0.5)        
        datafilter <- merge(wesysdatafilter, study, by="run_id")
        incProgress(0.5)        
        })
    }
    return(datafilter)
  })
  
  observe({print(str(filtered()))})
  observe({print(input$xaxisInput)})
  observe({print(input$yaxisInput)})
  
  
    
  output$bplot <- renderPlot({
    if (is.null(filtered()) | is.null(input$xaxisdataInput)) {
      return()
    }
    
    if (input$xaxisdataInput == "wesys_results"){
      if (input$xaxisInput == "time") {
        x <- filtered()[ , c(input$xaxisInput, "value")]
        title <- paste(input$regionInput, input$typeInput, input$yaxisInput, "over time")  
      }
      
      if (input$xaxisInput == "ordered by energy"){
        x <- filtered()[ , c("order_id", "value")]
        title <- paste(input$regionInput, input$typeInput, input$yaxisInput, "in 2040")  
      }
    }
    
    if (input$xaxisdataInput == "study_design"){
      x <- filtered()[ , c("value.factor", "value")]
      title <- paste(input$regionInput, "2040", input$typeInput, input$xaxisInput, "vs", input$yaxisInput)
    }
  
    plot(x, main=title)
  })
  
  output$bbarplot <- renderPlot({
    if (is.null(bpoints())) {
      return()
    }
    
    bpoints <- bselection()
    possible_bbarpoints <- bpoints[which(bpoints$selected_ == FALSE), ]
    if (input$xaxisdataInput == "wesys_results"){
      
      if (input$xaxisInput == "time") {
        x <- possible_bbarpoints[ , c(input$xaxisInput, "value")]
        title <- paste(input$regionInput, input$typeInput, input$yaxisInput, "over time")  
      }
      
      if (input$xaxisInput == "ordered by energy"){
        x <- possible_bbarpoints[ , c("order_id", "value")]
        title <- paste(input$regionInput, input$typeInput, input$yaxisInput, "in 2040")  
      }
    
    }
    
    if (input$xaxisdataInput == "study_design"){
      x <- possible_bbarpoints[ , c("value.factor", "value")]
      title <- paste(input$regionInput, "2040", input$typeInput, input$xaxisInput, "vs", input$yaxisInput)
    }
    
    plot(x, main=title)

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
  
  bselection <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush)) {
      return(NULL)
    }
    
    datafilter <- filtered()
    if (input$xaxisdataInput == "wesys_results"){
      if (input$xaxisInput == "time"){
        datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush, xvar="time", yvar="value", allRows=TRUE)
      }
      if (input$xaxisInput == "ordered by energy"){
        datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush, xvar="order_id", yvar="value", allRows=TRUE)
      }
    }
    if (input$xaxisdataInput == "study_design"){
      datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush, xvar="value.factor", yvar="value", allRows=TRUE)
    }
    
    return(datafilter_brush)
  })
  
  print("test")
  observe({ print(input$xaxisdataInput)})
  observe({ print(str(bselection()))})
  
  bpoints <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush)) {
      return(NULL)
    }
    
    selected <- bselection()
    bpoints <- selected[which(selected$selected_ == TRUE), ]
  }) 
  
  observe({ print(nrow(bpoints())) })
  
  bbarpoints <- reactive({
    if (is.null(input$regionInput)) {
      return(NULL)
    }  
    
    if (is.null(input$plot_brush_bbar)) {
      return(NULL)
    }
    
    datafilter <- filtered()
    
    if (input$xaxisdataInput == "wesys_results"){
      if (input$xaxisInput == "time"){
        datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush_bbar, xvar="time", yvar="value", allRows=TRUE)
      }
      if (input$xaxisInput == "ordered by energy"){
        datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush_bbar, xvar="order_id", yvar="value", allRows=TRUE)
      }
    }
    
    if (input$xaxisdataInput == "study_design"){
      datafilter_brush <- brushedPoints(datafilter, brush = input$plot_brush_bbar, xvar="value.factor", yvar="value", allRows=TRUE)
    }
    
    bbarpoints <- datafilter_brush[which(datafilter_brush$selected_ == TRUE), ]
  })
  
  observe({ print(nrow(bbarpoints()))})
  
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
    if (is.null(input$yaxisInput)) {
      return(NULL)
    }  
    
    input$yaxisInput
  })
  
  output$ad_results <- renderPlot ({
                                     if (is.null(bpoints())) {
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

                                      results <- run.mood(selection = df, bbar = bbar, design = vbsa.design, design.melted = TRUE, alpha=input$alphaInput)
                                      #results_round <- results 
                                      #results_round$B.med <-round(results$B.med, 3)
                                      #results_round$B.bar.med <-round(results$B.bar.med, 3)
                              
                                      # low.quan.2 <- data.table (factor = results_round$factor, 
                                      #                           value = results_round$B.med, 
                                      #                           lower = tapply (results_round$B.med, results_round$factor, quantile, probs = c(0.95), na.rm = TRUE),
                                      #                           upper = tapply (results_round$B.med, results_round$factor, quantile, probs = c(0.05), na.rm = TRUE)
                                      #                           )
                                      
                                      print(str(results))
                                      data <- subset(results, select=c("factor", "type", "value"))
                                      summary_data <- summary(data)
                                      #return(summary_data)
                                      # boxplot(data[,"value"])
                                      # normalizeFeature <- function(data, fMin=-1.0, fMax=1.0){
                                      #   dMin = min(na.omit(data))
                                      #   dMax = max(na.omit(data))
                                      #   factor = (fMax - fMin) / (dMax - dMin)
                                      #   normalized = fMin + (data - dMin)*factor
                                      #   normalized
                                      # }

                                      data_norm <- setNames(data.frame(matrix(ncol = 4, nrow = 0)), c("factor","type", "value", "norm_value"))
                                      for (factor_value in unique(data$factor)){
                                        factor_data <- setNames(data.frame(matrix(ncol = 4, nrow = 0)), c("factor","type", "value", "norm_value")) 
                                        factor_data <- data[data$factor == factor_value, ]
                                        factor_data$norm_value <- factor_data$value / max(factor_data$value)
                                        data_norm <- rbind(data_norm, factor_data)
                                      }
                                      #gg <- boxplot(norm_value~factor*type, data=data_norm, notch=TRUE) #boxplot(data_norm, x = "factor", y = "norm_value", color="type")
                                      gg <- ggboxplot (data_norm,  x = "factor", y = "norm_value", color="type") +
                                            geom_boxplot(notch = FALSE, show.legend = TRUE)  +
                                            #stat_compare_means(method = "anova", label.y = 40) +
                                            theme(axis.title.x = element_blank(),
                                                  #axis.text.x = element_blank(),
                                                  axis.ticks.x = element_blank(),
                                                  legend.title=element_blank(),
                                                  text = element_text(size=16),
                                                  axis.text.x = element_text(angle = 90, hjust = 1))
                                      return(gg)
                                    })
                                     }, width = 800, height = 600, res = 72)

}

shinyApp(ui = ui, server = server)