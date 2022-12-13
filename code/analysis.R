#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Find Combinations for zero-fill ----------------------------------------------

# using a loop so we only make zero-filled for species that occred in a survey 
# (e.g., no 0s for a species that never occured in a survey)
# as it is a bit exessive
cpue_station_0filled_comb <- data.frame() 

for (i in 1:length(surveys$SRVY)) {
  
  # subset presence-only data to survey
temp <- catch_haul_cruises_vess %>% 
  dplyr::filter(SRVY == surveys$SRVY[i]) 

cpue_station_0filled_comb <- 
  tidyr::crossing( # create all possible haul event x species_code combinations
    temp %>% 
      dplyr::select(SRVY, hauljoin) %>% # unique haul event
      dplyr::distinct(),
    temp %>%
      dplyr::distinct(., species_code) %>%  # unique species_codes
      dplyr::distinct()) %>% 
  dplyr::bind_rows(cpue_station_0filled_comb, .)
}

# # Make sure that there are no NAs
# summary(cpue_station_0filled_comb %>% dplyr::mutate(SRVY = factor(SRVY)))
# SRVY             hauljoin        species_code  
# AI : 7224189   Min.   : -22026   Min.   :    1  
# BSS:  865632   1st Qu.: -12959   1st Qu.:30420  
# EBS:13371741   Median :  -4003   Median :71004  
# GOA:14532144   Mean   : 326327   Mean   :59345  
# NBS:  314324   3rd Qu.: 881428   3rd Qu.:80548  
#                Max.   :1225635   Max.   :99999  
#
# # Make sure that future version of this data in this script do not change the number of rows
# dim(cpue_station_0filled_comb)
# [1] 36308030        3

## Fill data -------------------------------------------------------------------
cpue_station_0filled <- cpue_station_0filled_comb %>%
  dplyr::left_join( # Add haul data
    x = ., 
    y = haul_cruises_vess %>% 
      dplyr::select(-region),
    by = c("hauljoin", "SRVY")) %>% 
  dplyr::left_join( # Add species info
    x = .,
    y = spp_info, 
    by = "species_code") %>%
  dplyr::left_join( # Add species info
    x = .,
    y = tax_conf %>% 
      dplyr::select(year, tax_conf, SRVY, species_code), 
    by = c("year", "SRVY", "species_code")) %>%
  dplyr::left_join( # overwrite NAs where data exists for CPUE calculation
    x = .,
    y = catch %>%
      dplyr::select(species_code, hauljoin, 
                    weight, number_fish),
    by = c("species_code", "hauljoin")) 


