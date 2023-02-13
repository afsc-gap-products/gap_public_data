#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Find Combinations for zero-fill ----------------------------------------------

print("Find Combinations for zero-fill")

# using a loop so we only make zero-filled for species that occurred in a survey 
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
# SRVY             hauljoin        species_code  # 2023-02-12
# AI : 7224189   Min.   : -22026   Min.   :    1  
# BSS:  865632   1st Qu.: -12959   1st Qu.:30420  
# EBS:13386582   Median :  -4003   Median :71004  
# GOA:14551572   Mean   : 326315   Mean   :59313  
# NBS:  314324   3rd Qu.: 881427   3rd Qu.:80548  
#                Max.   :1225635   Max.   :99999  
#
# # Make sure that future version of this data in this script do not change the number of rows
# dim(FOSS_CPUE_ZEROFILLED_comb)
# [1] 36308030        3
# [1] 36342299        3 # 2023-02-12

## Fill data -------------------------------------------------------------------

print("Fill data")

FOSS_CPUE_ZEROFILLED <- FOSS_CPUE_ZEROFILLED_comb %>%
  dplyr::left_join( # Add haul data
    x = ., 
    y = haul_cruises_vess %>% 
      dplyr::select(-region),
    by = c("hauljoin", "SRVY")) %>% 
  dplyr::left_join( # Add worms + species info
    x = .,
    y = taxon_id, 
    by = "species_code") %>%
  dplyr::left_join( # Add species info
    x = .,
    y = taxon_confidence0 %>% 
      dplyr::select(year, taxon_confidence, SRVY, species_code), 
    by = c("year", "SRVY", "species_code")) %>%
  dplyr::left_join( # overwrite NAs where data exists for CPUE calculation
    x = .,
    y = catch %>%
      dplyr::select(species_code, hauljoin, 
                    weight, number_fish),
    by = c("species_code", "hauljoin"))  %>% 
  dplyr::mutate(number_fish = ifelse(is.na(number_fish), 0, number_fish), 
                weight = ifelse(is.na(weight), 0, weight), 
                taxon_confidence = ifelse(is.na(taxon_confidence), "Unassessed", taxon_confidence))

# Make sure that future version of this data in this script do not change the number of rows
# dim(FOSS_CPUE_ZEROFILLED)
# [1] 36308030       36
# [1] 36317744       36 # 2023-01-21
# [1] 36342299       35 # 2023-02-12

