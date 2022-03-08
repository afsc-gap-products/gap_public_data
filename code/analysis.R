#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

## Calculate Biomass and CPUE --------------------------------------------------

cpue_biomass_station0 <- data.frame()
# cpue_biomass_stratum <- data.frame()
# cpue_biomass_total <- data.frame()

for (i in 1:length(surveys$SRVY)) {
  print(surveys$SRVY[i])
  
  ### Station-level ------------------------------------------------------------
  
  temp <- catch_haul_cruises %>% 
    dplyr::filter(SRVY == surveys$SRVY[i]) %>% 
    dplyr::filter(!is.na(stationid))
  
  temp1 <- tidyr::crossing(
    temp %>% 
      dplyr::select(year, hauljoin, cruisejoin) %>% 
      dplyr::distinct(),
    temp %>%
      dplyr::distinct(. ,species_code)) %>% 
    dplyr::left_join(
      x = .,
      y = temp %>%
        dplyr::select(SRVY, cruisejoin, hauljoin,  
                      stationid, stratum, distance_fished, net_width, 
                      species_code, common_name, scientific_name,
                      weight, number_fish),
      by = c("species_code", "hauljoin", "cruisejoin")) %>%
    #### a check for species with weights greater then 0
    ## sum catch weight (by groups) by station and join to haul table (again) to add on relevent haul data
    dplyr::group_by(year, SRVY, hauljoin, cruisejoin, stationid, stratum, 
                    species_code, #common_name, scientific_name, 
                    distance_fished, net_width) %>%
    dplyr::summarise(
      wt_kg_summed_by_station = sum(weight, na.rm = TRUE), # overwrite NAs in assign_group_zeros where data exists
      num_summed_by_station = sum(number_fish, na.rm = TRUE)) %>%  # overwrite NAs in
    dplyr::ungroup() %>% 
    dplyr::mutate(
      area_swept_ha = (distance_fished * net_width/10), ## calculates CPUE for each species group by station
      cpue_kgha = (wt_kg_summed_by_station/area_swept_ha), 
      cpue_noha = ifelse(wt_kg_summed_by_station > 0 & num_summed_by_station == 0, NA,
                              (cpue_no = num_summed_by_station/area_swept_ha))) %>%
    # dplyr::left_join(x = ., 
    #                  y = station_info, 
    #                  by = c("stationid", "SRVY", "stratum")) %>% 
    # dplyr::rename(latitude_dd = start_latitude, 
    #               longitude_dd = start_longitude) %>% 
    dplyr::filter(!is.na(stationid))
  
  cpue_biomass_station0 <- dplyr::bind_rows(
    cpue_biomass_station0, 
    temp1)
  remove(temp1)
  
  gc()
  
}

cpue_biomass_station0 <- cpue_biomass_station0 %>%
      dplyr::filter(!(num_summed_by_station == 0 &
                        wt_kg_summed_by_station == 0))

cpue_biomass_station <- #cpue_biomass_station0 %>% 
  dplyr::left_join(
    x = cpue_biomass_station0, # remove empty data
    y = catch_haul_cruises  %>% 
      dplyr::filter(!is.na(stationid))%>%
      dplyr::select(
        year, SRVY, hauljoin, cruisejoin, cruise, haul, stationid, stratum, species_code, 
        survey_name, tax_conf, 
        start_latitude, start_longitude, 
        start_time, bottom_depth, gear_temperature, surface_temperature) %>% 
      dplyr::distinct(),
    by = c("year", "SRVY", "hauljoin", "cruisejoin", "stationid", 
           "stratum", "species_code")) %>%
  dplyr::left_join(
    x = ., 
    y = haul_cruises_vess %>% 
      dplyr::select(year, SRVY, hauljoin, cruisejoin, stationid, stratum, 
                    vessel_name, vessel, survey_definition_id) %>% 
      distinct(), 
    by = c("year", "SRVY", "hauljoin", "cruisejoin", "stationid", "stratum")) %>%
  dplyr::left_join(
    x = .,
    y = spp_info %>%
      dplyr::select(species_code, scientific_name, common_name),
    by = "species_code") %>%
  dplyr::rename(station = stationid, 
                weight_kg = wt_kg_summed_by_station, 
                count = num_summed_by_station, 
                vessel_id = vessel, 
                srvy = SRVY,
                survey = survey_name,
                survey_id = survey_definition_id, 
                latitude_dd = start_latitude, 
                longitude_dd = start_longitude, 
                taxon_confidence = tax_conf, 
                date = start_time, 
                latitude_dd = start_latitude, 
                longitude_dd = start_longitude, 
                bottom_temperature_c = gear_temperature, 
                surface_temperature_c = surface_temperature,
                distance_fished_km = distance_fished, 
                net_width_m = net_width,
                depth_m = bottom_depth) %>% 
  dplyr::mutate(cpue_kgkm2 = cpue_kgha * 100, 
                cpue_nokm2 = cpue_noha * 100, 
                cpue_kg1000km2 = round(x = cpue_kgkm2*1000, digits = 6), 
                dplyr::across(dplyr::starts_with("cpue_"), round, digits = 6), 
                common_name = ifelse(is.na(common_name), "", common_name), 
                scientific_name = ifelse(is.na(scientific_name), "", scientific_name)) %>% 
  dplyr::relocate(
    year, srvy, survey, survey_id, cruise, stratum, station, 
    haul, vessel_name, vessel_id, # survey data
    date, latitude_dd, longitude_dd, # universal when/where
    species_code, taxon_confidence, common_name, scientific_name,  # species info
    cpue_kgha, cpue_kgkm2, cpue_kg1000km2, cpue_noha, cpue_nokm2, weight_kg, count, # catch data
    depth_m, bottom_temperature_c, surface_temperature_c, #environmental data
    distance_fished_km, net_width_m, area_swept_ha # gear data
    ) %>% 
  dplyr::arrange(srvy, date, cpue_kgha)

# Save Public data output ------------------------------------------------------

dir.create(path = dir_out)

files_to_save <- list("cpue_biomass_station" = cpue_biomass_station,
                      "cpue_biomass_station0" = cpue_biomass_station0
                      #"cpue_biomass_stratum" = cpue_biomass_stratum,
                      #"cpue_biomass_total" = cpue_biomass_total
                      )

save(cpue_biomass_station,# cpue_biomass_stratum, cpue_biomass_total, 
     file = paste0(dir_out,"cpue_biomass_station"))

for (i in 1:length(files_to_save)) {
  readr::write_csv(
    x = files_to_save[i][[1]], 
    file = paste0(dir_out, names(files_to_save)[i], ".csv"), 
    col_names = TRUE)
}

data_new <- cpue_biomass_station
