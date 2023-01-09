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
FOSS_CPUE_ZEROFILLED_comb <- data.frame() 

for (i in 1:length(surveys$SRVY)) {
  
  # subset presence-only data to survey
  temp <- catch_haul_cruises_vess %>% 
    dplyr::filter(SRVY == surveys$SRVY[i]) 
  
  FOSS_CPUE_ZEROFILLED_comb <- 
    tidyr::crossing( # create all possible haul event x species_code combinations
      temp %>% 
        dplyr::select(SRVY, hauljoin) %>% # unique haul event
        dplyr::distinct(),
      temp %>%
        dplyr::distinct(., species_code) %>%  # unique species_codes
        dplyr::distinct()) %>% 
    dplyr::bind_rows(FOSS_CPUE_ZEROFILLED_comb, .)
}

# # Make sure that there are no NAs
# summary(FOSS_CPUE_ZEROFILLED_comb %>% dplyr::mutate(SRVY = factor(SRVY)))
# SRVY             hauljoin        species_code  
# AI : 7224189   Min.   : -22026   Min.   :    1  
# BSS:  865632   1st Qu.: -12959   1st Qu.:30420  
# EBS:13371741   Median :  -4003   Median :71004  
# GOA:14532144   Mean   : 326327   Mean   :59345  
# NBS:  314324   3rd Qu.: 881428   3rd Qu.:80548  
#                Max.   :1225635   Max.   :99999  
#
# # Make sure that future version of this data in this script do not change the number of rows
# dim(FOSS_CPUE_ZEROFILLED_comb)
# [1] 36308030        3

## Fill data -------------------------------------------------------------------
FOSS_CPUE_ZEROFILLED <- FOSS_CPUE_ZEROFILLED_comb %>%
  dplyr::left_join( # Add haul data
    x = ., 
    y = haul_cruises_vess %>% 
      dplyr::select(-region),
    by = c("hauljoin", "SRVY")) %>% 
  dplyr::left_join( # Add species info
    x = .,
    y = AFSC_ITIS_WORMS %>% 
      dplyr::select(-notes_itis, -notes_worms), 
    by = "species_code") %>%
  dplyr::left_join( # Add species info
    x = .,
    y = TAXON_CONFIDENCE %>% 
      dplyr::select(year, taxon_confidence, SRVY, species_code), 
    by = c("year", "SRVY", "species_code")) %>%
  dplyr::left_join( # overwrite NAs where data exists for CPUE calculation
    x = .,
    y = catch %>%
      dplyr::select(species_code, hauljoin, 
                    weight, number_fish),
    by = c("species_code", "hauljoin")) 


# # Make sure that there are no NAs
# summary(FOSS_CPUE_ZEROFILLED %>% dplyr::mutate(SRVY = factor(SRVY)))
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
# worms         species_name       common_name          taxon_confidence     weight          number_fish      
# Min.   :      2   Length:36308030    Length:36308030    Length:36308030    Min.   :    0      Min.   :     0    
# 1st Qu.: 122388   Class :character   Class :character   Class :character   1st Qu.:    0      1st Qu.:     1    
# Median : 126175   Mode  :character   Mode  :character   Mode  :character   Median :    1      Median :     5    
# Mean   : 150990                                                            Mean   :   39      Mean   :   151    
# 3rd Qu.: 146038                                                            3rd Qu.:   12      3rd Qu.:    31    
# Max.   :1434803                                                            Max.   :18188      Max.   :867119    
# NA's   :197257                                                             NA's   :35402266   NA's   :35402266 
# 
# # Make sure that future version of this data in this script do not change the number of rows
# dim(FOSS_CPUE_ZEROFILLED)
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

