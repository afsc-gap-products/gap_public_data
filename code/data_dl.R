#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

# This has a specific username and password because I DONT want people to have access to this!
locations <- c("Z:/Projects/ConnectToOracle.R", 
               "C:/Users/emily.markowitz/Documents/Projects/ConnectToOracle.R")
for (i in 1:length(locations)){
  if (file.exists(locations[i])) {source(locations[i])}
}

# I set up a ConnectToOracle.R that looks like this: 
#   
#   PKG <- c("RODBC")
# for (p in PKG) {
#   if(!require(p,character.only = TRUE)) {  
#     install.packages(p)
#     require(p,character.only = TRUE)}
# }
# 
# channel<-odbcConnect(dsn = "AFSC",
#                      uid = "USERNAME", # change
#                      pwd = "PASSWORD", #change
#                      believeNRows = FALSE)
# 
# odbcGetInfo(channel)


# Dowload oracle data ----------------------------------------------------------

locations <- c(
  "RACEBASE.CATCH", 
  "RACEBASE.HAUL", 
  "RACE_DATA.V_CRUISES",
  "RACE_DATA.VESSELS", 
  "GAP_PRODUCTS.METADATA_TABLE", 
  "GAP_PRODUCTS.METADATA_COLUMN", 
  "GAP_PRODUCTS.OLD_V_TAXONOMICS",  # "RACEBASE.SPECIES", "RACE_DATA.SPECIES_TAXONOMICS", "RACEBASE.SPECIES_CLASSIFICATION", # replaced with new taxonomic tables
  "GAP_PRODUCTS.OLD_TAXON_CONFIDENCE", 
  "GAP_PRODUCTS.OLD_TAXONOMICS_WORMS", 
  "GAP_PRODUCTS.OLD_TAXONOMICS_ITIS"
)

oracle_dl(
  locations = locations, 
  channel = channel, 
  dir_out = paste0(dir_data, "/oracle/"))

locations <- c("GAP_PRODUCTS.OLD_TAXONOMICS_WORMS", 
               "GAP_PRODUCTS.OLD_TAXONOMICS_ITIS")

oracle_dl_metadata(
  locations = locations, 
  channel = channel, 
  dir_out = paste0(dir_data, "/oracle/"))