# Make sure that there are no NAs in columns that should be 0-filled
# The only columns with NAs should be: 
# end_latitude   end_longitude gear_temperature  surface_temperature net_height   worms   itis
# # summary(FOSS_CPUE_ZEROFILLED %>% dplyr::mutate(SRVY = factor(SRVY), taxon_confidence = factor(taxon_confidence)))
# 2023-02-12
# SRVY             hauljoin        species_code     cruisejoin          vessel      survey_definition_id  SRVY_long        
# AI : 7224189   Min.   : -22026   Min.   :    1   Min.   :   -758   Min.   :  1.0   Min.   : 47.00       Length:36342299   
# BSS:  865632   1st Qu.: -12959   1st Qu.:30420   1st Qu.:   -687   1st Qu.: 88.0   1st Qu.: 47.00       Class :character  
# EBS:13386582   Median :  -4003   Median :71004   Median :   -612   Median : 94.0   Median : 52.00       Mode  :character  
# GOA:14551572   Mean   : 326315   Mean   :59313   Mean   : 331176   Mean   :110.4   Mean   : 68.35                         
# NBS:  314324   3rd Qu.: 881427   3rd Qu.:80548   3rd Qu.: 881075   3rd Qu.:147.0   3rd Qu.: 98.00                         
#                Max.   :1225635   Max.   :99999   Max.   :1225395   Max.   :178.0   Max.   :143.00                         
# 
# survey_name             year          cruise         haul_type  stationid            stratum           haul        start_time       
# Length:36342299    Min.   :1982   Min.   :198201   Min.   :3   Length:36342299    Min.   : 10.0   Min.   :  1.0   Length:36342299   
# Class :character   1st Qu.:1997   1st Qu.:199701   1st Qu.:3   Class :character   1st Qu.: 31.0   1st Qu.: 59.0   Class :character  
# Mode  :character   Median :2005   Median :200501   Median :3   Mode  :character   Median : 61.0   Median :117.0   Mode  :character  
# Mean   :2005   Mean   :200518   Mean   :3                      Mean   :151.5   Mean   :122.8                     
# 3rd Qu.:2013   3rd Qu.:201301   3rd Qu.:3                      3rd Qu.:214.0   3rd Qu.:177.0                     
#               Max.   :2022      Max.   :202202     Max.   :3                   Max.   :794.0      Max.   :355.0                     
# 
# start_latitude  start_longitude   end_latitude   end_longitude     bottom_depth  gear_temperature  surface_temperature  performance   
# Min.   :51.19   Min.   :-180.0   Min.   :51.20   Min.   :-180.0   Min.   :   9   Min.   :-2.1      Min.   :-1.1        Min.   :0.000  
# 1st Qu.:54.38   1st Qu.:-170.1   1st Qu.:54.38   1st Qu.:-170.1   1st Qu.:  72   1st Qu.: 3.2      1st Qu.: 5.8        1st Qu.:0.000  
# Median :56.78   Median :-163.4   Median :56.78   Median :-163.4   Median : 110   Median : 4.3      Median : 7.6        Median :0.000  
# Mean   :56.46   Mean   :-132.9   Mean   :56.46   Mean   :-132.9   Mean   : 144   Mean   : 4.1      Mean   : 8.0        Mean   :0.302  
# 3rd Qu.:58.65   3rd Qu.:-152.0   3rd Qu.:58.65   3rd Qu.:-152.0   3rd Qu.: 170   3rd Qu.: 5.4      3rd Qu.: 9.6        3rd Qu.:0.000  
# Max.   :65.34   Max.   : 180.0   Max.   :65.35   Max.   : 180.0   Max.   :1200   Max.   :15.3      Max.   :18.1        Max.   :7.000  
#                                  NA's   :4095    NA's   :4095                    NA's   :1394904   NA's   :793824                     
# duration      distance_fished   net_width       net_height      vessel_name        scientific_name    common_name       
# Min.   :0.0250   Min.   :0.135   Min.   : 7.51   Min.   : 0.0      Length:36342299    Length:36342299    Length:36342299   
# 1st Qu.:0.2680   1st Qu.:1.477   1st Qu.:15.54   1st Qu.: 2.6      Class :character   Class :character   Class :character  
# Median :0.2940   Median :1.621   Median :16.33   Median : 6.2      Mode  :character   Mode  :character   Mode  :character  
# Mean   :0.3733   Mean   :2.057   Mean   :16.36   Mean   : 5.3                                                              
# 3rd Qu.:0.5000   3rd Qu.:2.789   3rd Qu.:17.11   3rd Qu.: 6.9                                                              
# Max.   :0.7900   Max.   :4.334   Max.   :23.82   Max.   :11.0                                                              
#                                  NA's   :2958203                                                           
#      worms              itis           taxon_confidence        weight           number_fish      
#  Min.   :     51   Min.   :  46861   High      : 9725786   Min.   :    0.000   Min.   :     0.0  
#  1st Qu.: 127200   1st Qu.:  79676   Low       : 9594003   1st Qu.:    0.000   1st Qu.:     0.0  
#  Median : 254378   Median : 157232   Moderate  : 1880646   Median :    0.000   Median :     0.0  
#  Mean   : 282494   Mean   : 215472   Unassessed:15141864   Mean   :    0.964   Mean   :     3.8  
#  3rd Qu.: 366676   3rd Qu.: 167542                         3rd Qu.:    0.000   3rd Qu.:     0.0  
#  Max.   :1610477   Max.   :1608733                         Max.   :18187.700   Max.   :867119.0  
#  NA's   :3552644   NA's   :3567559    

