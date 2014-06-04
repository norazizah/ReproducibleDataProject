library(shiny)

SP <- list() # Server parameters
# Record the number of poeple who have used the app since initiation on the server
SP$npers <- 0

NHANES_data_file <- "NHANES_1999.RData"
load(file = NHANES_data_file)

# create variable selection list
# choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
varChoices <- as.list(NHANES_names_use)

shinyServer(
  function(input, output) {
    # shinyServer is Started up every time the domain is called.
    # Use <<- to assign to the global server environment.
    SP$npers <<- SP$npers+1

    output$hits <- renderText({
      paste0("App Hits:" , SP$npers)
    })
    
    output$varInfo <- renderPrint({
      selectVar <- input$selectVar
      summary(NHANES_data[,selectVar])
      })
    
    # Add breaks as an input argument?
    output$varHist <- renderPlot({
      selectVar <- input$selectVar
      hist(NHANES_data[,selectVar], xlab=selectVar, col='lightblue',
           main='Histogram with 5%, 25%, 50%, 75%, and 95% quantiles')
      quant <- quantile(NHANES_data[,selectVar], probs = c(0.05, 0.25, 0.5, 0.75, 0.95), na.rm=TRUE)
      for (i in 1:length(quant)) abline(v=quant[i],col="red")
    })
  }
)
