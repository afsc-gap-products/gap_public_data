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


# DOWNLOAD CPUE ----------------------------------------------------------------

locations<-c(
  "GOA.CPUE", 
  "AI.CPUE", 
  "HAEHNR.cpue_nbs", 
  "HAEHNR.cpue_ebs_plusnw", 
  "HAEHNR.cpue_ebs_plusnw_grouped"
)

oracle_dl(
  locations = locations, 
  channel = channel, 
  dir_out = paste0(dir_data, "/oracle_check/"))
