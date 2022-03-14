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
  assign(x = gsub(pattern = "\\.csv", replacement = "", x = paste0(a[i], "0")), value = b) # 0 at the end of the name indicates that it is the orig unmodified file
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
  dplyr::mutate(tax_conf = dplyr::case_when(
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

## cruises ------------------------------------------------

cruises <-  
  dplyr::left_join(
    x = surveys, 
    y = v_cruises0, 
    by  = c("survey_definition_id")) %>% 
  dplyr::select(SRVY, SRVY_long, region, cruise_id,  year, survey_name, vessel_id, cruise, survey_definition_id, 
                vessel_name, start_date, end_date, cruisejoin) %>% 
  dplyr::filter(year != 2020 & # no surveys happened this year that I care about
                  year >= 1982 &
                  year <= maxyr &
                  survey_definition_id %in% surveys$survey_definition_id) %>% 
  dplyr::rename(vessel = "vessel_id")

## haul ----------------------------------------------------------------

haul <- haul0 %>%
  # dplyr::mutate(year = as.numeric(format(as.Date(haul0$start_time, 
  #                                                format="%m/%d/%Y"),"%Y"))) %>%
  dplyr::filter(
    abundance_haul == "Y" &
    haul_type == 3 &
    performance >= 0 &
    !(is.null(stationid)) &
    !(is.na(stationid)) ) %>% 
  dplyr::select(-auditjoin, -net_measured) 

# > dim(haul)
# [1] 33909    29

## station_info ----------------------------------------------------------------

# station_info <- haul %>% 
#   dplyr::select(stationid, stratum, stasrt_latitude, start_longitude, SRVY) %>%
#   dplyr::group_by(stationid, stratum, SRVY) %>%
#   dplyr::summarise(start_latitude = mean(start_latitude, na.rm = TRUE),
#                    start_longitude = mean(start_longitude, na.rm = TRUE)) 

## catch --------------------------------------------------------------------

catch <- catch0 %>% 
  dplyr::select(-subsample_code, -voucher, -auditjoin)

# dim(catch) # 2021
# [1] 1613690      10

if (use_catchjoin) {
  
# ## weight and number_fish mismatch when summarized by species_code
# catch %>% 
#   dplyr::mutate(id = paste0(region, "_", cruisejoin, "_", hauljoin, "_", species_code)) %>%
#   dplyr::select(id) %>%
#   table() %>%
#   data.frame() %>%
#   dplyr::rename("id" = ".") %>% 
#   dplyr::filter(Freq > 1)
# 
# ## no weight and number_fish mismatch when summarized by catchjoin - WHY? Do we need that specificity? assuming not...?
# catch %>% 
#   dplyr::mutate(id = paste0(region, "_", cruisejoin, "_", hauljoin, "_", catchjoin)) %>% # how is species_code not redundnat to catchjoin?
#   dplyr::select(id) %>%
#   table() %>%
#   data.frame() %>%
#   dplyr::rename("id" = ".") %>% 
#   dplyr::filter(Freq > 1)
# 
# catch_haul_cruises %>%
#   dplyr::filter(SRVY == "AI" &
#                   cruisejoin == 1138955 &
#                   hauljoin == 1139161 &
#                   species_code == 91030)
# 
# catch %>%
#   dplyr::filter(region == "AI" &
#                   cruisejoin == 1138955 &
#                   hauljoin == 1139161 &
#                   species_code == 91030)
# 
# catch %>%
#   dplyr::filter(region == "AI" &
#                   cruisejoin == 327 &
#                   hauljoin == 32854 &
#                   species_code == 21341)
# 
# catch %>%
#   dplyr::filter(region == "GOA" &
#                   cruisejoin == 881074 &
#                   hauljoin == 881110 &
#                   species_code == 91030)
# 
# catch %>%
#   dplyr::filter(region == "GOA" &
#                   cruisejoin == 881074 &
#                   hauljoin == 881111 &
#                   species_code == 91030)

# if we don't use catchjoin, we need to summarize by species_code... right?

catch <- catch %>% 
  dplyr::group_by(region, cruisejoin, hauljoin, vessel, haul, species_code) %>% 
  dplyr::summarise(weight = sum(weight, na.rm = TRUE), 
                   number_fish = sum(number_fish, na.rm = TRUE))

# dim(catch) # 2021
# [1] 1613668       7

}
## catch_haul_cruises + _maxyr + maxyr-1-----------------------------------------------

catch_haul_cruises <-
  dplyr::inner_join(
    x = cruises %>% 
      dplyr::select(cruisejoin, vessel, region,  
                    survey_definition_id, SRVY, SRVY_long, survey_name, year, cruise),  
    y = haul %>% 
      dplyr::select(cruisejoin, vessel, region, 
                    hauljoin, stationid, stratum, haul, start_time, 
                    start_latitude, start_longitude, end_latitude, end_longitude, 
                    bottom_depth, gear_temperature, surface_temperature, performance, 
                    duration, distance_fished, net_width, net_height), 
    by = c("cruisejoin", "vessel", "region")) %>% 
  dplyr::left_join(
    x= ., 
    y = catch %>% 
      dplyr::select(cruisejoin, hauljoin, region, vessel, haul, if(use_catchjoin){all_vars("catchjoin")}, 
                    species_code, weight, number_fish), 
    by = c("hauljoin", "cruisejoin", "region", "vessel", "haul")) %>% 
  dplyr::left_join(x = ., 
                   y = tax_conf %>% 
                     dplyr::select(year, tax_conf, SRVY, species_code), 
                   by = c("species_code", "SRVY", "year"))  %>%
  dplyr::left_join(
    x = .,
    y = vessels0 %>%
      dplyr::select(vessel_id, name) %>%
      dplyr::rename(vessel_name = name) %>% 
      dplyr::mutate(vessel_name = stringr::str_to_title(vessel_name)), 
    by = c("vessel" = "vessel_id")) %>%
  dplyr::left_join(
    x = .,
    y = spp_info %>%
      dplyr::select(species_code, scientific_name, common_name),
    by = "species_code")

# dim(catch_haul_cruises) # 2021
# [1] 922757     33