# table(FOSS_CPUE_ZEROFILLED$SRVY, FOSS_CPUE_ZEROFILLED$cruise)
# 2023-02-12
#      198201  198203  198301  198303  198401  198402  198501  198601  198602  198701  198801  198901  199001  199101  199201  199301
# AI        0       0       0       0       0       0       0       0       0       0       0       0       0  459759       0       0
# BSS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# EBS  172282  128986  159654  158752  140712  179498  321112  128084  191224  322014  336446  337348  334642  335544  321112  338250
# GOA       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0  930258
# NBS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# 
#     199309  199401  199501  199601  199701  199801  199901  200001  200101  200201  200202  200301  200401  200501  200601  200701
# AI        0  527820       0       0  550044       0       0  581991       0  575046       0       0  581991       0  495873       0
# BSS       0       0       0       0       0       0       0       0       0       0  107442       0  176022       0       0       0
# EBS       0  338250  339152  338250  339152  338250  336446  335544  338250  338250       0  339152  338250  336446  339152  339152
# GOA  229194       0       0 1208886       0       0 1144472       0  732522       0       0 1211882       0 1253826       0 1222368
# NBS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# 
#       200801  200901  201001  201002  201101  201201  201301  201401  201501  201601  201701  201702  201801  201901  201902  202101
# AI        0       0  580602       0       0  583380       0  569490       0  581991       0       0  583380       0       0       0
# BSS  152400       0  152400       0       0  144018       0       0       0  133350       0       0       0       0       0       0
# EBS  338250  339152  339152       0  339152  339152  339152  339152  339152  339152  339152       0  339152  339152       0  339152
# GOA       0 1232854       0       0 1003660       0  820904       0 1154958       0  802928       0       0  810418       0  792442
# NBS       0       0       0   61899       0       0       0       0       0       0       0   62777       0       0   63216       0
# 
#      202102  202201  202202
# AI        0  552822       0
# BSS       0       0       0
# EBS       0  339152       0
# GOA       0       0       0
# NBS   63216       0   63216

# Previous
# 198201  198203  198301  198303  198401  198402  198501  198601  198602  198701  198801  198901  199001  199101  199201  199301  199309
# AI        0       0       0       0       0       0       0       0       0       0       0       0       0  459759       0       0       0
# BSS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# EBS  172091  128843  159477  158576  140556  179299  320756  127942  191012  321657  336073  336974  334271  335172  320756  337875       0
# GOA       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0  929637  229041
# NBS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# 
# 199401  199501  199601  199701  199801  199901  200001  200101  200201  200202  200301  200401  200501  200601  200701  200801  200901
# AI   527820       0       0  550044       0       0  581991       0  575046       0       0  581991       0  495873       0       0       0
# BSS       0       0       0       0       0       0       0       0       0  107442       0  176022       0       0       0  152400       0
# EBS  337875  338776  337875  338776  337875  336073  335172  337875  337875       0  338776  337875  336073  338776  338776  337875  338776
# GOA       0       0 1208079       0       0 1143708       0  732033       0       0 1211073       0 1252989       0 1221552       0 1232031
# NBS       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0       0
# 
# 201001  201002  201101  201201  201301  201401  201501  201601  201701  201702  201801  201901  201902  202101  202102  202201  202202
# AI   580602       0       0  583380       0  569490       0  581991       0       0  583380       0       0       0       0  552822       0
# BSS  152400       0       0  144018       0       0       0  133350       0       0       0       0       0       0       0       0       0
# EBS  338776       0  338776  338776  338776  338776  338776  338776  338776       0  338776  338776       0  338776       0  338776       0
# GOA       0       0 1002990       0  820356       0 1154187       0  802392       0       0  809877       0  791913       0       0       0
# NBS       0   61899       0       0       0       0       0       0       0   62777       0       0   63216       0   63216       0   63216

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
    date_time = base::as.POSIXlt(x = date_time, 
                                 format = "%m/%d/%Y %H:%M:%OS", 
                                 tz = "America/Nome"), 
    dplyr::across(dplyr::starts_with("cpue_"), round, digits = 6), 
    weight_kg = round(weight_kg, digits = 6)) %>% 
  dplyr::select(any_of(
    c(as.character(expression(
      year, srvy, survey, survey_id, cruise, haul, hauljoin, stratum, station, vessel_name, vessel_id, # survey data
      date_time, latitude_dd, longitude_dd, latitude_dd_start, longitude_dd_start, latitude_dd_end, longitude_dd_end, # when/where
      species_code, itis, worms, common_name, scientific_name, taxon_confidence, # species info
      cpue_kgha, cpue_kgkm2, # cpue weight
      cpue_noha, cpue_nokm2, # cpue num
      weight_kg, count, # summed catch data
      bottom_temperature_c, surface_temperature_c, depth_m, #environmental data
      distance_fished_km, net_width_m, net_height_m, area_swept_ha, duration_hr, performance # gear data
    ))))) %>% 
  dplyr::arrange(date_time, srvy, cpue_kgha) 

