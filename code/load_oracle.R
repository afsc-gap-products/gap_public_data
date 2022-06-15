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
RODBC::sqlDrop(channel = channel_foss, sqtable = "racebase_public_foss")
RODBC::sqlSave(channel = channel_foss, 
               dat = cpue_station, 
               tablename = "racebase_public_foss")

column_metadata0 <- column_metadata
for (i in 1:nrow(column_metadata0)) {
  
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('comment on column "RACEBASE_FOSS"."racebase_public_foss"."',
                                 column_metadata0$colname[i],'" is \'', 
                                 column_metadata0$colname_desc[i], ". ", 
                                 gsub(pattern = "'", replacement ='\"', x = column_metadata0$desc[i]),'\';'))
  
}

RODBC::sqlQuery(channel = channel_foss,
                query = paste0('comment on table "RACEBASE_FOSS"."racebase_public_foss" is \'',table_metadata,'\';'))
