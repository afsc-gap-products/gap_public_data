#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

# Load Data ----------------------------------------------------

## Oracle Data -------------------------------------------------------------
a<-list.files(path = here::here("data", "oracle"))
for (i in 1:length(a)){
  print(a[i])
  b <- readr::read_csv(file = paste0(here::here("data", "oracle", a[i]))) %>% 
    janitor::clean_names(.)
  if (names(b)[1] %in% "x1"){
    b$x1<-NULL
  }
  assign(x = gsub(pattern = "\\.csv", replacement = "", x = paste0(a[i], "0")), value = b)
}

## Taxonomic confidence data ---------------------------------------------------

#Quality Codes
# 1 – High confidence and consistency.  Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable.
# 2 – Moderate confidence.  Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently.
# 3 – Low confidence.  Taxonomy is incompletely known, or reliable field identification characteristics are unknown.

df.ls <- list()
a<-list.files(path = here::here("data", "taxon_confidence"))
for (i in 1:length(a)){
  print(a[i])
  b <- readxl::read_xlsx(path = paste0(here::here("data", "taxon_confidence", a[i])), 
                         skip = 1) %>% 
    dplyr::select(where(~!all(is.na(.x)))) %>% # remove empty columns
    janitor::clean_names() %>% 
    dplyr::rename(species_code = code)
  if (names(b)[1] %in% "quality_codes"){
    b$quality_codes<-NULL
  }
  b <- b %>% 
    tidyr::pivot_longer(cols = starts_with("x"), 
                        names_to = "year", 
                        values_to = "tax_conf") %>% 
    dplyr::mutate(year = 
                    as.numeric(gsub(pattern = "[a-z]", 
                                    replacement = "", 
                                    x = year))) %>% 
    dplyr::distinct()
  
  cc <- strsplit(x = gsub(x = gsub(x = a[i], pattern = "Taxon_confidence_", replacement = ""), pattern = ".xlsx", replacement = ""), split = "_")[[1]]
  
  if (length(cc) == 1) {
    b$SRVY <- cc
  } else {
    bb <- data.frame()
    for (ii in 1:length(cc)){
      bbb <- b
      bbb$SRVY <- cc[ii]
      bb <- rbind.data.frame(bb, bbb)
    }
    b<-bb
  }
  
  # assign(x = gsub(pattern = "\\.xlsx", replacement = "", x = paste0(a[i], "0")), value = b)
  df.ls[[i]]<-b
  names(df.ls)[i]<-a[i]
}
tax_conf <- SameColNames(df.ls) %>% 
  dplyr::rename(SRVY = srvy) #%>%
  # dplyr::left_join(
  #   x = ., 
  #   y = survey_data, 
  #   by = "SRVY")

# Wrangle Data -----------------------------------------------------------------

## Species info ----------------------------------------------------------------
spp_info <- species_classification0 

## cruises + maxyr  + compareyr ------------------------------------------------
cruises <- v_cruises0 %>% 
  dplyr::select(cruise_id,  year, survey_name, vessel_id, cruise, survey_definition_id, 
                vessel_name, start_date, end_date, cruisejoin) %>% 
  dplyr::filter(year != 2020 & # no surveys happened this year that I care about
                  year >= 1982 &
                  year <= maxyr &
                  survey_definition_id %in% survey_data$survey_definition_id) %>% 
  dplyr::mutate(vess_shape = substr(x = vessel_name, 1,1)) %>%
  dplyr::mutate(vessel_ital = paste0("F/V *", 
                                     stringr::str_to_title(vessel_name), "*")) %>%
  dplyr::mutate(vessel_name = paste0("F/V ", 
                                     stringr::str_to_title(vessel_name))) %>%
  dplyr::left_join(
    x = ., 
    y = survey_data, 
    by  = "survey_definition_id") %>% 
  dplyr::rename(vessel = "vessel_id")

## haul + maxyr ----------------------------------------------------------------
haul <- dplyr::left_join(
    x = haul0, 
    y = cruises %>% 
      dplyr::select(cruisejoin, survey_definition_id, SRVY, SRVY_long), 
    by = "cruisejoin") %>%  
  dplyr::mutate(year = as.numeric(substr(x = start_time, 1,4))) %>% 
  dplyr::filter(year <= maxyr &
                  abundance_haul == "Y" &
                  haul_type == 3 &
                  performance >= 0 &
                  !(is.null(stationid)) &
                  survey_definition_id %in% survey_data$survey_definition_id) %>% 
  dplyr::select(-auditjoin) 