names(FOSS_CPUE_ZEROFILLED) <- toupper(names(FOSS_CPUE_ZEROFILLED))

# 
# # Make sure that future version of this data in this script do not change the number of rows
# dim(FOSS_CPUE_ZEROFILLED)
# [1] 36308030       37
# [1] 36317744       37 # 2023-01-21
# [1] 36342299       37 # 2023-02-12

# # Make sure that there are no NAs
# # summary(FOSS_CPUE_ZEROFILLED %>% dplyr::mutate(SRVY = factor(SRVY), TAXON_CONFIDENCE = factor(TAXON_CONFIDENCE)))
# summary(check %>% dplyr::mutate(SRVY = factor(SRVY))) # 2023-01-21
# YEAR       SRVY             SURVEY            SURVEY_ID          CRUISE            HAUL          HAULJOIN          STRATUM     
# Min.   :1982   AI : 7224189   Length:36317744    Min.   : 47.00   Min.   :198201   Min.   :  1.0   Min.   : -22026   Min.   : 10.0  
# 1st Qu.:1997   BSS:  865632   Class :character   1st Qu.: 47.00   1st Qu.:199701   1st Qu.: 59.0   1st Qu.: -12959   1st Qu.: 31.0  
# Median :2005   EBS:13371741   Mode  :character   Median : 52.00   Median :200501   Median :117.0   Median :  -4004   Median : 61.0  
# Mean   :2005   GOA:14541858                      Mean   : 68.34   Mean   :200518   Mean   :122.8   Mean   : 326333   Mean   :151.5  
# 3rd Qu.:2013   NBS:  314324                      3rd Qu.: 98.00   3rd Qu.:201301   3rd Qu.:177.0   3rd Qu.: 881428   3rd Qu.:214.0  
# Max.   :2022                                     Max.   :143.00   Max.   :202202   Max.   :355.0   Max.   :1225635   Max.   :794.0  
# 
# STATION          VESSEL_NAME          VESSEL_ID      DATE_TIME         LATITUDE_DD_START LONGITUDE_DD_START LATITUDE_DD_END LONGITUDE_DD_END
# Length:36317744    Length:36317744    Min.   :  1.0   Length:36317744    Min.   :51.19     Min.   :-180.0     Min.   :51.20   Min.   :-180.0  
# Class :character   Class :character   1st Qu.: 88.0   Class :character   1st Qu.:54.38     1st Qu.:-170.1     1st Qu.:54.38   1st Qu.:-170.1  
# Mode  :character   Mode  :character   Median : 94.0   Mode  :character   Median :56.77     Median :-163.4     Median :56.78   Median :-163.4  
# Mean   :110.4                      Mean   :56.46     Mean   :-132.8     Mean   :56.46   Mean   :-132.9  
# 3rd Qu.:147.0                      3rd Qu.:58.65     3rd Qu.:-151.9     3rd Qu.:58.65   3rd Qu.:-151.9  
# Max.   :178.0                      Max.   :65.34     Max.   : 180.0     Max.   :65.35   Max.   : 180.0  
#                                                                                          NA's   :4092    NA's   :4092    
# SPECIES_CODE        ITIS             WORMS         COMMON_NAME        SCIENTIFIC_NAME      TAXON_CONFIDENCE      CPUE_KGHA       
# Min.   :    1   Min.   :  46861   Min.   :      2   Length:36317744    Length:36317744    High      : 9724963   Min.   :    0.00  
# 1st Qu.:30420   1st Qu.:  73975   1st Qu.: 122388   Class :character   Class :character   Low       : 9594003   1st Qu.:    0.00  
# Median :71008   Median :  98671   Median : 126175   Mode  :character   Mode  :character   Moderate  : 1880646   Median :    0.00  
# Mean   :59353   Mean   : 147106   Mean   : 150990                                         Unassessed:15118132   Mean   :    0.29  
# 3rd Qu.:80549   3rd Qu.: 162663   3rd Qu.: 146038                                                               3rd Qu.:    0.00  
# Max.   :99999   Max.   :1173151   Max.   :1434803                                                               Max.   :32262.35  
#                 NA's   :667984    NA's   :206971                                                                                  
# CPUE_KGKM2        CPUE_NOHA           CPUE_NOKM2         WEIGHT_KG             COUNT          BOTTOM_TEMPERATURE_C SURFACE_TEMPERATURE_C
# Min.   :      0   Min.   :     0.00   Min.   :       0   Min.   :    0.000   Min.   :     0.0   Min.   :-2.1         Min.   :-1.1         
# 1st Qu.:      0   1st Qu.:     0.00   1st Qu.:       0   1st Qu.:    0.000   1st Qu.:     0.0   1st Qu.: 3.2         1st Qu.: 5.8         
# Median :      0   Median :     0.00   Median :       0   Median :    0.000   Median :     0.0   Median : 4.3         Median : 7.6         
# Mean   :     29   Mean   :     0.96   Mean   :      96   Mean   :    0.965   Mean   :     3.8   Mean   : 4.1         Mean   : 8.0         
# 3rd Qu.:      0   3rd Qu.:     0.00   3rd Qu.:       0   3rd Qu.:    0.000   3rd Qu.:     0.0   3rd Qu.: 5.4         3rd Qu.: 9.6         
# Max.   :3226235   Max.   :217807.80   Max.   :21780780   Max.   :18187.700   Max.   :867119.0   Max.   :15.3         Max.   :18.1         
#                                                                                                 NA's   :1394059      NA's   :801718       
# DEPTH_M     DISTANCE_FISHED_KM  NET_WIDTH_M     NET_HEIGHT_M     AREA_SWEPT_HA     DURATION_HR      PERFORMANCE   
# Min.   :   9   Min.   :0.135      Min.   : 7.51   Min.   : 0.0      Min.   :0.2314   Min.   :0.0250   Min.   :0.000  
# 1st Qu.:  72   1st Qu.:1.477      1st Qu.:15.54   1st Qu.: 2.6      1st Qu.:2.3638   1st Qu.:0.2680   1st Qu.:0.000  
# Median : 110   Median :1.621      Median :16.33   Median : 6.2      Median :2.6898   Median :0.2940   Median :0.000  
# Mean   : 144   Mean   :2.057      Mean   :16.36   Mean   : 5.3      Mean   :3.3817   Mean   :0.3733   Mean   :0.302  
# 3rd Qu.: 170   3rd Qu.:2.789      3rd Qu.:17.11   3rd Qu.: 6.9      3rd Qu.:4.6051   3rd Qu.:0.5000   3rd Qu.:0.000  
# Max.   :1200   Max.   :4.334      Max.   :23.82   Max.   :11.0      Max.   :7.7795   Max.   :0.7900   Max.   :7.000  
#                                                   NA's   :2954949      

