library(shiny)
library(car) # Needed here?

NHANES_data_file <- "NHANES_1999.RData"
load(file = NHANES_data_file)

# create variable selection list
# choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
varChoices <- as.list(NHANES_pulldown_choices)

shinyUI(pageWithSidebar(
  headerPanel("NHANES 1999-2000 Blood Lab Variables"),
  sidebarPanel(
    selectInput("selectVar", label = h3("NHANES variable"), 
                choices = varChoices, selected = "Glucose (mg/dL) - LBXSGL"),
    selectInput("selectYVar", label = h3("NHANES Y axis"), 
                choices = varChoices, selected = "Triglyceride (mg/dL) - TR"),
    submitButton('Submit'),
    h5(helpText("Documentation")),
    helpText("Select two NHANES blood lab test variables above (test name, units, and NHANES variable name are all displayed) then click Submit.  A histogram with various quantiles is displayed for the first variable in the Quantiles tab (this information can be used to establish test reference ranges).  Click on the Scatterplot tab to see a scatterplot of the two variables along with a regression line, a loess smooth, and Box plots of both variables along the axes.  The scatterplot helps detect if there is a relationship between the two variables.  A numerical summary of both variables is provided below the plots.")
  ),
  mainPanel(
    tabsetPanel(
      tabPanel("Quantiles", plotOutput('varHist')),
      tabPanel("Scatterplot", plotOutput('varScatter'))
      #tabPanel("Scatterplot", plotOutput('varScatterplot')) 
    ),
    #plotOutput('varHist'),
    #plotOutput('varScatterplot'),
    verbatimTextOutput('varInfo'),
    verbatimTextOutput('varInfoY'),
    # Would prefer this help text go elsewhere
    helpText("NHANES (US National Health and Nutrition Examination Survey) data obtained from"),
    helpText(a("http://www.cdc.gov/nchs/nhanes.htm",
             href="http://www.cdc.gov/nchs/nhanes.htm")),
    # Display the total number of hits on the app.
    h5(textOutput("hits"))
  )
))