# # Make sure that there are no NAs
# summary(cpue_station_0filled %>% dplyr::mutate(SRVY = factor(SRVY)))
# SRVY             hauljoin        species_code     cruisejoin          vessel      survey_definition_id  SRVY_long        
# AI : 7224189   Min.   : -22026   Min.   :    1   Min.   :   -758   Min.   :  1.0   Min.   : 47.00       Length:36308030   
# BSS:  865632   1st Qu.: -12959   1st Qu.:30420   1st Qu.:   -687   1st Qu.: 88.0   1st Qu.: 47.00       Class :character  
# EBS:13371741   Median :  -4003   Median :71004   Median :   -612   Median : 94.0   Median : 52.00       Mode  :character  
# GOA:14532144   Mean   : 326327   Mean   :59345   Mean   : 331189   Mean   :110.4   Mean   : 68.35                         
# NBS:  314324   3rd Qu.: 881428   3rd Qu.:80548   3rd Qu.: 881075   3rd Qu.:147.0   3rd Qu.: 98.00                         
# Max.   :1225635   Max.   :99999   Max.   :1225395   Max.   :178.0   Max.   :143.00                         
# 
# survey_name             year          cruise         haul_type  stationid            stratum           haul        start_time       
# Length:36308030    Min.   :1982   Min.   :198201   Min.   :3   Length:36308030    Min.   : 10.0   Min.   :  1.0   Length:36308030   
# Class :character   1st Qu.:1997   1st Qu.:199701   1st Qu.:3   Class :character   1st Qu.: 31.0   1st Qu.: 59.0   Class :character  
# Mode  :character   Median :2005   Median :200501   Median :3   Mode  :character   Median : 61.0   Median :117.0   Mode  :character  
# Mean   :2005   Mean   :200518   Mean   :3                      Mean   :151.6   Mean   :122.8                     
# 3rd Qu.:2013   3rd Qu.:201301   3rd Qu.:3                      3rd Qu.:214.0   3rd Qu.:177.0                     
# Max.   :2022   Max.   :202202   Max.   :3                      Max.   :794.0   Max.   :355.0                     
# 
# start_latitude  start_longitude   end_latitude   end_longitude     bottom_depth  gear_temperature  surface_temperature  performance   
# Min.   :51.19   Min.   :-180.0   Min.   :51.20   Min.   :-180.0   Min.   :   9   Min.   :-2.1      Min.   :-1.1        Min.   :0.000  
# 1st Qu.:54.38   1st Qu.:-170.1   1st Qu.:54.38   1st Qu.:-170.1   1st Qu.:  72   1st Qu.: 3.2      1st Qu.: 5.8        1st Qu.:0.000  
# Median :56.77   Median :-163.4   Median :56.78   Median :-163.4   Median : 110   Median : 4.3      Median : 7.6        Median :0.000  
# Mean   :56.46   Mean   :-132.8   Mean   :56.46   Mean   :-132.9   Mean   : 144   Mean   : 4.1      Mean   : 8.0        Mean   :0.302  
# 3rd Qu.:58.65   3rd Qu.:-152.0   3rd Qu.:58.65   3rd Qu.:-152.0   3rd Qu.: 170   3rd Qu.: 5.4      3rd Qu.: 9.6        3rd Qu.:0.000  
# Max.   :65.34   Max.   : 180.0   Max.   :65.35   Max.   : 180.0   Max.   :1200   Max.   :15.3      Max.   :18.1        Max.   :7.000  
# NA's   :4092    NA's   :4092                    NA's   :1393764   NA's   :801519                     
# duration      distance_fished   net_width       net_height      vessel_name        scientific_name         itis        
# Min.   :0.0250   Min.   :0.135   Min.   : 7.51   Min.   : 0.0      Length:36308030    Length:36308030    Min.   :  46861  
# 1st Qu.:0.2680   1st Qu.:1.477   1st Qu.:15.54   1st Qu.: 2.6      Class :character   Class :character   1st Qu.:  73975  
# Median :0.2940   Median :1.621   Median :16.33   Median : 6.2      Mode  :character   Mode  :character   Median :  98671  
# Mean   :0.3733   Mean   :2.057   Mean   :16.36   Mean   : 5.3                                            Mean   : 147106  
# 3rd Qu.:0.5000   3rd Qu.:2.789   3rd Qu.:17.11   3rd Qu.: 6.9                                            3rd Qu.: 162663  
# Max.   :0.7900   Max.   :4.334   Max.   :23.82   Max.   :11.0                                            Max.   :1173151  
# NA's   :2954941                                         NA's   :658270   
# worms         species_name       common_name          tax_conf             weight          number_fish      
# Min.   :      2   Length:36308030    Length:36308030    Length:36308030    Min.   :    0      Min.   :     0    
# 1st Qu.: 122388   Class :character   Class :character   Class :character   1st Qu.:    0      1st Qu.:     1    
# Median : 126175   Mode  :character   Mode  :character   Mode  :character   Median :    1      Median :     5    
# Mean   : 150990                                                            Mean   :   39      Mean   :   151    
# 3rd Qu.: 146038                                                            3rd Qu.:   12      3rd Qu.:    31    
# Max.   :1434803                                                            Max.   :18188      Max.   :867119    
# NA's   :197257                                                             NA's   :35402266   NA's   :35402266 
# 
# # Make sure that future version of this data in this script do not change the number of rows
# dim(cpue_station_0filled)
# [1] 36308030       36

## Wrangle data ----------------------------------------------------------------

