#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------



# This has a specific username and password because I DONT want people to have access to this!
# source("C:/Users/emily.markowitz/Work/Projects/ConnectToOracle.R")
source("C:/Users/emily.markowitz/Documents/Projects/ConnectToOracle.R")

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


##################DOWNLOAD CPUE and BIOMASS EST##################################

locations<-c(
  # Tbles to compare to
  "GOA.CPUE", 
  "AI.CPUE", 
  "HAEHNR.cpue_nbs", 
  "HAEHNR.cpue_ebs_plusnw", 
  "HAEHNR.cpue_ebs_plusnw_grouped"
)

#sinks the data into connection as text file
sink("./data/metadata.txt")

print(Sys.Date())

for (i in 1:length(locations)){
  print(locations[i])
  if (locations[i] == "RACEBASE.HAUL") { # that way I can also extract TIME
    
    a<-RODBC::sqlQuery(channel, paste0("SELECT * FROM ", locations[i]))
    
    a<-RODBC::sqlQuery(channel, 
                       paste0("SELECT ",
                              paste0(names(a)[names(a) != "START_TIME"], 
                                     sep = ",", collapse = " "),
                              " TO_CHAR(START_TIME,'MM/DD/YYYY HH24:MI:SS') START_TIME  FROM ", 
                              locations[i]))
  } else {
    a<-RODBC::sqlQuery(channel, paste0("SELECT * FROM ", locations[i]))
  }
  
  if (locations[i] == "AI.CPUE") {
    filename <- "cpue_ai"
  } else if (locations[i] == "GOA.CPUE") {
    filename <- "cpue_goa"
  } else {
    filename <- tolower(strsplit(x = locations[i], 
                                 split = ".", 
                                 fixed = TRUE)[[1]][2])
  }
  
  write.csv(x=a, 
            paste0("./data/oracle/",
                   filename,
                   ".csv"))
  remove(a)
}

sink()


