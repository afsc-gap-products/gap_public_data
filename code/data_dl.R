#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------



# This has a specific username and password because I DONT want people to have access to this!
# source("C:/Users/emily.markowitz/Work/Projects/ConnectToOracle.R")
source("C:/Users/emily.markowitz/Documents/Projects/ConnectToOracle.R")

##################DOWNLOAD CPUE and BIOMASS EST##################################

locations<-c(
  #General Tables of data
  "RACEBASE.CATCH", 
  "RACEBASE.HAUL", 
  "RACEBASE.STRATUM", 
  "RACE_DATA.V_CRUISES",
  # "RACEBASE.SPECIES_CLASSIFICATION", 
  "RACEBASE.SPECIES", 
  "RACE_DATA.VESSELS"
)

#sinks the data into connection as text file
sink("./data/metadata.txt")

print(Sys.Date())

for (i in 1:length(locations)){
  print(locations[i])
  a<-RODBC::sqlQuery(channel, paste0("SELECT * FROM ", locations[i]))
  write.csv(x=a, 
            paste0("./data/",
                   tolower(strsplit(x = locations[i], 
                                    split = ".", 
                                    fixed = TRUE)[[1]][2]),
                   ".csv"))
  remove(a)
}

sink()


