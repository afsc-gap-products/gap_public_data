#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# ISSUES -----------------------------------------------------------------------

# [None at the moment]

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
# source('./code/find_itis_species_codes.R")
source('./code/data.R')

# Run analysis -----------------------------------------------------------------

source('./code/analysis.R')

# Check work -------------------------------------------------------------------
dir.create(path = paste0(dir_out, "/check/"))
rmarkdown::render(paste0("./code/check.Rmd"),
                  output_dir = dir_out,
                  output_file = paste0("./check/check.docx"))