# as.POSIXct(haul0$start_time, format = '%d%b%Y:%H:%M:%S')

## stratum_info (survey area) --------------------------------------------------

stratum_info <- stratum0 %>%
  dplyr::mutate(region = dplyr::case_when(
    stratum %in% 
      akgfmaps::get_base_layers(select.region = "nbs")$survey.strata$Stratum & 
      region == "BS" ~ "NBS",  
    region == "BS" & 
      grepl(pattern = "Bering Sea Slope Survey", 
            x = description, ignore.case = TRUE) ~ "BSSlope",  
    # region == "BS" & grepl(pattern = "Slope", x = description, ignore.case = TRUE) ~ "BSSlope", 
    region == "BS" & grepl(pattern = "EBS Slope Survey", 
                           x = description, ignore.case = TRUE) ~ "BSSlope",  
    region == "BS" ~ "EBS", 
    TRUE ~ region)) %>% 
  dplyr::select(region, year, stratum, area) %>% 
  dplyr::group_by(region) %>% 
  dplyr::filter(year == max(year)) %>%
  dplyr::bind_rows(., 
                   data.frame(region = "AI", year = NA, 
                              stratum = unique(akgfmaps::get_base_layers(select.region = "ai")$survey.strata$STRATUM))) %>% 
  dplyr::ungroup() %>% 
  dplyr::rename(SRVY = region)
  
# strat_yr0 <- strat_yr %>% 
#   dplyr::group_by(region) %>% 
#   dplyr::summarise(most_recent_strat_yr = max(year, na.rm = TRUE)) %>% 
#   dplyr::left_join(x = survey_data, 
#                    y = ., 
#                    by = c("SRVY" = "region")) 

# temp <- function(yr) {
#   stratum_info <- stratum0 %>% 
#     dplyr::filter(
#       stratum %in% reg_dat$survey.strata$Stratum &
#         year == strat_yr) %>%
# 
#     dplyr::select(-auditjoin, -portion) %>%
#     dplyr::mutate(SRVY = dplyr::case_when(
#       stratum %in% as.numeric(report_types$EBS$reg_dat$survey.strata$Stratum) ~ "EBS", 
#       stratum %in% as.numeric(report_types$NBS$reg_dat$survey.strata$Stratum) ~ "NBS" 
#     )) %>% 
#     dplyr::filter(SRVY %in% SRVY1) %>% 
#     dplyr::mutate(type = dplyr::case_when( 
#       SRVY == "NBS" ~ "Shelf",
#       depth %in% "<50" ~ "Inner Shelf", 
#       depth %in% c("50-100", ">50") ~ "Middle Shelf", 
#       depth %in% c("100-200", ">100") ~ "Outer Shelf"
#     )) %>% 
#     dplyr::mutate(area_km2 = area, 
#                   area_ha = area/divkm2forha, 
#                   area_nmi2 = area/divkm2fornmi2)
#   
#   return(stratum_info)
#   
# }
# 
# stratum_info <- temp(yr = maxyr)

## station_info ----------------------------------------------------------------

station_info <- haul %>% #
  dplyr::select(stationid, stratum, start_latitude, start_longitude, SRVY) %>%
  dplyr::group_by(stationid, stratum, SRVY) %>%
  dplyr::summarise(start_latitude = mean(start_latitude, na.rm = TRUE),
                   start_longitude = mean(start_longitude, na.rm = TRUE)) %>%
  dplyr::left_join(y = .,
                   x = stratum_info %>%
                     dplyr::select(stratum, SRVY),
                   by = c("stratum", "SRVY")) 


## haul_cruises_vess_ + _maxyr + _compareyr ------------------------------------

temp <- function(cruises_, haul_){
  haul_cruises_vess_ <- 
    dplyr::left_join(x = cruises_ ,
                     y = haul_ %>% 
                       dplyr::select(cruisejoin, hauljoin, stationid, stratum, haul, 
                                     gear_depth, duration, distance_fished, net_width, net_height,
                                     start_time) %>% 
                       dplyr::group_by(cruisejoin, hauljoin, stationid, stratum, haul, 
                                       gear_depth, duration, distance_fished, net_width, net_height) %>% 
                       dplyr::summarise(start_date_haul = min(start_time), 
                                        end_date_haul = max(start_time), 
                                        stations_completed = length(unique(stationid))), 
                     by = c("cruisejoin")) %>% 
    dplyr::left_join(x = . , 
                     y = vessels0 %>%
                       dplyr::rename(vessel = vessel_id) %>%
                       dplyr::select(vessel, length, tonnage), 
                     by = "vessel") %>% 
    dplyr::rename(length_ft = length) %>% 
    dplyr::mutate(length_m = round(length_ft/3.28084, 
                                   digits = 1)) %>% 
    dplyr::ungroup()
}

