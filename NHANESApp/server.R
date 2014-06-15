library(shiny)
library(car)

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

    # Not sure if this is working.  I see > 1 after local reloads though.
    output$hits <- renderText({
      paste0("App Hits:" , SP$npers)
    })
    
    output$varInfo <- renderPrint({
      selectVarI <- input$selectVar
      NHANESVarI <- which(NHANES_pulldown_choices == selectVarI)
      cat(selectVarI)
      cat("\n")
      summary(NHANES_data[,NHANESVarI])
    })

    output$varInfoY <- renderPrint({
      selectYVarI <- input$selectYVar
      NHANESYVarI <- which(NHANES_pulldown_choices == selectYVarI)
      cat(selectYVarI)
      cat("\n")
      summary(NHANES_data[,NHANESYVarI])
    })
    
    # Possible enhancements:
    # - Allow specifying limits
    # - Allow specifying subsets
    # - Allow variable transformations (mainly log?)
    # - Add tab for scatterplots
    # Do variables interact between blocks?
    output$varScatter <- renderPlot({
      selectVar0 <- input$selectVar
      NHANESVar0 <- which(NHANES_pulldown_choices == selectVar0)
      selectYVar0 <- input$selectYVar
      NHANESYVar0 <- which(NHANES_pulldown_choices == selectYVar0)
      scatterplot(NHANES_data[,NHANESVar0], NHANES_data[,NHANESYVar0], xlab=selectVar0,
                  ylab=selectYVar0)
    })

    output$varHist <- renderPlot({
      selectVar1 <- input$selectVar
      NHANESVar1 <- which(NHANES_pulldown_choices == selectVar1)
      hist(NHANES_data[,NHANESVar1], xlab=selectVar1, col='lightblue',
           main='Histogram with 5%, 25%, 50%, 75%, and 95% quantiles')
      quant1 <- quantile(NHANES_data[,NHANESVar1], probs = c(0.05, 0.25, 0.5, 0.75, 0.95),
                        na.rm=TRUE)
      for (i in 1:length(quant1)) abline(v=quant1[i],col="red")
    })

    # selectVar <- "Glucose (mg/dL) - LBXSGL"
    # Why is this version failing?
    output$Scatterplot <- renderPlot({
      selectVar2 <- input$selectVar
      NHANESVar2 <- which(NHANES_pulldown_choices == selectVar2)
      selectYVar2 <- input$selectYVar
      NHANESYVar2 <- which(NHANES_pulldown_choices == selectYVar2)
      scatterplot(NHANES_data[,NHANESVar2], NHANES_data[,NHANESYVar2], xlab=selectVar2,
                  ylab=selectYVar2)
    })
    
  }
)
