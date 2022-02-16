#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' start date: 2022-01-01
#' last modified: 2022-03-01
#' Notes: 
#' ---------------------------------------------

# ISSUES
# where do I get YYY/MM/DD HH:MM? I have YYY/MM/DD
# do I need to group any species?
# unid. vs undent. in the racebase.species_classification oracle table
# is the final _startum data 0 filled? Should it be zero filled? e.g., an entry of 0 for stations/hauls where a spp wasnt found
# round cpue to .0001 and if positivie but less than 0.0001 = 0.0001?

# remove data observations where spp count and weight are 0

# START ------------------------------------------------------------------------

# *** REPORT KNOWNS ------------------------------------------------------------

maxyr <- 2021 

# The surveys we will consider covering
survey_data <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSSlope"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope"))

# for (i in 1:) {
# a <- paste0(akgfmaps::get_base_layers(select.region = "ebs")$survey.strata$Stratum, ", ", collapse = "")
# # a<-a[1:(nchar(a)-2)]
# }

# *** SOURCE SUPPORT SCRIPTS ---------------------------------------------------

source('./code/functions.R')

# source('./code/dataDL.R')

dir_out <- paste0("./output/", Sys.Date(),"/")

# Run Analysis -----------------------------------------------------------------


if (FALSE) {
  source('./code/data.R')
  source('./code/analysis.R')
} else {
  data_new <- readr::read_csv(file = paste0(dir_out, "cpue_biomass_station.csv"))
}

# Check work -------------------------------------------------------------------

rmarkdown::render(paste0("./code/check.Rmd"),
                  output_dir = dir_out,
                  output_file = paste0("check.pdf"))