FOSS_CPUE_ZEROFILLED <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::rename(dplyr::any_of(lookup)) %>% 
  dplyr::mutate( # calculates CPUE for each species group by station
    area_swept_ha = distance_fished_km * (net_width_m/10), # both in units of km
    cpue_kgha = weight_kg/area_swept_ha, 
    cpue_noha = ifelse(weight_kg > 0 & count == 0, 
                       NA, (count/area_swept_ha)), 
    cpue_kgha = ifelse(is.na(cpue_kgha), 0, cpue_kgha), 
    cpue_noha = ifelse(is.na(cpue_noha), 0, cpue_noha), 
    cpue_kgkm2 = cpue_kgha * 100, 
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
  dplyr::arrange(srvy, date_time, cpue_kgha) %>% 
  dplyr::mutate(count = ifelse(is.na(count), 0, count), 
                weight_kg = ifelse(is.na(weight_kg), 0, weight_kg) )

# # Make sure that there are no NAs
# summary(FOSS_CPUE_ZEROFILLED %>% dplyr::mutate(srvy = factor(srvy)))
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
# 
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
# dim(FOSS_CPUE_ZEROFILLED)
# [1] 36308030       37

names(FOSS_CPUE_ZEROFILLED) <- stringr::str_to_upper(names(FOSS_CPUE_ZEROFILLED))

# split up data to make smaller join files -------------------------------------

JOIN_FOSS_CPUE_HAUL <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::select(
    HAULJOIN, # Join these
    YEAR, SURVEY, SURVEY_ID, CRUISE, 
    HAUL, VESSEL_NAME, VESSEL_ID, STATION, STRATUM, DATE_TIME, 
    BOTTOM_TEMPERATURE_C, SURFACE_TEMPERATURE_C,
    DEPTH_M, LATITUDE_DD_START, LATITUDE_DD_END, LONGITUDE_DD_START, LONGITUDE_DD_END, 
    NET_HEIGHT_M, NET_WIDTH_M, DISTANCE_FISHED_KM, DURATION_HR, AREA_SWEPT_HA, PERFORMANCE) %>% 
  dplyr::distinct()
# haul_cruises_vess %>% 
#     dplyr::select(-region) # by = c("hauljoin", "SRVY")) %>% 

JOIN_FOSS_CPUE_CATCH <- FOSS_CPUE_ZEROFILLED %>% 
  dplyr::select(HAULJOIN, # join these
                SPECIES_CODE, CPUE_KGHA, CPUE_KGKM2, CPUE_NOHA, CPUE_NOKM2, COUNT, WEIGHT_KG,
                TAXON_CONFIDENCE, 
                SCIENTIFIC_NAME, COMMON_NAME, WORMS, ITIS) %>% 
  dplyr::distinct()
# setdiff(names(FOSS_CPUE_ZEROFILLED), 
#   unique(c(names(JOIN_FOSS_CPUE_CATCH), names(JOIN_FOSS_CPUE_TAXCONF),
# names(JOIN_FOSS_CPUE_SPP), names(JOIN_FOSS_CPUE_HAUL),
# names(JOIN_FOSS_CPUE_COMB))))

# make data NOT 0-filled -------------------------------------------------------

FOSS_CPUE_PRESONLY <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::filter(
    !(COUNT %in% c(NA, 0) & # this will remove 0-filled values
        WEIGHT_KG %in% c(NA, 0)) | 
      !(CPUE_KGHA %in% c(NA, 0) & # this will remove usless 0-cpue values, 
          CPUE_NOKM2 %in% c(NA, 0)) ) # which shouldn't happen, but good to double check

# Metadata ---------------------------------------------------------------------

column_metadata <- column_metadata[match(names(FOSS_CPUE_ZEROFILLED), toupper(column_metadata$colname)),]  

# setdiff(as.character(column_metadata$`Column name from data`), names(FOSS_CPUE_ZEROFILLED))
# setdiff(names(FOSS_CPUE_ZEROFILLED), as.character(column_metadata$`colname`))

# Save public data output ------------------------------------------------------

# zero-fill join tables

table_metadata <- paste0(
  "The full join the JOIN_FOSS_CPUE_CATCH and JOIN_FOSS_CPUE_HAUL datasets using HAULJOIN to 
create zero-filled (presence and absence) observations and 
catch-per-unit-effort (CPUE) estimates for all identified species at a standard set of stations ", 
  metadata_sentence_survey_institution, 
  metadata_sentence_legal_restrict, 
  metadata_sentence_foss, 
  metadata_sentence_github, 
  metadata_sentence_codebook, 
  metadata_sentence_last_updated)

readr::write_lines(x = gsub(pattern = "\n", replacement = "", x = table_metadata), 
                   file = paste0(dir_out, "JOIN_FOSS_CPUE_table_metadata.txt"))

base::save(
  JOIN_FOSS_CPUE_HAUL, 
  JOIN_FOSS_CPUE_CATCH, 
  column_metadata, 
  table_metadata, 
  file = paste0(dir_out, "FOSS_CPUE_JOIN.RData"))

# Zero filled 

table_metadata <- paste0(
  "This dataset includes zero-filled (presence and absence) observations and 
  catch-per-unit-effort (CPUE) estimates for most identified species at a standard set of stations ", 
  metadata_sentence_survey_institution, 
  metadata_sentence_legal_restrict, 
  metadata_sentence_foss, 
  metadata_sentence_github, 
  metadata_sentence_codebook, 
  metadata_sentence_last_updated)

readr::write_lines(x = gsub(pattern = "\n", replacement = "", x = table_metadata), 
                   file = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_table_metadata.txt"))

base::save(
  FOSS_CPUE_ZEROFILLED, 
  column_metadata, 
  table_metadata, 
  file = paste0(dir_out, "FOSS_CPUE_ZEROFILLED.RData"))

# PRES ONLY

table_metadata <- gsub(pattern = "zero-filled (presence and absence)", 
     replacement = "presence-only",
     x = paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_table_metadata.txt")), collapse="\n"))

readr::write_lines(x = gsub(pattern = "\n", replacement = "", x = table_metadata), 
                   file = paste0(dir_out, "FOSS_CPUE_PRESONLY_table_metadata.txt"))

base::save(
  FOSS_CPUE_PRESONLY, 
  column_metadata, 
  table_metadata, 
  file = paste0(dir_out, "FOSS_CPUE_PRESONLY.RData"))

list_to_save <- c(
  "JOIN_FOSS_CPUE_CATCH", 
  "JOIN_FOSS_CPUE_HAUL",
  "FOSS_CPUE_PRESONLY", 
  "FOSS_CPUE_ZEROFILLED")

for (i in 1:length(list_to_save)) {
  readr::write_csv(
    x = get(list_to_save[i]), 
    file = paste0(dir_out, list_to_save[i], ".csv"), 
    col_names = TRUE)
}
