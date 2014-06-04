# Tried deploying to https://rseiter.shinyapps.io/NHANESApp/
# but fails with error:
# ERROR: object 'varChoices' not found
# Is data not pushed?
# Some discussion of data files:
# https://groups.google.com/forum/#!topic/shiny-discuss/3lGPlkvzWF4
# Some shiny examples: https://github.com/woobe/rApps

setwd("C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/NHANESApp")
dir()

library(shiny)

# Show what Shiny is doing
runApp(display.mode='showcase')
