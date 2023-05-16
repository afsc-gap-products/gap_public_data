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
    y = gap_products_old_v_taxonomics0, 
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

## Wrangle data ----------------------------------------------------------------

# Lookup vector to only rename/select if that column is present:
lookup <- c(station = "stationid", 
            weight_kg = "weight", 
            count = "number_fish", 
            srvy = "SRVY",
            survey = "survey_name",
            # survey_id = "survey_definition_id", 
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
    area_swept_km2 = distance_fished_km * (net_width_m/1000), # both in units of km
    cpue_kgkm2 = weight_kg/area_swept_km2, 
    cpue_nokm2 = ifelse(weight_kg > 0 & count == 0, 
                       NA, (count/area_swept_km2)), 
    cpue_kgkm2 = ifelse(is.na(cpue_kgkm2), 0, cpue_kgkm2),
    cpue_nokm2 = ifelse(is.na(cpue_nokm2), 0, cpue_nokm2),
    date_time = base::as.POSIXlt(x = date_time, 
                                 format = "%m/%d/%Y %H:%M:%OS", 
                                 tz = "America/Nome"), 
    dplyr::across(dplyr::starts_with("cpue_"), round, digits = 6), 
    weight_kg = round(weight_kg, digits = 6)) %>% 
  dplyr::select(any_of(
    c(as.character(expression(
      year, srvy, survey, survey_definition_id, cruise, haul, hauljoin, stratum, station, vessel_name, vessel_id, # survey data
      date_time, latitude_dd, longitude_dd, latitude_dd_start, longitude_dd_start, latitude_dd_end, longitude_dd_end, # when/where
      species_code, itis, worms, common_name, scientific_name, taxon_confidence, # species info
      cpue_kgkm2, # cpue weight
      cpue_nokm2, # cpue num
      weight_kg, count, # summed catch data
      bottom_temperature_c, surface_temperature_c, depth_m, #environmental data
      distance_fished_km, net_width_m, net_height_m, area_swept_km2, duration_hr, performance # gear data
    ))))) %>% 
  dplyr::arrange(date_time, srvy, cpue_kgkm2) 

names(FOSS_CPUE_ZEROFILLED) <- toupper(names(FOSS_CPUE_ZEROFILLED))

# Split up data to make smaller join files -------------------------------------

print("Split up data to make smaller join files")

JOIN_FOSS_CPUE_HAUL <- FOSS_CPUE_ZEROFILLED %>%
  dplyr::select(
    HAULJOIN, # Join these
    YEAR, SRVY, SURVEY, SURVEY_DEFINITION_ID, CRUISE, 
    HAUL, VESSEL_NAME, VESSEL_ID, STATION, STRATUM, DATE_TIME, 
    BOTTOM_TEMPERATURE_C, SURFACE_TEMPERATURE_C,
    DEPTH_M, LATITUDE_DD_START, LATITUDE_DD_END, LONGITUDE_DD_START, LONGITUDE_DD_END, 
    NET_HEIGHT_M, NET_WIDTH_M, DISTANCE_FISHED_KM, DURATION_HR, AREA_SWEPT_KM2, PERFORMANCE) %>% 
  dplyr::distinct()

JOIN_FOSS_CPUE_CATCH <- FOSS_CPUE_ZEROFILLED %>% 
  dplyr::select(HAULJOIN, # join these
                SPECIES_CODE, 
                CPUE_KGKM2, CPUE_NOKM2, COUNT, WEIGHT_KG,
                TAXON_CONFIDENCE, 
                SCIENTIFIC_NAME, COMMON_NAME, WORMS, ITIS) %>% 
  dplyr::distinct()

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
  metadata_sentence_legal_restrict_none, 
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
  metadata_sentence_legal_restrict_none, 
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
      !(CPUE_KGKM2 %in% c(NA, 0) & # this will remove usless 0-cpue values, 
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

## Make Taxonomic grouping searching table -----------------------------------------------

TAXON_GROUPS <- gap_products_old_taxonomics_worms0 %>% 
  dplyr::select(species_code, genus, family, order, class, phylum, kingdom) %>% 
  tidyr::pivot_longer(data = ., 
                      cols = c("genus", "family", "order", "class", "phylum", "kingdom"), 
                      names_to = "id_rank", values_to = "classification") %>% 
  dplyr::relocate(id_rank, classification, species_code) %>% 
  dplyr::arrange(id_rank, classification, species_code) %>% 
  dplyr::filter(!is.na(classification))

# only keep groups that have more than one member
TAXON_GROUPS <- TAXON_GROUPS[duplicated(x = TAXON_GROUPS$id_rank),]

metadata_table <- paste(
  "This dataset contains suggested search groups for simplifying species selection in the FOSS data platform. This was developed ", 
  metadata_sentence_survey_institution,
  metadata_sentence_legal_restrict_none, 
  metadata_sentence_foss, 
  metadata_sentence_github, 
  metadata_sentence_codebook, 
  metadata_sentence_last_updated, 
  collapse = " ", sep = " ")
metadata_table <- fix_metadata_table(
  metadata_table0 = metadata_table, 
  name0 = "TAXON_GROUPS", 
  dir_out = dir_out)

metadata_column <- gap_products_metadata_column0[match(names(TAXON_GROUPS), 
                                                       toupper(gap_products_metadata_column0$metadata_colname)),]  
metadata_column$metadata_colname <- toupper(metadata_column$metadata_colname)

base::save(
  TAXON_GROUPS, 
  metadata_column,
  metadata_table, 
  file = paste0(dir_out, "TAXON_GROUPS.RData"))

readr::write_csv(
  x = TAXON_GROUPS, 
  file = paste0(dir_out, "TAXON_GROUPS.csv"), 
  col_names = TRUE)