haul_cruises_vess <- temp(cruises, haul) 

# *** vessel_info -------------------------------------------------------

# vessel_info <-  haul_cruises_vess_maxyr %>% 
#   dplyr::select("vessel_name", "vessel_ital", "vessel", "tonnage",
#                 "length_m", "length_ft", "vess_shape") %>% 
#   unique()

# *** haul_cruises_maxyr + _compareyr ------------------------------------------

temp <- function(haul_cruises_vess_){
  
  haul_cruises_ <- 
    dplyr::left_join(
      x = haul_cruises_vess_ %>% 
        dplyr::select("year", "survey_name", "cruise", #"SRVY_start" , 
                      "survey_definition_id", "SRVY", #"SRVY_long", #hauljoin, 
                      cruisejoin) %>%
        unique(), 
      y = haul_cruises_vess_ %>% 
        dplyr::select("cruise", "stations_completed", 
                      start_date_haul, end_date_haul#, start_date_cruise, end_date_cruise
                      ) %>% 
        dplyr::group_by(cruise) %>% 
        dplyr::summarise(stations_completed = sum(stations_completed, na.rm = TRUE), 
                         start_date_haul = min(start_date_haul, na.rm = TRUE), 
                         end_date_haul = max(end_date_haul, na.rm = TRUE)#, 
                         # start_date_cruise = min(start_date_cruise, na.rm = TRUE), 
                         # end_date_cruise = max(end_date_cruise, na.rm = TRUE)
                         ), 
      by = "cruise") %>% 
    dplyr::left_join(
      x = ., 
      y = station_info %>% 
        dplyr::group_by(SRVY) %>% 
        dplyr::summarise(stations_avail = length(unique(stationid))),
      by = "SRVY") %>% 
    dplyr::left_join(
      x = ., 
      y = cruises %>% 
        dplyr::select(year, SRVY) %>%
        unique() %>%
        dplyr::count(vars = SRVY) %>%
        dplyr::rename(yrofsurvey = n, 
                      SRVY = vars), 
      by = "SRVY") %>% 
    dplyr::select(- cruisejoin) %>%
    dplyr::mutate(stndth = NMFSReports::stndth(yrofsurvey))  %>% 
    dplyr::arrange(SRVY) %>% 
    # dplyr::mutate(compareyr = compareyr[1]) %>%
    # c(compareyr_ebs, if(exists("compareyr_nbs")) {compareyr_nbs} )) %>% 
    # dplyr::left_join(
    #   x = ., 
    #   y = data.frame(
    #     SRVY = SRVY1,
    #     compareyr_ref = c(ref_compareyr_ebs, if(exists("ref_compareyr_nbs")) {ref_compareyr_nbs} )), 
    #   by = "SRVY") %>%
    unique()
  
}

haul_cruises <- temp(haul_cruises_vess_ = haul_cruises_vess) 

# *** catch --------------------------------------------------------------------

## assigns groups based on species code
## 2 "other crab" groups because species codes 69010: 69200 are hermit crabs
catch <- catch0 

# *** catch_haul_cruises_maxyr + maxyr-1-----------------------------------------------

temp <- function(cruises_, haul_, catch, tax_conf){
  # This year's data
  catch_haul_cruises_<-
    dplyr::left_join(
      x = haul_ %>% 
        dplyr::select(cruisejoin, hauljoin, stationid, stratum, haul, start_time, 
                      start_latitude, start_longitude, 
                      end_latitude, end_longitude, 
                      bottom_depth, gear_temperature, surface_temperature, performance, 
                      "duration", "distance_fished" ,"net_width" ,"net_measured", "net_height"), 
      y = cruises_ %>% 
        dplyr::select(cruisejoin, survey_name, SRVY, year, cruise),  
      by = c("cruisejoin")) %>% 
    dplyr::left_join(
      x= ., 
      y = catch %>% 
        dplyr::select(cruisejoin, hauljoin,
                      species_code, weight,
                      number_fish, subsample_code), 
      by = c("hauljoin", "cruisejoin")) %>% 
    dplyr::left_join(x = ., 
                     y = tax_conf, 
                     by = c("species_code", "SRVY", "year")) 
}

catch_haul_cruises <- temp(cruises, haul, catch, tax_conf)


