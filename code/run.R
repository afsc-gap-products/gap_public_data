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

link_foss <- "https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::"
link_code_books <- "https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual"
link_repo <- "https://github.com/afsc-gap-products/gap_public_data"

# The surveys we will consider covering in this data are: 
surveys <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSS"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope") )

taxize0 <- FALSE# incorporate species codes from databases

# Support scripts --------------------------------------------------------------

# source('./code/data_dl.R')
source('./code/functions.R')

option <- 3
if (taxize0) { # only if you need to rerun {taxize} stuff - very time intensive!
  source('./code/find_taxize_species_codes.R')
  source('./code/find_taxon_confidence.R')
}
# taxize0 <- TRUE
source('./code/data.R')

# Run analysis -----------------------------------------------------------------

source('./code/analysis.R')

# Check work -------------------------------------------------------------------

# source('./code/data_dl_check.R')

# dir.create(path = paste0(dir_out, "/check/"))
# rmarkdown::render(paste0("./code/check.Rmd"),
#                   output_dir = dir_out,
#                   output_file = paste0("./check/check.docx"))

# Update README ----------------------------------------------------------------

dir_out <- "./output/2022-12-10/"
load(paste0(dir_out, "cpue_station_0filled.RData"))

rmarkdown::render(paste0("./README.Rmd"),
                  output_dir = "./",
                  output_file = paste0("README.md"))

# Share table to oracle --------------------------------------------------------

# cpue_station <- readr::read_csv(file = paste0("./output/2022-06-10/cpue_station.csv"))
source("./code/load_oracle.R")

