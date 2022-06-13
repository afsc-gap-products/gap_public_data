#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# source("./code/run.R")

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

taxize0 <- TRUE # incorporate species codes from databases

# Support scripts --------------------------------------------------------------

# source('./code/data_dl.R')
source('./code/functions.R')
if (taxize0) { # only if you need to rerun {taxize} stuff - very time intensive!
  source('./code/find_taxize_species_codes.R')
}
source('./code/data.R')

# Run analysis -----------------------------------------------------------------

source('./code/analysis.R')

# Check work -------------------------------------------------------------------

# source('./code/data_dl_check.R')

# dir.create(path = paste0(dir_out, "/check/"))
# rmarkdown::render(paste0("./code/check.Rmd"),
#                   output_dir = dir_out,
#                   output_file = paste0("./check/check.docx"))