# Lookup vector to only rename/select if that column is present:
lookup <- c(station = "stationid", 
            weight_kg = "weight", 
            count = "number_fish", 
            srvy = "SRVY",
            survey = "survey_name",
            survey_id = "survey_definition_id", 
            vessel_id = "vessel",
            taxon_confidence = "tax_conf",
            date_time = "start_time", 
            latitude_dd_start = "start_latitude", # latitude_dd = "start_latitude", 
            longitude_dd_start = "start_longitude",  # longitude_dd = "start_longitude", 
            latitude_dd_end = "end_latitude", 
            longitude_dd_end = "end_longitude", 
            bottom_temperature_c = "gear_temperature", 
            surface_temperature_c = "surface_temperature",
            distance_fished_km = "distance_fished", 
            duration_hr = "duration", 
            net_width_m = "net_width",
            net_height_m = "net_height",
            depth_m = "bottom_depth")

cpue_station_0filled <- cpue_station_0filled %>%
  dplyr::mutate( # calculates CPUE for each species group by station
    area_swept_ha = distance_fished * (net_width/10), # both in units of km
    cpue_kgha = weight/area_swept_ha, 
    cpue_noha = ifelse(weight > 0 & number_fish == 0, 
                       NA, (number_fish/area_swept_ha)), 
    cpue_kgha = ifelse(is.na(cpue_kgha), 0, cpue_kgha), 
    cpue_noha = ifelse(is.na(cpue_noha), 0, cpue_noha)) %>%
  dplyr::rename(dplyr::any_of(lookup)) %>% 
  dplyr::mutate(cpue_kgkm2 = cpue_kgha * 100, 
                cpue_nokm2 = cpue_noha * 100, 
                # cpue_no1000km2 = cpue_nokm2 * 1000, 
                # cpue_kg1000km2 = cpue_kgkm2 * 1000, 
                dplyr::across(dplyr::starts_with("cpue_"), round, digits = 6), 
                weight_kg = round(weight_kg, digits = 6)) %>% 
  dplyr::select(any_of(
    c(as.character(expression(
      year, srvy, survey, survey_id, cruise, haul, hauljoin, stratum, station, vessel_name, vessel_id, # survey data
      date_time, latitude_dd, longitude_dd, latitude_dd_start, longitude_dd_start, latitude_dd_end, longitude_dd_end, # when/where
      species_code, itis, worms, common_name, scientific_name, taxon_confidence, # species info
      cpue_kgha, cpue_kgkm2, #cpue_kg1000km2, # cpue weight
      cpue_noha, cpue_nokm2, #cpue_no1000km2, # cpue num
      weight_kg, count, # summed catch data
      bottom_temperature_c, surface_temperature_c, depth_m, #environmental data
      distance_fished_km, net_width_m, net_height_m, area_swept_ha, duration_hr, performance # gear data
    ))))) %>% 
  dplyr::arrange(srvy, date_time, cpue_kgha)


