#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

## Calculate Biomass and CPUE --------------------------------------------------

cpue_biomass_station <- data.frame()
cpue_biomass_stratum <- data.frame()
cpue_biomass_total <- data.frame()

for (i in 1:length(survey_data$SRVY)) {
  print(survey_data$SRVY[i])
  
  ### Station-level ------------------------------------------------------------
  
  temp <- catch_haul_cruises %>% 
    dplyr::filter(SRVY == survey_data$SRVY[i])
  
  cpue_biomass_station0 <- tidyr::crossing(
    temp %>% dplyr::select(SRVY, year, hauljoin, cruisejoin) %>% #stationid, stratum, 
      dplyr::distinct(),
    dplyr::distinct(
      temp %>%
        dplyr::filter(SRVY %in% unique(survey_data$SRVY)),
      species_code)) %>% 
    dplyr::left_join(
      x = .,
      y = temp %>%
        dplyr::select("cruisejoin", "hauljoin", "cruisejoin", "species_code",
                      "weight", "number_fish", "SRVY", common_name, scientific_name, 
                      stationid, stratum, distance_fished, net_width),
      by = c("species_code", "hauljoin", "cruisejoin", "SRVY")) %>%
    #### a check for species with weights greater then 0
    ## sum catch weight (by groups) by station and join to haul table (again) to add on relevent haul data
    dplyr::group_by(SRVY, year, stationid, species_code, common_name, scientific_name, hauljoin, stratum, distance_fished, net_width) %>%
    dplyr::summarise(wt_kg_summed_by_station = sum(weight, na.rm = TRUE), # overwrite NAs in assign_group_zeros where data exists
                     num_summed_by_station = sum(number_fish, na.rm = TRUE)) %>% # overwrite NAs in
    
    ## checks catch_and_zeros table for species that are not in groups, if species are not grouped
    #### add group to assign_groups table
    ## calculates CPUE for each species group by station
    mutate(effort = distance_fished * net_width/10) %>%
    mutate(cpue_kgha = wt_kg_summed_by_station/effort) %>%
    mutate(cpue_noha = ifelse(wt_kg_summed_by_station > 0 & num_summed_by_station == 0, NA,
                              (cpue_no = num_summed_by_station/effort))) %>%
    #### this is to check CPUEs by group, station and year against the SQL code
    ## add area to CPUE table
    dplyr::ungroup() %>% 
    dplyr::left_join(x = .,
                     y = stratum_info %>%
                       dplyr::select(stratum, area),
                     by = 'stratum')  %>% 
    dplyr::left_join(x = ., 
                     y = station_info, 
                     by = c("stationid", "SRVY", "stratum")) %>% 
    dplyr::rename(latitude = start_latitude, 
                  longitude = start_longitude) %>% 
    dplyr::filter(!is.na(stationid))
  
  cpue_biomass_station <- dplyr::bind_rows(
    cpue_biomass_station0, 
    cpue_biomass_station)
  remove(cpue_biomass_station0)
  
  # ### Stratum-level ------------------------------------------------------------
  # cpue_biomass_stratum0 <- cpue_biomass_station0 %>%
  #   ## calculates mean CPUE (weight) by year, group, stratum, and area
  #   dplyr::ungroup() %>%
  #   dplyr::group_by(year, scientific_name, common_name, species_code, #group, taxon, species_name1, print_name, 
  #                   stratum, area, SRVY) %>%
  #   dplyr::summarise(cpue_by_group_stratum = mean(cpue_kgha, na.rm = TRUE)) %>% # TOLEDO - na.rm = T?
  #   ## creates column for meanCPUE per group/stratum/year*area of stratum
  #   dplyr::mutate(mean_cpue_times_area = (cpue_by_group_stratum * area)) %>%
  #   ## calculates sum of mean CPUE*area (over the 3 strata)
  #   dplyr::ungroup() 
  # 
  # cpue_biomass_stratum <- dplyr::bind_rows(
  #   cpue_biomass_stratum0, 
  #   cpue_biomass_stratum)
  # remove(cpue_biomass_stratum0)
  # 
  # cpue_biomass_total0 <- cpue_biomass_stratum0 %>%
  #   dplyr::group_by(year, SRVY, scientific_name, common_name, species_code #species_name, species_name1, print_name, taxon
  #   ) %>%
  #   dplyr::summarise(mean_CPUE_all_strata_times_area =
  #                      sum(mean_cpue_times_area, na.rm = TRUE)) %>% # TOLEDO - na.rm = T?
  #   
  #   # calculates total area by adding up the unique area values (each strata has a different value)
  #   dplyr::left_join(
  #     x = ., 
  #     y = cpue_biomass_station %>% 
  #       dplyr::ungroup() %>%
  #       dplyr::select(area, SRVY) %>% 
  #       dplyr::distinct() %>%
  #       dplyr::group_by(SRVY) %>% 
  #       dplyr::summarise(total_area = sum(area, na.rm = TRUE)), 
  #     by = "SRVY") %>%
  #   
  #   ## creates column with weighted CPUEs
  #   dplyr::mutate(weighted_CPUE = (mean_CPUE_all_strata_times_area / total_area)) %>%
  #   ### uses WEIGHTED CPUEs to calculate biomass
  #   ## includes empty shells and debris
  #   dplyr::group_by(year, SRVY, scientific_name, common_name, species_code) %>%
  #   dplyr::mutate(biomass_mt = weighted_CPUE*(total_area*.1)) %>%
  #   # total biomass excluding empty shells and debris for each year
  #   dplyr::filter(common_name != 'empty shells and debris')  %>%
  #   dplyr::ungroup()
  # 
  # ### Survey-level ------------------------------------------------------------
  # cpue_biomass_total <- dplyr::bind_rows(
  #   cpue_biomass_total0, 
  #   cpue_biomass_total)
  # remove(cpue_biomass_total0)
  
  gc()
  
}

