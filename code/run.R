#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-03-01
#' Notes: 
#' -----------------------------------------------------------------------------

# ISSUES -----------------------------------------------------------------------

# round cpue to .0001 and if positivie but less than 0.0001 = 0.0001?
# including Mike Litzow and SAP into process - should we use retow data to replace data where retows were done??
# how does this work with/conflict with Megsie's design-based-indies project?

# START ------------------------------------------------------------------------

# *** REPORT KNOWNS ------------------------------------------------------------

# The surveys we will consider covering in this data are: 
surveys <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSS"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope") )

# Support scripts --------------------------------------------------------------

# source('./code/dataDL.R')
source('./code/functions.R')
source('./code/data.R')

# Run analysis -----------------------------------------------------------------

source('./code/analysis.R')

# Check work -------------------------------------------------------------------

rmarkdown::render(paste0("./code/check.Rmd"),
                  output_dir = dir_out,
                  output_file = paste0("check.docx"))