# # Make sure that there are no NAs
# summary(cpue_station_0filled %>% dplyr::mutate(srvy = factor(srvy)))
# year       srvy             survey            survey_id          cruise            haul          hauljoin          stratum        station         
# Min.   :1982   AI : 7224189   Length:36308030    Min.   : 47.00   Min.   :198201   Min.   :  1.0   Min.   : -22026   Min.   : 10.0   Length:36308030   
# 1st Qu.:1997   BSS:  865632   Class :character   1st Qu.: 47.00   1st Qu.:199701   1st Qu.: 59.0   1st Qu.: -12959   1st Qu.: 31.0   Class :character  
# Median :2005   EBS:13371741   Mode  :character   Median : 52.00   Median :200501   Median :117.0   Median :  -4003   Median : 61.0   Mode  :character  
# Mean   :2005   GOA:14532144                      Mean   : 68.35   Mean   :200518   Mean   :122.8   Mean   : 326327   Mean   :151.6                     
# 3rd Qu.:2013   NBS:  314324                      3rd Qu.: 98.00   3rd Qu.:201301   3rd Qu.:177.0   3rd Qu.: 881428   3rd Qu.:214.0                     
# Max.   :2022                                     Max.   :143.00   Max.   :202202   Max.   :355.0   Max.   :1225635   Max.   :794.0                     
# 
# vessel_name          vessel_id      date_time         latitude_dd_start longitude_dd_start latitude_dd_end longitude_dd_end  species_code        itis        
# Length:36308030    Min.   :  1.0   Length:36308030    Min.   :51.19     Min.   :-180.0     Min.   :51.20   Min.   :-180.0   Min.   :    1   Min.   :  46861  
# Class :character   1st Qu.: 88.0   Class :character   1st Qu.:54.38     1st Qu.:-170.1     1st Qu.:54.38   1st Qu.:-170.1   1st Qu.:30420   1st Qu.:  73975  
# Mode  :character   Median : 94.0   Mode  :character   Median :56.77     Median :-163.4     Median :56.78   Median :-163.4   Median :71004   Median :  98671  
# Mean   :110.4                      Mean   :56.46     Mean   :-132.8     Mean   :56.46   Mean   :-132.9   Mean   :59345   Mean   : 147106  
# 3rd Qu.:147.0                      3rd Qu.:58.65     3rd Qu.:-152.0     3rd Qu.:58.65   3rd Qu.:-152.0   3rd Qu.:80548   3rd Qu.: 162663  
# Max.   :178.0                      Max.   :65.34     Max.   : 180.0     Max.   :65.35   Max.   : 180.0   Max.   :99999   Max.   :1173151  
# NA's   :4092    NA's   :4092                     NA's   :658270   
#      worms         common_name        scientific_name    taxon_confidence     cpue_kgha          cpue_kgkm2        cpue_noha           cpue_nokm2      
#  Min.   :      2   Length:36308030    Length:36308030    Length:36308030    Min.   :    0.00   Min.   :      0   Min.   :     0.00   Min.   :       0  
#  1st Qu.: 122388   Class :character   Class :character   Class :character   1st Qu.:    0.00   1st Qu.:      0   1st Qu.:     0.00   1st Qu.:       0  
#  Median : 126175   Mode  :character   Mode  :character   Mode  :character   Median :    0.00   Median :      0   Median :     0.00   Median :       0  
#  Mean   : 150990                                                            Mean   :    0.29   Mean   :     29   Mean   :     0.96   Mean   :      96  
#  3rd Qu.: 146038                                                            3rd Qu.:    0.00   3rd Qu.:      0   3rd Qu.:     0.00   3rd Qu.:       0  
#  Max.   :1434803                                                            Max.   :32262.35   Max.   :3226235   Max.   :217807.80   Max.   :21780780  
#  NA's   :197257                                                                                                                                        
# weight_kg            count          bottom_temperature_c surface_temperature_c    depth_m     distance_fished_km  net_width_m     net_height_m    
# Min.   :    0      Min.   :     0     Min.   :-2.1         Min.   :-1.1          Min.   :   9   Min.   :0.135      Min.   : 7.51   Min.   : 0.0     
# 1st Qu.:    0      1st Qu.:     1     1st Qu.: 3.2         1st Qu.: 5.8          1st Qu.:  72   1st Qu.:1.477      1st Qu.:15.54   1st Qu.: 2.6     
# Median :    1      Median :     5     Median : 4.3         Median : 7.6          Median : 110   Median :1.621      Median :16.33   Median : 6.2     
# Mean   :   39      Mean   :   151     Mean   : 4.1         Mean   : 8.0          Mean   : 144   Mean   :2.057      Mean   :16.36   Mean   : 5.3     
# 3rd Qu.:   12      3rd Qu.:    31     3rd Qu.: 5.4         3rd Qu.: 9.6          3rd Qu.: 170   3rd Qu.:2.789      3rd Qu.:17.11   3rd Qu.: 6.9     
# Max.   :18188      Max.   :867119     Max.   :15.3         Max.   :18.1          Max.   :1200   Max.   :4.334      Max.   :23.82   Max.   :11.0     
# NA's   :35402266   NA's   :35402266   NA's   :1393764      NA's   :801519                                                          NA's   :2954941  
#  area_swept_ha     duration_hr      performance   
#  Min.   :0.2314   Min.   :0.0250   Min.   :0.000  
#  1st Qu.:2.3639   1st Qu.:0.2680   1st Qu.:0.000  
#  Median :2.6899   Median :0.2940   Median :0.000  
#  Mean   :3.3820   Mean   :0.3733   Mean   :0.302  
#  3rd Qu.:4.6051   3rd Qu.:0.5000   3rd Qu.:0.000  
#  Max.   :7.7795   Max.   :0.7900   Max.   :7.000  
#  
# 
# # Make sure that future version of this data in this script do not change the number of rows
# dim(cpue_station_0filled)
# [1] 36308030       37

