#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

## Calculate Biomass and CPUE --------------------------------------------------

### Station-level catch data ---------------------------------------------------

# need to use a loop here and split up the effort because the 
# dplyr::crossing() can otherwise overwhelm the computer computing power
# this step may be pointless unless we need to include catchjoin as a groupby var in the catch data

cpue_biomass_station0 <- data.frame()

for (i in 1:length(surveys$SRVY)) {
  print(surveys$SRVY[i])

  temp <- catch_haul_cruises %>% 
    dplyr::filter(SRVY == surveys$SRVY[i]) 
  
  cpue_biomass_station0 <- tidyr::crossing(
    temp %>% 
      dplyr::select(year, hauljoin, cruisejoin) %>% 
      dplyr::distinct(),
    temp %>%
      dplyr::distinct(., species_code)) %>% 
    dplyr::left_join(
      x = .,
      y = temp %>%
        dplyr::select(SRVY, cruisejoin, hauljoin, species_code,
                      # stationid, stratum, haul, common_name, scientific_name, # redundant
                      distance_fished, net_width, weight, number_fish),
      by = c("species_code", "hauljoin", "cruisejoin")) %>%
    #### a check for species with weights greater then 0
    ## sum catch weight (by groups) by station and join to haul table (again) to add on relevant haul data
    dplyr::group_by(SRVY, hauljoin, cruisejoin,  species_code, 
                    # year, stationid, stratum, haul, # redundant to hauljoin?
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
    dplyr::bind_rows(cpue_biomass_station0, .)

  gc()
}

# dim(cpue_biomass_station0) # 2021
# [1] 40172310       11


# fool-proof data step: 
cpue_biomass_station0 <- cpue_biomass_station0 %>%
      dplyr::filter(
        # this will remove 0-filled values
        !(num_summed_by_station == 0 & wt_kg_summed_by_station == 0) | 
        # !(is.na(num_summed_by_station) & is.na(wt_kg_summed_by_station)) | 
        # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
        # !(cpue_kgha == 0 & cpue_noha == 0) )
          !(cpue_kgha %in% c(NA, 0) & cpue_noha %in% c(NA, 0)) )

# dim(cpue_biomass_station0) # 2021
# [1] 922752     11

cpue_biomass_station <- 
  dplyr::left_join(
    x = cpue_biomass_station0, # remove empty data
    y = catch_haul_cruises %>% 
      dplyr::select(-distance_fished, -net_width),
    by = c("SRVY", "cruisejoin", "hauljoin", "species_code")) %>%
  dplyr::rename(station = stationid, 
                weight_kg = wt_kg_summed_by_station, 
                count = num_summed_by_station, 
                srvy = SRVY,
                survey = survey_name,
                survey_id = survey_definition_id, 
                vessel_id = vessel,
                latitude_dd = start_latitude, 
                longitude_dd = start_longitude, 
                taxon_confidence = tax_conf, 
                date_time = start_time, 
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
    date_time, latitude_dd, longitude_dd, # universal when/where
    species_code, taxon_confidence, common_name, scientific_name,  # species info
    cpue_kgha, cpue_kgkm2, cpue_kg1000km2, cpue_noha, cpue_nokm2, weight_kg, count, # catch data
    depth_m, bottom_temperature_c, surface_temperature_c, #environmental data
    distance_fished_km, net_width_m, area_swept_ha # gear data
    ) %>% 
  dplyr::arrange(srvy, date_time, cpue_kgha)

# dim(cpue_biomass_station)
# [1] 922752     41

# Save Public data output ------------------------------------------------------

dir.create(path = dir_out)

files_to_save <- list("cpue_biomass_station" = cpue_biomass_station,
                      "cpue_biomass_station0" = cpue_biomass_station0)

save(cpue_biomass_station,
     file = paste0(dir_out,"cpue_biomass_station"))

for (i in 1:length(files_to_save)) {
  readr::write_csv(
    x = files_to_save[i][[1]], 
    file = paste0(dir_out, names(files_to_save)[i], ".csv"), 
    col_names = TRUE)
}

data_new <- cpue_biomass_station