# # 2023-02-12
# YEAR       SRVY             SURVEY            SURVEY_ID          CRUISE            HAUL          HAULJOIN          STRATUM     
# Min.   :1982   AI : 7224189   Length:36342299    Min.   : 47.00   Min.   :198201   Min.   :  1.0   Min.   : -22026   Min.   : 10.0  
# 1st Qu.:1997   BSS:  865632   Class :character   1st Qu.: 47.00   1st Qu.:199701   1st Qu.: 59.0   1st Qu.: -12959   1st Qu.: 31.0  
# Median :2005   EBS:13386582   Mode  :character   Median : 52.00   Median :200501   Median :117.0   Median :  -4003   Median : 61.0  
# Mean   :2005   GOA:14551572                      Mean   : 68.35   Mean   :200518   Mean   :122.8   Mean   : 326315   Mean   :151.5  
# 3rd Qu.:2013   NBS:  314324                      3rd Qu.: 98.00   3rd Qu.:201301   3rd Qu.:177.0   3rd Qu.: 881427   3rd Qu.:214.0  
# Max.   :2022                                     Max.   :143.00   Max.   :202202   Max.   :355.0   Max.   :1225635   Max.   :794.0  
# 
# STATION          VESSEL_NAME          VESSEL_ID      DATE_TIME         LATITUDE_DD_START LONGITUDE_DD_START LATITUDE_DD_END
# Length:36342299    Length:36342299    Min.   :  1.0   Length:36342299    Min.   :51.19     Min.   :-180.0     Min.   :51.20  
# Class :character   Class :character   1st Qu.: 88.0   Class :character   1st Qu.:54.38     1st Qu.:-170.1     1st Qu.:54.38  
# Mode  :character   Mode  :character   Median : 94.0   Mode  :character   Median :56.78     Median :-163.4     Median :56.78  
# Mean   :110.4                      Mean   :56.46     Mean   :-132.9     Mean   :56.46  
# 3rd Qu.:147.0                      3rd Qu.:58.65     3rd Qu.:-152.0     3rd Qu.:58.65  
# Max.   :178.0                      Max.   :65.34     Max.   : 180.0     Max.   :65.35  
#                                                                                                               NA's   :4095   
#  LONGITUDE_DD_END  SPECIES_CODE        ITIS             WORMS         COMMON_NAME        SCIENTIFIC_NAME      TAXON_CONFIDENCE   
#  Min.   :-180.0   Min.   :    1   Min.   :  46861   Min.   :     51   Length:36342299    Length:36342299    High      : 9725786  
#  1st Qu.:-170.1   1st Qu.:30420   1st Qu.:  79676   1st Qu.: 127200   Class :character   Class :character   Low       : 9594003  
#  Median :-163.4   Median :71004   Median : 157232   Median : 254378   Mode  :character   Mode  :character   Moderate  : 1880646  
#  Mean   :-132.9   Mean   :59313   Mean   : 215472   Mean   : 282494                                         Unassessed:15141864  
#  3rd Qu.:-152.0   3rd Qu.:80548   3rd Qu.: 167542   3rd Qu.: 366676                                                              
#  Max.   : 180.0   Max.   :99999   Max.   :1608733   Max.   :1610477                                                              
#  NA's   :4095                     NA's   :3567559   NA's   :3552644                                                              
# CPUE_KGHA          CPUE_KGKM2        CPUE_NOHA           CPUE_NOKM2         WEIGHT_KG             COUNT          BOTTOM_TEMPERATURE_C
# Min.   :    0.00   Min.   :      0   Min.   :     0.00   Min.   :       0   Min.   :    0.000   Min.   :     0.0   Min.   :-2.1        
# 1st Qu.:    0.00   1st Qu.:      0   1st Qu.:     0.00   1st Qu.:       0   1st Qu.:    0.000   1st Qu.:     0.0   1st Qu.: 3.2        
# Median :    0.00   Median :      0   Median :     0.00   Median :       0   Median :    0.000   Median :     0.0   Median : 4.3        
# Mean   :    0.29   Mean   :     29   Mean   :     0.96   Mean   :      96   Mean   :    0.964   Mean   :     3.8   Mean   : 4.1        
# 3rd Qu.:    0.00   3rd Qu.:      0   3rd Qu.:     0.00   3rd Qu.:       0   3rd Qu.:    0.000   3rd Qu.:     0.0   3rd Qu.: 5.4        
# Max.   :32262.35   Max.   :3226235   Max.   :217807.80   Max.   :21780780   Max.   :18187.700   Max.   :867119.0   Max.   :15.3        
#                                                                                                                    NA's   :1394904     
#  SURFACE_TEMPERATURE_C    DEPTH_M     DISTANCE_FISHED_KM  NET_WIDTH_M     NET_HEIGHT_M     AREA_SWEPT_HA     DURATION_HR    
#  Min.   :-1.1          Min.   :   9   Min.   :0.135      Min.   : 7.51   Min.   : 0.0      Min.   :0.2314   Min.   :0.0250  
#  1st Qu.: 5.8          1st Qu.:  72   1st Qu.:1.477      1st Qu.:15.54   1st Qu.: 2.6      1st Qu.:2.3639   1st Qu.:0.2680  
#  Median : 7.6          Median : 110   Median :1.621      Median :16.33   Median : 6.2      Median :2.6899   Median :0.2940  
#  Mean   : 8.0          Mean   : 144   Mean   :2.057      Mean   :16.36   Mean   : 5.3      Mean   :3.3820   Mean   :0.3733  
#  3rd Qu.: 9.6          3rd Qu.: 170   3rd Qu.:2.789      3rd Qu.:17.11   3rd Qu.: 6.9      3rd Qu.:4.6052   3rd Qu.:0.5000  
#  Max.   :18.1          Max.   :1200   Max.   :4.334      Max.   :23.82   Max.   :11.0      Max.   :7.7795   Max.   :0.7900  
#  NA's   :793824                                                          NA's   :2958203                                    
#   PERFORMANCE   
#  Min.   :0.000  
#  1st Qu.:0.000  
#  Median :0.000  
#  Mean   :0.302  
#  3rd Qu.:0.000  
#  Max.   :7.000  