names(cpue_station_0filled) <- stringr::str_to_upper(names(cpue_station_0filled))

# Metadata ---------------------------------------------------------------------

column_metadata <- data.frame(matrix(
  ncol = 4, byrow = TRUE, 
  data = c(
    "year", "Year", "numeric", "Year the survey was conducted in.", 
    
    "srvy", "Survey", "Abbreviated text", "Abbreviated survey names. The column 'srvy' is associated with the 'survey' and 'survey_id' columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI). ", 
    
    "survey", "Survey Name", "text", "Name and description of survey. The column 'survey' is associated with the 'srvy' and 'survey_id' columns. ", 
    
    "survey_id", "Survey ID", "ID code", paste0("This number uniquely identifies a survey. Name and description of survey. The column 'survey_id' is associated with the 'srvy' and 'survey' columns. For a complete list of surveys, review the [code books](", link_code_books ,"). "), 
    
    "cruise", "Cruise ID", "ID code", "This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.). ", 
    
    "haul", "Haul Number", "ID code", "This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence. ", 
    
    "hauljoin", "hauljoin", "ID Code", "This is a unique numeric identifier assigned to each (vessel, cruise, and haul) combination.", 
    
    "stratum", "Stratum ID", "ID Code", "RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows.", 
    
    "station", "Station ID", "ID code", "Alpha-numeric designation for the station established in the design of a survey. ", 
    
    "vessel_id", "Vessel ID", "ID Code", paste0("ID number of the vessel used to collect data for that haul. The column 'vessel_id' is associated with the 'vessel_name' column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](", link_code_books ,")."), 
    
    "vessel_name", "Vessel Name", "text", paste0("Name of the vessel used to collect data for that haul. The column 'vessel_name' is associated with the 'vessel_id' column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](", link_code_books ,"). "), 
    
    "date_time", "Date and Time of Haul", "MM/DD/YYYY HH::MM", "The date (MM/DD/YYYY) and time (HH:MM) of the beginning of the haul. ", 
    
    "longitude_dd_start", "Start Longitude (decimal degrees)", "decimal degrees, 1e-05 resolution", "Longitude (one hundred thousandth of a decimal degree) of the start of the haul. ", 
    
    "latitude_dd_start", "Start Latitude (decimal degrees)", "decimal degrees, 1e-05 resolution", "Latitude (one hundred thousandth of a decimal degree) of the start of the haul. ",

    "longitude_dd_end", "End Longitude (decimal degrees)", "decimal degrees, 1e-05 resolution", "Longitude (one hundred thousandth of a decimal degree) of the end of the haul. ", 
    
    "latitude_dd_end", "End Latitude (decimal degrees)", "decimal degrees, 1e-05 resolution", "Latitude (one hundred thousandth of a decimal degree) of the end of the haul. ",
    
    "species_code", "Taxon Code", "ID code", paste0("The species code of the organism associated with the 'common_name' and 'scientific_name' columns. For a complete species list, review the [code books](", link_code_books ,")."), 
    
    "common_name", "Taxon Common Name", "text", paste0("The common name of the marine organism associated with the 'scientific_name' and 'species_code' columns. For a complete species list, review the [code books](", link_code_books ,")."), 
    
    "scientific_name", "Taxon Scientific Name", "text", paste0("The scientific name of the organism associated with the 'common_name' and 'species_code' columns. For a complete taxon list, review the [code books](", link_code_books ,")."), 
    
    "taxon_confidence", "Taxon Confidence Rating", "rating", "Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow: **'High'**: High confidence and consistency. Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable. **'Moderate'**: Moderate confidence. Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently. **'Low'**: Low confidence. Taxonomy is incompletely known, or reliable field identification characteristics are unknown. Documentation: [Species identification confidence in the eastern Bering Sea shelf survey (1982-2008)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2009-04.pdf), [Species identification confidence in the eastern Bering Sea slope survey (1976-2010)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-05.pdf), and [Species identification confidence in the Gulf of Alaska and Aleutian Islands surveys (1980-2011)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-01.pdf). ", 
    
    "cpue_kgha", "Weight CPUE (kg/ha)", "kilograms/hectare", "Relative Density. Catch weight (kilograms) divided by area (hectares) swept by the net.", 
    
    "cpue_kgkm2", "Weight CPUE (kg/km<sup>2</sup>)", "kilograms/kilometers<sup>2</sup>", "Relative Density. Catch weight (kilograms) divided by area (squared kilometers) swept by the net. ", 
    
    # "cpue_kg1000km2", "Weight CPUE (kg/1,000 km<sup>2</sup>)", "kilograms/1000 kilometers<sup>2</sup>", "Relative Density. Catch weight (kilograms) divided by area (thousand square kilometers) swept by the net. ", 
    
    "cpue_noha", "Number CPUE (no./ha)", "count/hectare", "Relative Abundance. Catch number (in number of organisms) per area (hectares) swept by the net. ", 
    
    "cpue_nokm2", "Number CPUE (no./km<sup>2</sup>)", "count/kilometers<sup>2</sup>", "Relative Abundance. Catch number (in number of organisms) per area (squared kilometers) swept by the net. ", 
    
    # "cpue_no1000km2", "Number CPUE (no./1,000 km<sup>2</sup>)", "count/1000 kilometers<sup>2</sup>", "Relative Abundance. Catch weight (in number of organisms) divided by area (thousand square kilometers) swept by the net. ", 
    
    "weight_kg", "Taxon Weight (kg)", "kilograms, thousandth resolution", "Weight (thousandths of a kilogram) of individuals in a haul by taxon. ",
    
    "count", "Taxon Count", "count, whole number resolution", "Total number of individuals caught in haul by taxon, represented in whole numbers. ", 
    
    "bottom_temperature_c", "Bottom Temperature (Degrees Celsius)", "degrees Celsius, tenths of a degree resolution", "Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values. ", 
    
    "surface_temperature_c", "Surface Temperature (Degrees Celsius)", "degrees Celsius, tenths of a degree resolution", "Surface temperature (tenths of a degree Celsius); NA indicates removed or missing values. ", 
    
    "bottom_temperature_c", "Bottom Temperature (Degrees Celsius)", "degrees Celsius, tenths of a degree resolution", "Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values. ", 
    
    "depth_m", "Depth (m)", "meters, tenths of a meter resolution", "Bottom depth (tenths of a meter). ", 
    
    "distance_fished_km", "Distance Fished (km)", "kilometers, thousandths of kilometer resolution", "Distance the net fished (thousandths of kilometers). ", 
    
    "net_width_m", "Net Width (m)", "meters", "Measured or estimated distance (meters) between wingtips of the trawl. ", 
    
    "net_height_m", "Net Height (m)", "meters", "Measured or estimated distance (meters) between footrope and headrope of the trawl. ", 
    
    "area_swept_ha", "Area Swept (ha)", "hectares", "The area the net covered while the net was fishing (hectares), defined as the distance fished times the net width.", 
    
    "duration_hr", "Tow Duration (decimal hr)", "decimal hours", "This is the elapsed time between start and end of a haul (decimal hours).", 

    "performance", "Haul Performance Code (rating)", "rating", paste0("This denotes what, if any, issues arose during the haul. For more information, review the [code books](", link_code_books ,")."), 
    
    "itis", "ITIS Taxonomic Serial Number", "ID code", paste0("Species code as identified in the Integrated Taxonomic Information System (https://itis.gov/). Codes were last updated ", file.info(paste0("./data/spp_info.csv"))$ctime, "."), 
    # "", "", "", "", 
    "worms", "World Register of Marine Species Taxonomic Serial Number", "ID code", paste0("Species code as identified in the World Register of Marine Species (WoRMS) (https://www.marinespecies.org/). Codes were last updated ", file.info(paste0("./data/spp_info.csv"))$ctime, ".")
  )))


