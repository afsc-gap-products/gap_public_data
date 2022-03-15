#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-03-01
#' Notes: 
#' ---------------------------------------------

# ISSUES ----------------------------------------------------------------------

# round cpue to .0001 and if positivie but less than 0.0001 = 0.0001?
# remove data observations where spp count and weight are 0
# including Mike Litzow and SAP into process - should we use retow data to replace data where retows were done??
# summarize data in RACEBASE.HAUL by species_code or keep catchjoin? What does catchjoin mean?
# why are there NAs in the old public data stations? What use does that serve?
# Here I summarize by srvy, cruise, stratum, station, haul, and vessel_id - why are there stations in the same survey year with different haul numbers?

# START ------------------------------------------------------------------------

# *** REPORT KNOWNS ------------------------------------------------------------

maxyr <- 2021

# The surveys we will consider covering
surveys <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSSlope"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope") )

use_catchjoin <- FALSE
dir_out <- paste0("./output/", Sys.Date(),"/")

# *** SOURCE SUPPORT SCRIPTS ---------------------------------------------------

# source('./code/dataDL.R')
source('./code/functions.R')
source('./code/data.R')
# source('./code/data_catchjoin.R')

# Run Analysis -----------------------------------------------------------------


if (FALSE) {
  source('./code/analysis.R')
  # source('./code/analysis_catchjoin.R')
# } else {
#   data_new <- readr::read_csv(
#     file = paste0(dir_out, "cpue_biomass_station.csv"))
}

# Check work -------------------------------------------------------------------

rmarkdown::render(paste0("./code/check.Rmd"),
                  output_dir = dir_out,
                  output_file = paste0("check.docx"))

