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

# Test -----------------------------------------------------------------------
# RODBC::sqlDrop(channel = channel_foss, sqtable = "USArrests")
# USArrests0<-USArrests
# RODBC::sqlSave(channel = channel_foss, dat = USArrests0, tablename = "USArrests", rownames = "state", addPK = TRUE)
# USArrests0$Murder<-NA
# # RODBC::sqlUpdate(channel = channel_foss, dat = USArrests0, tablename = "USArrests", index = "Murder")
# RODBC::sqlQuery(channel = channel_foss,
#                 query = paste0('comment on column "RACEBASE_FOSS"."USArrests"."Assault" is \'get out!\';'))


# Upload data to oracle! -----------------------------

## 0 filled --------------------------------------------------------------------
print("0-filled")
load(file = paste0(dir_out, "cpue_station_0filled.RData"))
FOSS_CPUE_ZEROFILLED <- cpue_station_0filled
names(FOSS_CPUE_ZEROFILLED) <- toupper(names(FOSS_CPUE_ZEROFILLED))
column_metadata$colname <- toupper(column_metadata$colname)

RODBC::sqlDrop(channel = channel_foss,
               sqtable = "FOSS_CPUE_ZEROFILLED")

RODBC::sqlSave(channel = channel_foss,
               # tablename = "RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED",
               dat = FOSS_CPUE_ZEROFILLED)

column_metadata0 <- column_metadata
for (i in 1:nrow(column_metadata0)) {

  desc <- gsub(pattern = "<sup>2</sup>",
               replacement = "2",
               x = column_metadata0$colname_desc[i], fixed = TRUE)
  short_colname <- gsub(pattern = "<sup>2</sup>", replacement = "2",
                        x = column_metadata0$colname[i], fixed = TRUE)

  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('comment on column RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED.',
                                 short_colname,'" is \'',
                                 desc, ". ", # remove markdown/html code
                                 gsub(pattern = "'", replacement ='\"',
                                      x = column_metadata0$desc[i]),'\';'))

}

RODBC::sqlQuery(channel = channel_foss,
                query = paste0('comment on table RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED is \'',
                               table_metadata,'\';'))

## spp info --------------------------------------------------------------------
print("spp info")
load(file = "./data/spp_info.rdata")
AFSC_ITIS_WORMS <- spp_info
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = 'AFSC_ITIS_WORMS')

RODBC::sqlSave(channel = channel_foss,
               dat = AFSC_ITIS_WORMS, addPK=TRUE,
               # tablename = 'AFSC_ITIS_WORMS',
               fast = TRUE)

# dat2 <- RODBC::sqlQuery(channel = channel_foss, 
#                         query = 'SELECT * FROM "RACEBASE_FOSS"."AFSC_ITIS_WORMS"')
# 
# dat1 <- RODBC::sqlQuery(channel = channel_foss,
#                         query = 'SELECT * FROM RACEBASE_FOSS.AFSC_ITIS_WORMS')

# RODBC::sqlQuery(channel = channel_foss,
#                 query = paste0('CREATE TABLE RACEBASE_FOSS.AFSC_ITIS_WORMS;'))


## taxon conf ------------------------------------------------------------------
print("taxon conf")
load(file = paste0("./data/taxon_confidence.rdata"))
TAXON_CONFIDENCE <- tax_conf 
RODBC::sqlDrop(channel = channel_foss, 
               sqtable = "TAXON_CONFIDENCE")

RODBC::sqlSave(channel = channel_foss,
               # tablename = "TAXON_CONFIDENCE", 
               dat = TAXON_CONFIDENCE)

dat1 <- RODBC::sqlQuery(channel = channel_foss,
                        query = 'SELECT * FROM RACEBASE_FOSS.TAXON_CONFIDENCE')

# Grant access to data to all schemas ------------------------------------------

# RODBC::sqlQuery(channel = channel_foss,
#                 query = paste0('grant select on "RACEBASE_FOSS"."FOSS" to markowitze;'))

all_schemas <- RODBC::sqlQuery(channel = channel_foss,
                query = paste0('SELECT * FROM all_users;'))
for (i in 1:length(sort(all_schemas$USERNAME))) {
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('grant select on RACEBASE_FOSS.AFSC_ITIS_WORMS to ', 
                                 all_schemas$USERNAME[i],';'))
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('grant select on RACEBASE_FOSS.TAXON_CONFIDENCE to ',
                                 all_schemas$USERNAME[i],';'))
  RODBC::sqlQuery(channel = channel_foss,
                  query = paste0('grant select on RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED to ',
                                 all_schemas$USERNAME[i],';'))
}

