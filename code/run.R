#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# source("./code/run.R")

# NOTES -----------------------------------------------------------------------

# Each year you will need to: 
# - download the new data using the data_dl.R script
# - aquire the new taxonomic_confidence tables. Contact D Stevenson. 
# - run the find_taxize_species_codes.R script to find the appropriate and most up to date ITIS and WoRMS codes for species. 
# - run the check to compare this year's data to last years. Make sure the data are similar and look right! 

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

taxize0 <- FALSE # incorporate species codes from databases

# Support scripts --------------------------------------------------------------

# source('./code/data_dl.R')
source('./code/functions.R')
source("https://raw.githubusercontent.com/afsc-gap-products/metadata/main/code/functions_oracle.R")

option <- 3 # used in find_taxize_species_codes 
if (taxize0) { # only if you need to rerun {taxize} stuff - very time intensive!
  source('./code/find_taxize_species_codes.R')
  source('./code/find_taxon_confidence.R')
}
# taxize0 <- TRUE
source('./code/data.R')
source('./code/calc_cpue.R')

# Check work -------------------------------------------------------------------

# source('./code/data_dl_check.R')

# dir.create(path = paste0(dir_out, "/check/"))
# rmarkdown::render(paste0("./code/check.Rmd"),
#                   output_dir = dir_out,
#                   output_file = paste0("./check/check.docx"))

# Update README ----------------------------------------------------------------

source('./code/functions.R')
dir_out <- paste0(getwd(), "/output/2023-01-21/")
link_code_books <- "https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual"

load(paste0(dir_out, "FOSS_CPUE_PRESONLY.RData"))
load(paste0(dir_out, "FOSS_CPUE_JOIN.RData"))
load(paste0(dir_out, "FOSS_CPUE_ZEROFILLED.RData"))
rmarkdown::render(paste0("./README.Rmd"),
                  output_dir = "./",
                  output_file = paste0("README.md"))

# Share table to oracle --------------------------------------------------------

source("./code/oracle_upload.R") 
