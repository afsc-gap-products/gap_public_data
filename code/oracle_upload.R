
# Connect to Oracle ------------------------------------------------------------

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

# Upload data to oracle! -------------------------------------------------------

file_paths <- data.frame(
  file_path = 
    paste0(dir_out,
           c("taxon_search_groups", 
             "JOIN_FOSS_CPUE_HAUL",
             "JOIN_FOSS_CPUE_CATCH",
             "FOSS_CPUE_ZEROFILLED", 
             "TAXONOMICS_ITIS", 
             "TAXONOMICS_WORMS"),
           ".csv"), 
  "table_metadata" = c(
    paste(readLines(con = paste0(dir_out, "taxon_search_groups_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_metadata_table.txt")), collapse="\n"),
    paste0("DUPLICATE, added to schema on ", Sys.Date(), ". "),
    paste0("DUPLICATE, added to schema on ", Sys.Date(), ". ") 
  ) 
)

metadata_column <- readr::read_csv(paste0(dir_data, "/oracle/gap_products_metadata_column.csv")) 

for (i in 1:nrow(file_paths)){
  oracle_upload(
    # update_metadata = FALSE, 
    # update_table = FALSE,
    file_path = file_paths$file_path[i], 
    metadata_table = file_paths$metadata_table[i], 
    metadata_column = metadata_column, 
    channel = channel_foss, 
    schema = "RACEBASE_FOSS")
}