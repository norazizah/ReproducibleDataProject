library(shiny)

NHANES_data_file <- "NHANES_1999.RData"
load(file = NHANES_data_file)

# create variable selection list
# choices = list("Choice 1" = 1, "Choice 2" = 2, "Choice 3" = 3)
varChoices <- as.list(NHANES_pulldown_choices)

shinyUI(pageWithSidebar(
  headerPanel("NHANES 1999-2000 Lab Variable Quantiles"),
  sidebarPanel(
    selectInput("selectVar", label = h3("NHANES variable"), 
                choices = varChoices, selected = "Glucose (mg/dL) - LBXSGL"),
    submitButton('Submit')
  ),
  mainPanel(
    plotOutput('varHist'),
    verbatimTextOutput('varInfo'),
    # Would prefer this go elsewhere
    helpText("NHANES data obtained from"),
    helpText(a("http://www.cdc.gov/nchs/nhanes.htm",
             href="http://www.cdc.gov/nchs/nhanes.htm")),
    # Display the total number of hits on the app.
    h5(textOutput("hits"))
  )
))
