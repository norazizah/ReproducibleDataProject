# Tried deploying to https://rseiter.shinyapps.io/NHANESApp/
# but fails with error:
# ERROR: object 'varChoices' not found
# Is data not pushed?
# Problem was I needed to set in ui.R, but had in local env.
# Some discussion of data files:
# https://groups.google.com/forum/#!topic/shiny-discuss/3lGPlkvzWF4
# Some shiny examples: https://github.com/woobe/rApps

setwd("C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/ShinyDemoApp")
setwd("C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/NHANESApp")
dir()

library(shiny)

# Show what Shiny is doing
runApp(display.mode='showcase')

# To deploy the app to https://www.shinyapps.io/applications
# deployApp()

# Set up authorized users (prompts for password)
# Do not set password on project!  Unable to reset authorization or delete app!
# Just delete passwords.txt ?  Seems to work.
# addAuthorizedUser("test")
# removeAuthorizedUser("test")