# Split up data to make smaller join files -------------------------------------

print("Split up data to make smaller join files")

JOIN_FOSS_CPUE_HAUL <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::select(
    HAULJOIN, # Join these
    YEAR, SRVY, SURVEY, SURVEY_ID, CRUISE, 
    HAUL, VESSEL_NAME, VESSEL_ID, STATION, STRATUM, DATE_TIME, 
    BOTTOM_TEMPERATURE_C, SURFACE_TEMPERATURE_C,
    DEPTH_M, LATITUDE_DD_START, LATITUDE_DD_END, LONGITUDE_DD_START, LONGITUDE_DD_END, 
    NET_HEIGHT_M, NET_WIDTH_M, DISTANCE_FISHED_KM, DURATION_HR, AREA_SWEPT_HA, PERFORMANCE) %>% 
  dplyr::distinct()
# dim(JOIN_FOSS_CPUE_HAUL) 
# [1] 31608    24 # 2023-01-21
# [1] 31608    25 # 2023-02-12 - column change ok bc moved SRVY from catch

JOIN_FOSS_CPUE_CATCH <- FOSS_CPUE_ZEROFILLED %>% 
  dplyr::select(HAULJOIN, # join these
                SPECIES_CODE, CPUE_KGHA, CPUE_KGKM2, CPUE_NOHA, CPUE_NOKM2, COUNT, WEIGHT_KG,
                TAXON_CONFIDENCE, 
                SCIENTIFIC_NAME, COMMON_NAME, WORMS, ITIS) %>% 
  dplyr::distinct()
