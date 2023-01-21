
# Connect to Oracle ------------------------------------------------------------

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

# Upload data to oracle! -------------------------------------------------------

file.copy(
  from = paste0(getwd(), "/data/AFSC_ITIS_WORMS",option,".csv"),
  to = paste0(dir_out, "AFSC_ITIS_WORMS.csv"),
  overwrite = TRUE)

file.copy(
  from = paste0(getwd(), "/data/AFSC_ITIS_WORMS_table_metadata.txt"),
  to = paste0(dir_out, "AFSC_ITIS_WORMS_table_metadata.txt"),
  overwrite = TRUE)

file.copy(
  from = paste0(getwd(), "/data/TAXON_CONFIDENCE.csv"),
  to = paste0(dir_out, "TAXON_CONFIDENCE.csv"),
  overwrite = TRUE)

file.copy(
  from = paste0(getwd(), "/data/TAXON_CONFIDENCE_table_metadata.txt"),
  to = paste0(dir_out, "TAXON_CONFIDENCE_table_metadata.txt"),
  overwrite = TRUE)

metadata_column <- readr::read_csv(file = paste0(dir_out, "metadata_column.csv"))

file_paths <- data.frame(
  file_path = 
  # c(paste0(paste0(getwd(), "/data/"), 
  #          c("TAXON_CONFIDENCE", 
  #            paste0("AFSC_ITIS_WORMS", option)), 
  #          ".csv"), 
    paste0(dir_out, 
         c("TAXON_CONFIDENCE", 
           "AFSC_ITIS_WORMS",
           "JOIN_FOSS_CPUE_CATCH", 
           "JOIN_FOSS_CPUE_HAUL", 
           # "FOSS_CPUE_PRESONLY", 
           "FOSS_CPUE_ZEROFILLED"), 
         ".csv"), 
  "table_metadata" = c(
  paste(readLines(con = paste0(dir_out, "TAXON_CONFIDENCE_table_metadata.txt")), collapse="\n"), 
  paste(readLines(con = paste0(dir_out, "AFSC_ITIS_WORMS_table_metadata.txt")), collapse="\n"), 
  paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_table_metadata.txt")), collapse="\n"), 
  paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_table_metadata.txt")), collapse="\n"), 
  # paste(readLines(con = paste0(dir_out, "FOSS_CPUE_PRESONLY_table_metadata.txt")), collapse="\n"), 
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_table_metadata.txt")), collapse="\n")) 
)

# file_paths <- file_paths[-1,]

upload_to_oracle(
  # update_metadata = FALSE, 
  # update_table = FALSE,
    file_paths = file_paths, 
    metadata_column = metadata_column, 
    channel = channel_foss, 
    schema = "RACEBASE_FOSS")
