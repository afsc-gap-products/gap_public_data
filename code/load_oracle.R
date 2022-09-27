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

### Test -----------------------------------------------------------------------
# RODBC::sqlDrop(channel = channel_foss, sqtable = "USArrests")
# USArrests0<-USArrests
# RODBC::sqlSave(channel = channel_foss, dat = USArrests0, tablename = "USArrests", rownames = "state", addPK = TRUE)
# USArrests0$Murder<-NA
# # RODBC::sqlUpdate(channel = channel_foss, dat = USArrests0, tablename = "USArrests", index = "Murder")
# RODBC::sqlQuery(channel = channel_foss,
#                 query = paste0('comment on column "RACEBASE_FOSS"."USArrests"."Assault" is \'get out!\';'))


### what we came here for ------------------------------------------------------

# spp info
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = "afsc_itis_worms")

RODBC::sqlSave(channel = channel_foss, 
               dat = spp_info, 
               tablename = "afsc_itis_worms")

# taxon conf
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = "taxon_confidence")

RODBC::sqlSave(channel = channel_foss, 
               dat = tax_conf, 
               tablename = "taxon_confidence")

# public foss
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = "racebase_public_foss")

RODBC::sqlSave(channel = channel_foss, 
               dat = cpue_station, 
               tablename = "racebase_public_foss")


# public foss
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = "cpue_zerofilled")

RODBC::sqlSave(channel = channel_foss, 
               dat = cpue_station_0filled, 
               tablename = "cpue_zerofilled")

column_metadata0 <- column_metadata
for (i in 1:nrow(column_metadata0)) {
  
  desc <- gsub(pattern = "<sup>2</sup>", replacement = "2", x = column_metadata0$colname_desc[i], fixed = TRUE)
  short_colname <- gsub(pattern = "<sup>2</sup>", replacement = "2", x = column_metadata0$colname[i], fixed = TRUE)
  
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('comment on column "RACEBASE_FOSS"."racebase_public_foss"."',
                                 short_colname,'" is \'', 
                                 desc, ". ", # remove markdown/html code
                                 gsub(pattern = "'", replacement ='\"', x = column_metadata0$desc[i]),'\';'))
  
}

RODBC::sqlQuery(channel = channel_foss,
                query = paste0('comment on table "RACEBASE_FOSS"."racebase_public_foss" is \'',table_metadata,'\';'))

# Grant access to data to all schemas ------------------------------------------

# RODBC::sqlQuery(channel = channel_foss,
#                 query = paste0('grant select on "RACEBASE_FOSS"."racebase_public_foss" to markowitze;'))

all_schemas <- RODBC::sqlQuery(channel = channel_foss,
                query = paste0('SELECT * FROM all_users;'))
for (i in 1:length(sort(all_schemas$USERNAME))) {
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('grant select on "RACEBASE_FOSS"."racebase_public_foss" to ',all_schemas$USERNAME[i],';'))
}