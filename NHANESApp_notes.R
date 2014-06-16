# NHANESApp notes and utility code
# Don't run this, just cut and paste
# Seems important to test with local environment cleared.
# App is at https://rseiter.shinyapps.io/NHANESApp/

# Helpful
library(shinyapps)
accountInfo(accounts())
deployApp(appDir = "C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/NHANESApp")
#deployApp(appDir = "C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/NHANESApp1")


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
library(shinyapps)
# deployApp()
# Note problem with:
# Error: Unable to deploy package dependency 'rmarkdown' The package was
# installed from an unsupported repository 'RStudioIDE'. Only packages installed
# from CRAN or GitHub are supported.
# That was when wd was top level.  Be sure to be in NHANESApp dir.  Now getting:
# Error: /v1/applications/11542/upload 500 - Internal Server Error

# Set up authorized users (prompts for password)
# Do not set password on project!  Unable to reset authorization or delete app!
# Just delete passwords.txt ?  Seems to work.
# addAuthorizedUser("test")
# removeAuthorizedUser("test")



# slidify
# wd for this project
setwd("C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/slidify_example")

library(slidify)
slidify("index.Rmd")
library(knitr)
browseURL("index.html")
# publish_dropbox('Classes/DevDataProd/slidify_example') # Fiasco for me
# setwd('~/Dropbox/Public/Classes/DevDataProd')
# setwd('~')
# getwd()

# To publish (see assignment)
# http://slidify.org/publish.html
setwd("~/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/slidify_example")
library(slidify)
slidify("index.Rmd")#, save_payload=TRUE)
publish(user = "rseiter", repo = "DevDataProdProject")
# http://rseiter.github.io/DevDataProdProject
# See https://class.coursera.org/devdataprod-002/forum/thread?thread_id=59
# Try just publishing to Dropbox?  manually did not give usable page
# Rpubs Failed in RStudio with RCurl error
# http://rseiter.github.io/DevDataProdProject/index.html
# http://rseiter.github.io/NHANESAppDeck/index.html
# Finally got this one to work.  Why different?
# http://rseiter.github.io/testDeck/index.html

# Creating RData file to use here
setwd("C:/Users/rseiter/Documents/Health/Health Equations/NHANES_import_into_HEq_example")

# This file has various other fields (i.e. different format than I want)
#load("NHANES_misc.RData")

# This is basically what I want, created in Transforms.Rmd
# NHANES_names_use has NHANES field names
# NHANES_work has all the (complete for HEq?) NHANES data indexed by those names
# Just need to add text names with units for this project.
HEQ_dir <- "C:/Users/rseiter/Documents/Health/Health Equations/R/"
#load(paste0(HEQ_dir, "../NHANES_import_into_HEq_example/NHANES_caret.RData"))
# Above is not right, only 6067 obs vs 9282 obs (complete records vs all?)
# Below is what we want
load(paste0(HEQ_dir, "../NHANES_import_into_HEq_example/NHANES_import_into_HEq_example.RData"))

# This is a source of names_use data
# This is created by Create_example_data.R
# load("NHANES_import_into_HEq_example.RData")

# This is original file which I should edit to make changes
#HEQ_dir <- "C:/Users/rseiter/Documents/Health/Health Equations/R/"
field_names <- read.csv(file=paste(HEQ_dir, "heq_fields_save.csv", sep=""))
NHANES_names <- as.character(field_names$NHANES99)
NHANES_names_use <- NHANES_names[NHANES_names != ""]
NHANES_fields_text <- as.character(field_names$FullText)
NHANES_fields_text_use <- NHANES_fields_text[NHANES_names != ""]
NHANES_data <- NHANES_data[, NHANES_names_use]

# Create choice text here
NHANES_pulldown_choices <- paste(NHANES_fields_text_use, "-", NHANES_names_use)

# Save the data we want here
save(NHANES_names_use, NHANES_fields_text_use, NHANES_data, NHANES_pulldown_choices,
     file = "C:/Users/rseiter/Documents/Education/Coursera - Developing Data Products/Course Project/DevDataProdProject/NHANESApp/NHANES_1999.RData")

getwd()
# Take a look at the data we wrote
NHANES_data_file <- "NHANES_1999.RData"
load(file = NHANES_data_file)
# Look at other version
load(file = "NHANES_caret.RData")