# dim(JOIN_FOSS_CPUE_CATCH)
# [1] 36317744       13 # 2023-01-21
# [1] 36342299       13 # 2023-02-12

# Are all of the columns represented in these two join tables?
# setdiff(names(FOSS_CPUE_ZEROFILLED), unique(c(names(JOIN_FOSS_CPUE_HAUL), names(JOIN_FOSS_CPUE_CATCH))))
# character(0) # 2023-01-21
# character(0) # 2023-02-12

# check <- dplyr::right_join(x = JOIN_FOSS_CPUE_HAUL,
#                           y = JOIN_FOSS_CPUE_CATCH,
#                           by = c("HAULJOIN"))
# 
# dim(check)
# [1] 36317744       37  # 2023-01-21
# [1] 36342299       37 # 2023-02-12

# Save public data output ------------------------------------------------------
print("save data")


## Metadata maintenance --------------------------------------------------------
metadata_column <- gap_products_metadata_column0[match(names(FOSS_CPUE_ZEROFILLED), 
                                                       toupper(gap_products_metadata_column0$metadata_colname)),]  
metadata_column$metadata_colname <- toupper(metadata_column$metadata_colname)

fix_metadata_table <- function(metadata_table0, name0, dir_out) {
  metadata_table0 <- gsub(pattern = "\n", replacement = " ", x = metadata_table0)
  metadata_table0 <- gsub(pattern = "   ", replacement = " ", x = metadata_table0)
  metadata_table0 <- gsub(pattern = "  ", replacement = " ", x = metadata_table0)
  # metadata_table0 <- gsub(pattern = "\\.([A-Za-z])", 
  #                         replacement = ". ",
  #                         x = metadata_table0)
  
  readr::write_lines(x = metadata_table0,
                     file = paste0(dir_out, name0, "_metadata_table.txt"))
  
  return(metadata_table0)
}

