
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
         c("JOIN_FOSS_CPUE_HAUL", 
           "JOIN_FOSS_CPUE_CATCH", 
           "FOSS_CPUE_ZEROFILLED"), 
         ".csv"), 
  "table_metadata" = c(
  paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"),
  paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"), 
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_metadata_table.txt")), collapse="\n")) 
)

metadata_column <- readr::read_csv(paste0(dir_data, "/oracle/gap_products_metadata_column.csv")) 

metadata_column$METADATA_DATATYPE[metadata_column$METADATA_COLNAME == "date_time"] <- 
  'TO_CHAR(\\"MM/DD/YYYY HH24:MI:SS\\")'

oracle_upload(
  # update_metadata = FALSE, 
  # update_table = FALSE,
    file_paths = file_paths, 
    metadata_column = metadata_column, 
    channel = channel_foss, 
    schema = "RACEBASE_FOSS")


oracle_upload <- function(
    file_paths, 
    metadata_column = data.frame(
      metadata_colname = "DUMMY", 
      metadata_colname_long = "example dummy column", 
      metadata_units = "text", 
      metadata_datatype = "VARCHAR2(225 BYTE)", 
      metadata_colname_desc = "dummy."), 
    channel, 
    schema, 
    update_table = TRUE, 
    update_metadata = TRUE,
    share_with_all_users = TRUE) {
  
  names(metadata_column) <- tolower(names(metadata_column))
  metadata_column$metadata_colname <- toupper(metadata_column$metadata_colname)
  
  all_schemas <- RODBC::sqlQuery(channel = channel,
                                 query = paste0('SELECT * FROM all_users;'))
  
  # Loop through each table to add to oracle -------------------------------------
  
  for (ii in 1:nrow(file_paths)) {
    
    print(file_paths$file_path[ii])
    file_name <- trimws(toupper(file_paths$file_path[ii]))
    file_name <- strsplit(x = file_name, split = "/", fixed = TRUE)[[1]]
    file_name <- strsplit(x = file_name[length(file_name)], split = ".", fixed = TRUE)
    file_name <- file_name[[1]][1]
    
    a <- read.csv(file_paths$file_path[ii])
    names(a) <- toupper(names(a))
    
    if (names(a)[1] %in% "X") {
      a$X<-NULL
    }
    
    rownames(a) <- NULL
    names(a) <- toupper(names(a))
    
    assign(x = file_name, value = a)
    
    if (update_table) {
      
      ## Drop old table from oracle -------------------------------------------------
      # if the table is currently in the schema, drop the table before re-uploading
      
      if (file_name %in% 
          unlist(RODBC::sqlQuery(channel = channel, 
                                 query = "SELECT table_name FROM user_tables;"))) {
        
        RODBC::sqlDrop(channel = channel,
                       sqtable = file_name)
      }
      
      ## Add the table to the schema ------------------------------------------------
      
      # find columns that need special data type help
      metadata_column0 <- metadata_column[which(metadata_column$metadata_colname %in% names(a)),] %>% 
        dplyr::filter(!is.na(metadata_units))
      
      if (nrow(metadata_column0)>0) {
        eval( parse(text = 
                      paste0("cc <- list(", 
                             paste0("'", metadata_column0$metadata_colname, "' = '", 
                                    metadata_column0$metadata_datatype, "'", 
                                    collapse = ",\n"), 
                             ")") ))
      }
      
      cc$DATE_TIME <- "TIMESTAMP" # "TO_DATE(DATE_TIME, 'MM/DD/YYYY HH24:MI:SS')"
      eval( parse(text = 
                    paste0("RODBC::sqlSave(channel = channel, dat = ",
                           file_name, 
                           ifelse(length(cc)==0, 
                                  ")", 
                                  paste0(", varTypes = cc)") )) ) ) 
    }
    
    if (update_metadata) {
      ## Add column metadata --------------------------------------------------------
      metadata_column0 <- metadata_column[which(metadata_column$metadata_colname %in% names(a)),]
      if (nrow(metadata_column0)>0) {
        for (i in 1:nrow(metadata_column0)) {
          
          desc <- gsub(pattern = "<sup>2</sup>",
                       replacement = "2",
                       x = metadata_column0$metadata_colname_long[i], fixed = TRUE)
          short_colname <- gsub(pattern = "<sup>2</sup>", replacement = "2",
                                x = metadata_column0$metadata_colname[i], fixed = TRUE)
          
          RODBC::sqlQuery(channel = channel,
                          query = paste0('comment on column ',schema,'.',file_name,'.',
                                         short_colname,' is \'',
                                         desc, ". ", # remove markdown/html code
                                         gsub(pattern = "'", replacement ='\"',
                                              x = metadata_column0$metadata_colname_desc[i]),'\';'))
          
        }
      }
      ## Add table metadata ---------------------------------------------------------
      RODBC::sqlQuery(channel = channel,
                      query = paste0('comment on table ',schema,'.', file_name,
                                     ' is \'',
                                     file_paths$table_metadata[ii],'\';'))
    }
    ## grant access to all schemes ------------------------------------------------
    for (iii in 1:length(sort(all_schemas$USERNAME))) {
      RODBC::sqlQuery(channel = channel,
                      query = paste0('grant select on ',schema,'.',file_name,
                                     ' to ', all_schemas$USERNAME[iii],';'))
    }
    
  }
}
