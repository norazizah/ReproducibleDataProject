library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("NHANES 1999-2000 Variable Quantiles"),
  sidebarPanel(
    selectInput("selectVar", label = h3("NHANES variable"), 
                choices = varChoices, selected = "LBXSGL"),
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
