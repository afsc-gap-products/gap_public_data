
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

# functions --------------------------------------------------------------------

upload_to_oracle <- function(
    file_paths, 
    column_metadata, 
    channel_foss, 
    update_table = TRUE, 
    update_metadata = TRUE) {
  
  column_metadata$colname <- toupper(column_metadata$colname)
  
  all_schemas <- RODBC::sqlQuery(channel = channel_foss,
                                 query = paste0('SELECT * FROM all_users;'))
  
# Loop through each table to add to oracle -------------------------------------
  
  for (ii in 1:nrow(file_paths)) {
    
    print(file_paths$file_path[ii])
    file_name <- strsplit(x = file_paths$file_path[ii], split = "/", fixed = TRUE)[[1]]
    file_name <- strsplit(x = file_name[length(file_name)], split = ".", fixed = TRUE)
    file_name <- file_name[[1]][1]
    
    a <- read.csv(file_paths$file_path[ii])
    names(a) <- toupper(names(a))
    assign(x = file_name, value = a)
    
    names(a) <- toupper(names(a))
    
    if (update_table) {
    
    ## Drop old table from oracle -------------------------------------------------
    # if the table is currently in the schema, drop the table before re-uploading
    if (file_name %in% 
        unlist(RODBC::sqlQuery(channel = channel_foss, 
                               query = "SELECT table_name FROM user_tables;"))) {
      RODBC::sqlDrop(channel = channel_foss,
                     sqtable = file_name)
    }
    
    ## Add the table to the schema ------------------------------------------------
    eval( parse(
      text = paste0("RODBC::sqlSave(channel = channel_foss,
                 dat = ",file_name,")") ))
    }
    
    if (update_metadata) {
    ## Add column metadata --------------------------------------------------------
    column_metadata0 <- column_metadata[which(column_metadata$colname %in% names(a)),]
    if (nrow(column_metadata0)>0) {
      for (i in 1:nrow(column_metadata0)) {
        
        desc <- gsub(pattern = "<sup>2</sup>",
                     replacement = "2",
                     x = column_metadata0$colname_desc[i], fixed = TRUE)
        short_colname <- gsub(pattern = "<sup>2</sup>", replacement = "2",
                              x = column_metadata0$colname[i], fixed = TRUE)
        
        RODBC::sqlQuery(channel = channel_foss,
                        query = paste0('comment on column RACEBASE_FOSS.',file_name,'.',
                                       short_colname,' is \'',
                                       desc, ". ", # remove markdown/html code
                                       gsub(pattern = "'", replacement ='\"',
                                            x = column_metadata0$desc[i]),'\';'))
        
      }
    }
    ## Add table metadata ---------------------------------------------------------
    RODBC::sqlQuery(channel = channel_foss,
                    query = paste0('comment on table RACEBASE_FOSS.',file_name,
                                   ' is \'',
                                   file_paths$table_metadata[ii],'\';'))
    }
    ## grant access to all schemes ------------------------------------------------
    for (iii in 1:length(sort(all_schemas$USERNAME))) {
      RODBC::sqlQuery(channel = channel_foss,
                      query = paste0('grant select on RACEBASE_FOSS.',file_name,
                                     ' to ', all_schemas$USERNAME[iii],';'))
    }
    
  }
}

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

column_metadata <- readr::read_csv(file = paste0(dir_out, "column_metadata.csv"))

file_paths <- data.frame(
  file_path = 
  # c(paste0(paste0(getwd(), "/data/"), 
  #          c("TAXON_CONFIDENCE", 
  #            paste0("AFSC_ITIS_WORMS", option)), 
  #          ".csv"), 
    paste0(dir_out, 
         c("TAXON_CONFIDENCE", 
           "AFSC_ITIS_WORMS",
           "JOIN_FOSS_CPUE_COMB", 
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
  paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_table_metadata.txt")), collapse="\n"), 
  # paste(readLines(con = paste0(dir_out, "FOSS_CPUE_PRESONLY_table_metadata.txt")), collapse="\n"), 
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_table_metadata.txt")), collapse="\n")) 
)

# file_paths <- file_paths[-1,]

upload_to_oracle(
  # update_metadata = FALSE, 
  update_table = FALSE,
    file_paths = file_paths, 
    column_metadata = column_metadata, 
    channel_foss = channel_foss)
