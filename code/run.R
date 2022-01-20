#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------


# No stratum listed for AI in racebase.stratum???
# where do I get YYY/MM/DD HH:MM? I have YYY/MM/DD
# changes to spp sci and common name

# START ------------------------------------------------------------------------

# *** REPORT KNOWNS ------------------------------------------------------------

maxyr <- 2021 

# The surveys we will consider covering
survey_data <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSSlope"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope"))

# for (i in 1:) {
# a <- paste0(akgfmaps::get_base_layers(select.region = "ebs")$survey.strata$Stratum, ", ", collapse = "")
# # a<-a[1:(nchar(a)-2)]
# }

# *** SOURCE SUPPORT SCRIPTS ---------------------------------------------------

source('./code/functions.R')

# source('./code/dataDL.R')

source('./code/data.R')

# Run Analysis -----------------------------------------------------------------

## Calculate Biomass and CPUE --------------------------------------------------

cpue_biomass_station <- data.frame()
cpue_biomass_stratum <- data.frame()
cpue_biomass_total <- data.frame()

for (i in 1:length(survey_data$SRVY)) {
  print(survey_data$SRVY[i])
  
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
  
  cpue_biomass_stratum0 <- cpue_biomass_station0 %>%
    ## calculates mean CPUE (weight) by year, group, stratum, and area
    dplyr::ungroup() %>%
    dplyr::group_by(year, scientific_name, common_name, species_code, #group, taxon, species_name1, print_name, 
                    stratum, area, SRVY) %>%
    dplyr::summarise(cpue_by_group_stratum = mean(cpue_kgha, na.rm = TRUE)) %>% # TOLEDO - na.rm = T?
    ## creates column for meanCPUE per group/stratum/year*area of stratum
    dplyr::mutate(mean_cpue_times_area = (cpue_by_group_stratum * area)) %>%
    ## calculates sum of mean CPUE*area (over the 3 strata)
    dplyr::ungroup() 
  
  cpue_biomass_stratum <- dplyr::bind_rows(
    cpue_biomass_stratum0, 
    cpue_biomass_stratum)
  
  cpue_biomass_total0 <- cpue_biomass_stratum0 %>%
    dplyr::group_by(year, SRVY, scientific_name, common_name, species_code #species_name, species_name1, print_name, taxon
    ) %>%
    dplyr::summarise(mean_CPUE_all_strata_times_area =
                       sum(mean_cpue_times_area, na.rm = TRUE)) %>% # TOLEDO - na.rm = T?
    
    # calculates total area by adding up the unique area values (each strata has a different value)
    dplyr::left_join(
      x = ., 
      y = cpue_biomass_station %>% 
        dplyr::ungroup() %>%
        dplyr::select(area, SRVY) %>% 
        dplyr::distinct() %>%
        dplyr::group_by(SRVY) %>% 
        dplyr::summarise(total_area = sum(area, na.rm = TRUE)), 
      by = "SRVY") %>%
    
    ## creates column with weighted CPUEs
    dplyr::mutate(weighted_CPUE = (mean_CPUE_all_strata_times_area / total_area)) %>%
    ### uses WEIGHTED CPUEs to calculate biomass
    ## includes empty shells and debris
    dplyr::group_by(year, SRVY, scientific_name, common_name, species_code) %>%
    dplyr::mutate(biomass_mt = weighted_CPUE*(total_area*.1)) %>%
    # total biomass excluding empty shells and debris for each year
    dplyr::filter(common_name != 'empty shells and debris')  %>%
    dplyr::ungroup()
  
  cpue_biomass_total <- dplyr::bind_rows(
    cpue_biomass_total0, 
    cpue_biomass_total)
  
}


cpue_biomass_station <- 
  dplyr::left_join(
    x = cpue_biomass_station %>% 
      dplyr::select(-effort, -area, -net_width, -latitude, -longitude), 
    y = catch_haul_cruises %>% 
      dplyr::select(#cruisejoin, 
        hauljoin, stationid, stratum, 
        haul, start_time, start_latitude, start_longitude, 
        bottom_depth, gear_temperature, surface_temperature, 
        survey_name, SRVY, year, cruise, species_code, tax_conf), 
    by = c("SRVY", "year", "stationid", "hauljoin", "stratum", "species_code")) %>% 
  dplyr::select(-hauljoin, -distance_fished) %>% 
  dplyr::rename(station = "stationid", 
                weight_kg = "wt_kg_summed_by_station", 
                count = "num_summed_by_station", 
                # species_common = common_name,  #dream
                # species_scientific = scientific_name, #dream
                # "cpue_kgha", 
                # "cpue_noha", 
                date = "start_time", # where would I get time from? 
                latitude_dd = "start_latitude", 
                longitude_dd ="start_longitude", 
                surface_temperature_c = "surface_temperature",
                # "survey_name", 
                # "cruise", 
                depth_m = "bottom_depth", 
                bottom_temperature_c = "gear_temperature") %>% 
  dplyr::relocate(
    SRVY, survey_name, cruise, year, stratum, station, haul, # survey data
    datetime, latitude_dd, longitude_dd, # universal when/where
    species_code, tax_conf, common_name,  scientific_name,  # species info
    cpue_kgha, cpue_noha, weight, count, # catch data
    depth_m, bottom_temperature_c, surface_temperature_c) %>% #environmental data
  dplyr::arrange(SRVY, datetime)

# Save Public data output ------------------------------------------------------

dir_out <- paste0("/output/", sys.Date(),"/")
dir.create(dir_out)

files_to_save <- list("cpue_biomass_station" = cpue_biomass_station,
                      "cpue_biomass_stratum" = cpue_biomass_stratum, 
                      "cpue_biomass_total" = cpue_biomass_total)

save(files_to_save, paste0(dir_out,"/everything.rdata"))

for (i in 1:length(files_to_save)) {
  readr::write_csv2(
    x = files_to_save[i], 
    file = paste0(dir_out, names(files_to_save)[i], ".csv"), 
    col_names = TRUE)
}

# Check work -------------------------------------------------------------------

filename0<-paste0(cnt_chapt, "_")
rmarkdown::render(paste0(dir_code, "/check.Rmd"),
                  output_dir = dir_out,
                  output_file = paste0("check.pdf"))