names(column_metadata) <- c("colname", "colname_desc", "units", "desc")
column_metadata <- column_metadata[match(names(cpue_station_0filled), toupper(column_metadata$colname)),]  
readr::write_csv(x = column_metadata, file = paste0(dir_out, "column_metadata.csv"))

# setdiff(as.character(column_metadata$`Column name from data`), names(cpue_station_0filled))
# setdiff(names(cpue_station_0filled), as.character(column_metadata$`colname`))

table_metadata <- paste0("This dataset includes zero-filled (presence and absence) observations and catch-per-unit-effort (CPUE) estimates for most identified species at a standard set of stations in the Northern Bering Sea (NBS), Eastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), and Aleutian Islands (AI) Surveys conducted by the esource Assessment and Conservation Engineering Division (RACE) Groundfish Assessment Program (GAP) of the Alaska Fisheries Science Center (AFSC). 
There are no legal restrictions on access to the data. 
The data from this dataset are shared on the Fisheries One Stop Stop (FOSS) platform (",link_foss,"). 
The GitHub repository for the scripts that created this code can be found at ",link_repo,
                         ". These data were last updated ", format(x = as.Date(strsplit(x = dir_out, split = "/", fixed = TRUE)[[1]][3]), "%B %d, %Y"), ".")

# table_metadata <- paste0("This dataset includes non-zero (presence) observations and catch-per-unit-effort (CPUE) estimates for most identified species at a standard set of stations in the Northern Bering Sea (NBS), Eastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), and Aleutian Islands (AI) Surveys conducted by the esource Assessment and Conservation Engineering Division (RACE) Groundfish Assessment Program (GAP) of the Alaska Fisheries Science Center (AFSC). 
# There are no legal restrictions on access to the data. 
# The data from this dataset are shared on the Fisheries One Stop Stop (FOSS) platform (",link_foss,"). 
# The GitHub repository for the scripts that created this code can be found at ",link_repo,
# "These data were last updated ", file.info(paste0(dir_out, "cpue_station_0filled.csv"))$ctime, ".")
table_metadata <- gsub(pattern = "\n", replacement = "", x = table_metadata)
readr::write_lines(x = table_metadata, 
                   file = paste0(dir_out, "table_metadata.txt"))

