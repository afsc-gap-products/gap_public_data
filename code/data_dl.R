#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------



# This has a specific username and password because I DONT want people to have access to this!
# source("C:/Users/emily.markowitz/Work/Projects/ConnectToOracle.R")
# source("C:/Users/emily.markowitz/Documents/Projects/ConnectToOracle.R")
source("Z:/Projects/ConnectToOracle.R")

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
  #General Tables of data
  "RACEBASE.CATCH", 
  "RACEBASE.HAUL", 
  "RACE_DATA.V_CRUISES",
  # "RACEBASE.SPECIES", 
  # "RACE_DATA.SPECIES_TAXONOMICS", 
  # "RACEBASE.SPECIES_CLASSIFICATION",
  "RACE_DATA.VESSELS", 
  "GAP_PRODUCTS.METADATA_TABLE", 
  "GAP_PRODUCTS.METADATA_COLUMN", 
  "GAP_PRODUCTS.OLD_TAXON_CONFIDENCE"
)

oracle_dl(
  locations = locations, 
  channel = channel, 
  dir_out = "./data/oracle/")

