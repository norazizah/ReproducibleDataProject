library(shiny)

SP <- list() # Server parameters
# Record the number of poeple who have used the app since initiation on the server
SP$npers <- 0

# See details in NHANESApp_notes.R
NHANES_data_file <- "NHANES_1999.RData"
load(file = NHANES_data_file)

shinyServer(
  function(input, output) {
    # shinyServer is Started up every time the domain is called.
    # Use <<- to assign to the global server environment.
    SP$npers <<- SP$npers+1

    # Not sure if this is working.  I have never seen != 1.
    output$hits <- renderText({
      paste0("App Hits:" , SP$npers)
    })
    
    output$varInfo <- renderPrint({
      selectVar <- input$selectVar
      NHANESVar <- which(NHANES_pulldown_choices == selectVar)
      summary(NHANES_data[,NHANESVar])
      })
    
    # Possible enhancements:
    # - Allow specifying limits
    # - Allow specifying subsets
    # - Add tab for scatterplots
    output$varHist <- renderPlot({
      selectVar <- input$selectVar
      NHANESVar <- which(NHANES_pulldown_choices == selectVar)
      hist(NHANES_data[,NHANESVar], xlab=selectVar, col='lightblue',
           main='Histogram with 5%, 25%, 50%, 75%, and 95% quantiles')
      quant <- quantile(NHANES_data[,NHANESVar], probs = c(0.05, 0.25, 0.5, 0.75, 0.95),
                        na.rm=TRUE)
      for (i in 1:length(quant)) abline(v=quant[i],col="red")
    })
  }
)