# names(column_metadata) <- c("Column name from data", "Descriptive Column Name", "Units", "Description")


# make data NOT 0-filled -------------------------------------------------------

cpue_station <- cpue_station_0filled 

cpue_station <- cpue_station %>%
  dplyr::filter(
    !(COUNT %in% c(NA, 0) & # this will remove 0-filled values
        WEIGHT_KG %in% c(NA, 0)) | 
      !(CPUE_KGHA %in% c(NA, 0) & # this will remove usless 0-cpue values, 
          CPUE_NOKM2 %in% c(NA, 0)) ) # which shouldn't happen, but good to double check


# Save public data output ------------------------------------------------------

files_to_save <- list(#"cpue_station" = cpue_station, 
                      # "cpue_station_0filled_clean" = cpue_station_0filled_clean,
                      "cpue_station_0filled" = cpue_station_0filled)

# base::save(cpue_station_0filled, 
#            column_metadata, 
#            table_metadata, 
#            file = paste0(dir_out,"cpue_station_0filled.RData"))
# 
# base::save(cpue_station_0filled, 
#            column_metadata, 
#            table_metadata, 
#            file = paste0(dir_out,"cpue_station_0filled.RData"))
  table_metadata0 <- table_metadata

for (i in 1:length(files_to_save)) {
  
  if (names(files_to_save)[i] != "cpue_station") {
    table_metadata <- gsub(pattern = "non-zero (presence)", replacement = "all (presence and absence)", x = table_metadata0)
  }
  
  x <- files_to_save[i][[1]]
  
  base::save(
    x, 
    column_metadata, 
    table_metadata, 
    file = paste0(dir_out, names(files_to_save)[i], ".RData"))
  
  readr::write_csv(
    x = files_to_save[i][[1]], 
    file = paste0(dir_out, names(files_to_save)[i], ".csv"), 
    col_names = TRUE)
}