## Zero-fill join tables -------------------------------------------------------
metadata_table <- paste(
  "These datasets, JOIN_FOSS_CPUE_CATCH and JOIN_FOSS_CPUE_HAUL, 
when full joined by the HAULJOIN variable, 
includes zero-filled (presence and absence) observations and
catch-per-unit-effort (CPUE) estimates for all identified species at for index stations ", 
  metadata_sentence_survey_institution, 
  metadata_sentence_legal_restrict, 
  metadata_sentence_foss, 
  metadata_sentence_github, 
  metadata_sentence_codebook, 
  metadata_sentence_last_updated, 
  collapse = " ", sep = " ")
metadata_table <- fix_metadata_table(
  metadata_table0 = metadata_table, 
  name0 = "JOIN_FOSS_CPUE", 
  dir_out = dir_out)

base::save(
  JOIN_FOSS_CPUE_HAUL, 
  JOIN_FOSS_CPUE_CATCH, 
  metadata_column, 
  metadata_table, 
  file = paste0(dir_out, "FOSS_CPUE_JOIN.RData"))

## Zero filled full table ------------------------------------------------------
metadata_table <- paste(
  "This dataset includes zero-filled (presence and absence) observations and
catch-per-unit-effort (CPUE) estimates for all identified species at for index stations ", 
  metadata_sentence_survey_institution,
  metadata_sentence_legal_restrict, 
  metadata_sentence_foss, 
  metadata_sentence_github, 
  metadata_sentence_codebook, 
  metadata_sentence_last_updated, 
  collapse = " ", sep = " ")
metadata_table <- fix_metadata_table(
  metadata_table0 = metadata_table, 
  name0 = "FOSS_CPUE_ZEROFILLED", 
  dir_out = dir_out)

base::save(
  FOSS_CPUE_ZEROFILLED, 
  metadata_column, 
  metadata_table, 
  file = paste0(dir_out, "FOSS_CPUE_ZEROFILLED.RData"))

## Pres-only data --------------------------------------------------------------

FOSS_CPUE_PRESONLY <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::filter(
    !(COUNT %in% c(NA, 0) & # this will remove 0-filled values
        WEIGHT_KG %in% c(NA, 0)) | 
      !(CPUE_KGHA %in% c(NA, 0) & # this will remove usless 0-cpue values, 
          CPUE_NOKM2 %in% c(NA, 0)) ) # which shouldn't happen, but good to double check

metadata_table <- gsub(pattern = "zero-filled (presence and absence)", 
                       replacement = "presence-only",
                       x = paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_metadata_table.txt")), collapse="\n"))
metadata_table <- fix_metadata_table(
  metadata_table0 = metadata_table, 
  name0 = "FOSS_CPUE_PRESONLY", 
  dir_out = dir_out)

base::save(
  FOSS_CPUE_PRESONLY, 
  metadata_column, 
  metadata_table, 
  file = paste0(dir_out, "FOSS_CPUE_PRESONLY.RData"))

## Save CSV's ------------------------------------------------------------------

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
