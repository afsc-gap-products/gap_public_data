#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

# Load Data ----------------------------------------------------

## Oracle Data -------------------------------------------------------------
a <- list.files(path = here::here("data", "oracle"))
a <- a[!grepl(pattern = "cpue_", x = a)]
a <- a[!grepl(pattern = "empty", x = a)]
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

# Quality Codes
# 1 – High confidence and consistency.  Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable.
# 2 – Moderate confidence.  Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently.
# 3 – Low confidence.  Taxonomy is incompletely known, or reliable field identification characteristics are unknown.
df.ls <- list()
a<-list.files(path = here::here("data", "taxon_confidence"))
for (i in 1:length(a)){
  print(a[i])
  b <- readxl::read_xlsx(path = paste0(here::here("data", "taxon_confidence", a[i])), 
                         skip = 1, col_names = TRUE) %>% 
    dplyr::select(where(~!all(is.na(.x)))) %>% # remove empty columns
    janitor::clean_names() %>% 
    dplyr::rename(species_code = code)
  if (sum(names(b) %in% "quality_codes")>0) {
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

# any duplicates in any taxon confidence tables?
# SameColNames(df.ls) %>% 
#        dplyr::group_by(srvy) %>%
#        dplyr::filter(year == min(year)) %>%
#        dplyr::ungroup() %>%
#        dplyr::select(species_code, srvy) %>% 
#        table() %>% # sets up frequency table
#        data.frame() %>% 
#        dplyr::filter(Freq > 1)

tax_conf <- SameColNames(df.ls) %>% 
  dplyr::rename(SRVY = srvy) %>%
  dplyr::mutate(
                tax_conf = dplyr::case_when(
    tax_conf == 1 ~ "High",
    tax_conf == 2 ~ "Moderate",
    tax_conf == 3 ~ "Low", 
    TRUE ~ "Unassessed"))

# Wrangle Data -----------------------------------------------------------------

## Species info ----------------------------------------------------------------
spp_info <- species0 %>% 
  dplyr::select(species_code, common_name, species_name) %>% 
  dplyr::rename(scientific_name = species_name) %>%
  dplyr::mutate(common_name = gsub(pattern = "  ", replacement = " ", 
                                   x = trimws(common_name), fixed = TRUE), 
                scientific_name = gsub(pattern = "  ", replacement = " ", 
                                       x = trimws(scientific_name), fixed = TRUE))

## cruises + maxyr  + compareyr ------------------------------------------------
cruises <-  
  dplyr::left_join(
    y = surveys, 
    y = v_cruises0, 
    by  = "survey_definition_id") %>% 
  dplyr::select(cruise_id,  year, survey_name, vessel_id, cruise, survey_definition_id, 
                vessel_name, start_date, end_date, cruisejoin) %>% 
  dplyr::filter(year != 2020 & # no surveys happened this year that I care about
                  year >= 1982 &
                  year <= maxyr &
                  survey_definition_id %in% surveys$survey_definition_id) %>% 
  dplyr::rename(vessel = "vessel_id")

## haul + maxyr ----------------------------------------------------------------
haul <- dplyr::left_join(
    x = haul0, 
    y = cruises %>% 
      dplyr::select(cruisejoin, survey_definition_id, SRVY, SRVY_long), 
    by = "cruisejoin") %>%  
  dplyr::mutate(year = as.numeric(format(as.Date(haul0$start_time, 
                                                 format="%m/%d/%Y"),"%Y"))) %>%
  dplyr::filter(year <= maxyr &
                  abundance_haul == "Y" &
                  haul_type == 3 &
                  performance >= 0 &
                  !(is.null(stationid)) &
                  survey_definition_id %in% surveys$survey_definition_id) %>% 
  dplyr::select(-auditjoin) 


## station_info ----------------------------------------------------------------

station_info <- haul %>% 
  dplyr::select(stationid, stratum, start_latitude, start_longitude, SRVY) %>%
  dplyr::group_by(stationid, stratum, SRVY) %>%
  dplyr::summarise(start_latitude = mean(start_latitude, na.rm = TRUE),
                   start_longitude = mean(start_longitude, na.rm = TRUE)) 

# *** catch --------------------------------------------------------------------

catch <- catch0 

# *** catch_haul_cruises + _maxyr + maxyr-1-----------------------------------------------

  catch_haul_cruises<-
    dplyr::left_join(
      x = haul %>% 
        dplyr::select(cruisejoin, hauljoin, stationid, stratum, haul, start_time, 
                      start_latitude, start_longitude, 
                      end_latitude, end_longitude, 
                      bottom_depth, gear_temperature, surface_temperature, performance, 
                      "duration", "distance_fished" ,"net_width" ,"net_measured", "net_height"), 
      y = cruises %>% 
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