cpue_biomass_station0 <- cpue_biomass_station
cpue_biomass_station <- 
  dplyr::left_join(
    x = cpue_biomass_station %>% 
      dplyr::select(-effort, -area, -net_width, -latitude, -longitude, 
                    -scientific_name, -common_name) %>% # 
      dplyr::filter(!(num_summed_by_station == 0 & 
                        wt_kg_summed_by_station == 0)), # remove empty data 
    y = catch_haul_cruises %>% 
      dplyr::select(#cruisejoin, 
        hauljoin, stationid, stratum, #survey_definition_id, 
        haul, start_time, start_latitude, start_longitude, 
        bottom_depth, gear_temperature, surface_temperature, 
        survey_name, SRVY, year, cruise, species_code, tax_conf), 
    by = c("SRVY", "year", "stationid", "hauljoin", "stratum", "species_code")) %>% 
  dplyr::left_join(
    x = ., 
    y = haul_cruises_vess %>% 
      dplyr::select(hauljoin, vessel_name, vessel, survey_definition_id) %>% 
      distinct(), 
    by = c("hauljoin")) %>%
  dplyr::left_join(
    x = ., 
    y = spp_info %>% 
      dplyr::select(species_code, report_name_scientific, common_name) %>% 
      dplyr::rename(scientific_name = report_name_scientific), 
    by = "species_code"
  ) %>%
  dplyr::select(-hauljoin, -distance_fished) %>% 
  dplyr::rename(station = "stationid", 
                taxon_weight_kg = "wt_kg_summed_by_station", 
                taxon_count = "num_summed_by_station", 
                vessel_id = vessel, 
                srvy = SRVY,
                survey = survey_name,
                survey_id = survey_definition_id, 
                # species_common = common_name,  #dream
                # species_scientific = scientific_name, #dream
                # "cpue_kgha", 
                # "cpue_noha", 
                taxon_confidence = tax_conf, 
                date = "start_time", # where would I get time from? 
                latitude_dd = "start_latitude", 
                longitude_dd ="start_longitude", 
                surface_temperature_c = "surface_temperature",
                # "survey_name", 
                # "cruise", 
                depth_m = "bottom_depth", 
                bottom_temperature_c = "gear_temperature") %>% 
  dplyr::mutate(cpue_kgkm2 = cpue_kgha/100, 
                cpue_nokm2 = cpue_noha/100, 
                cpue_kg1000km2 = round(x = (cpue_kgha/100)*1000, digits = 6)) %>% 
  dplyr::relocate(
    year, srvy, survey, survey_id, cruise, stratum, station, 
    haul, vessel_name, vessel_id, # survey data
    date, latitude_dd, longitude_dd, # universal when/where
    species_code, taxon_confidence, common_name, scientific_name,  # species info
    cpue_kgha, cpue_kgkm2, cpue_noha, cpue_nokm2, taxon_weight_kg, taxon_count, # catch data
    depth_m, bottom_temperature_c, surface_temperature_c) %>% #environmental data
  dplyr::arrange(srvy, date, cpue_kgha) %>% 
  dplyr::mutate(common_name = gsub(pattern = "  ", replacement = " ", 
                                   x = trimws(common_name), fixed = TRUE), 
                scientific_name = gsub(pattern = "  ", replacement = " ", 
                                   x = trimws(scientific_name), fixed = TRUE))

# Save Public data output ------------------------------------------------------

dir.create(path = dir_out)

files_to_save <- list("cpue_biomass_station" = cpue_biomass_station#,
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
