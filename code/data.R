#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Create Citation File ----------------------------------------------

bibfiletext <- readLines(con = "https://raw.githubusercontent.com/afsc-gap-products/citations/main/cite/bibliography.bib")
find_start <- grep(pattern = "FOSSAFSCData", x = bibfiletext, fixed = TRUE)
find_end <- which(bibfiletext == "}")
find_end <- find_end[find_end>find_start][1]
a <- bibfiletext[find_start:find_end]
readr::write_file(x = paste0(a, collapse = "\n"), file = "CITATION.bib")

link_foss <- a[grep(pattern = "howpublished = {", x = a, fixed = TRUE)]
link_foss <- gsub(pattern = "howpublished = {", replacement = "", x = link_foss, fixed = TRUE)
link_foss <- gsub(pattern = "},", replacement = "", x = link_foss, fixed = TRUE)
link_foss <- trimws(link_foss)

# Load Data --------------------------------------------------------------------

## Oracle Data -----------------------------------------------------------------
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

## Metadata ---------------------------------------------------------------------

metadata_column <- gap_products_metadata_column0

link_repo <- "https://github.com/afsc-gap-products/gap_public_data"

for (i in 1:nrow(gap_products_metadata_table0)){
  assign(x = paste0("metadata_sentence_", gap_products_metadata_table0$metadata_sentence_type[i]), 
         value = gap_products_metadata_table0$metadata_sentence[i])
}

metadata_sentence_github <- gsub(
  x = metadata_sentence_github, 
  pattern = "INSERT_REPO", 
  replacement = link_repo)

metadata_sentence_last_updated <- gsub(
  x = metadata_sentence_last_updated, 
  pattern = "INSERT_DATE", 
  replacement = format(x = as.Date(strsplit(x = dir_out, split = "/", fixed = TRUE)[[1]][length(strsplit(x = dir_out, split = "/", fixed = TRUE)[[1]])]), "%B %d, %Y") )

## ITIS, WoRMS, and Taxon Confidence Data --------------------------------------

# Now available on the RACEBASE_FOSS oracle schema

load(file = paste0("./data/AFSC_ITIS_WORMS",option,".rdata"))
# read.csv(file = "./data/oracle/gap_products_old_taxon_confidence.csv")
taxon_confidence0 <- gap_products_old_taxon_confidence0 %>% 
  dplyr::rename(SRVY = srvy)

# Wrangle Data -----------------------------------------------------------------

## Species info ----------------------------------------------------------------

# if (FALSE) { # if itis/worms codes have not been run yet
#   AFSC_ITIS_WORMS <-
#     # dplyr::left_join(
#       # x =
#     species0 %>%
#         dplyr::select(species_code, common_name, species_name) %>% # ,
#       # y = species_taxonomics0 %>%
#         # dplyr::select(),
#       # by = c("")) %>%
#     dplyr::rename(scientific_name = species_name) %>%
#     dplyr::mutate( # fix rouge spaces in species names
#       common_name = ifelse(is.na(common_name), "", common_name),
#       common_name = gsub(pattern = "  ", replacement = " ",
#                          x = trimws(common_name), fixed = TRUE),
#       scientific_name = ifelse(is.na(scientific_name), "", scientific_name),
#       scientific_name = gsub(pattern = "  ", replacement = " ",
#                              x = trimws(scientific_name), fixed = TRUE), 
#       itis = NA, 
#       worms = NA) # made if taxize0 == TRUE
# } else {
# AFSC_ITIS_WORMS <- AFSC_ITIS_WORMS %>% 
#   dplyr::select(-notes_itis, -notes_worms) %>% 
#   dplyr::mutate(itis = as.numeric(itis), 
#                 worms = as.numeric(worms))
# }


## cruises ---------------------------------------------------------------------
cruises <-  
  dplyr::left_join(
    x = surveys, # a data frame of all surveys and survey_definition_ids we want included in the public data, created in the run.R script
    y = race_data_v_cruises0, 
    by  = c("survey_definition_id")) %>% 
  dplyr::select(SRVY, SRVY_long, region, cruise_id,  year, survey_name, 
                vessel_id, cruise, survey_definition_id, 
                vessel_name, start_date, end_date, cruisejoin) %>% 
  dplyr::filter(year != 2020 & # no surveys happened this year because of COVID
                  (year >= 1982 & SRVY %in% c("EBS", "NBS") | # 1982 BS inclusive - much more standardized after this year
                     SRVY %in% "BSS" | # keep all years of the BSS
                     year >= 1991 & SRVY %in% c("AI", "GOA")) & # 1991 AI and GOA (1993) inclusive - much more standardized after this year
                  survey_definition_id %in% surveys$survey_definition_id) %>% 
  dplyr::rename(vessel = "vessel_id")

# # Looking for 0s in years we dont want data to make sure the years we want removed are gone 
# table(cruises[,c("SRVY", "year")]) # 2021
# # year
# # SRVY  1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 ...
# # AI     0    0    0    0    0    0    0    0    0    2    0    0    2   ... 
# # EBS    2    3    2    2    2    2    2    2    2    2    2    2    2   ...
# # GOA    0    0    0    0    0    0    0    0    0    0    0    4    0   ...
# # NBS    0    0    0    0    0    0    0    0    0    0    0    0    0   ...
# 
# dim(cruises)
# # > dim(cruises)
# # [1] 156  13

## haul ------------------------------------------------------------------------

# If you group the data by with `srvy`, `cruise`, `stratum`, `station`, and `vessel_id` (NOT `hauljoin` or `haul`, as done below) you find that there were several stratum-stations appear to be sampled right after the initial haul. This is because the stations in the GOA/AI surveys were regridded. These stations are in fact legit and will be kept in the data. 
# 
# # don't include haul/hauljoin
# racebase_haul0 %>% 
#   dplyr::filter(abundance_haul == "Y" & 
#                   haul_type == 3 & 
#                   performance >= 0) %>% 
#   dplyr::mutate(id = paste0(region,"_",cruise,"_",stratum,"_",stationid,"_",vessel)) %>%
#   dplyr::select(id) %>%
#   table() %>% 
#   data.frame() %>% 
#   dplyr::filter(Freq > 1) 
# 
# # include haul/hauljoin
# racebase_haul0 %>% 
#   dplyr::filter(abundance_haul == "Y" & 
#                   haul_type == 3 & 
#                   performance >= 0) %>% 
#   dplyr::mutate(id = paste0(region,"_",cruise,"_",stratum,"_",stationid,"_",vessel,"_",haul)) %>%
#   dplyr::select(id) %>%
#   table() %>% 
#   data.frame() %>% 
#   dplyr::filter(Freq > 1) 

haul <- racebase_haul0 %>%
  dplyr::filter(
    abundance_haul == "Y" & # defined historically as being good tows for abundance estimates
      haul_type == 3 & # standard non-retow or special proj tows
      performance >= 0 
    # curious, but not removing, keeping in line with where abundance_haul = Y
    # !(is.null(stationid)) & 
    # !(is.na(stationid)) 
  ) %>% 
  dplyr::select(-auditjoin, -net_measured) # not valuable to us, here

# > dim(haul) # 2021
# [1] 34231    29

## catch -----------------------------------------------------------------------

# ## there should only be one species_code observation per haul event, however
# ## there are occassionally multiple (with unique catchjoins). 
# ## I suspect that this is because a species_code was updated or changed, 
# ## so we will need to sum those counts and weights
# 
# racebase_catch0 %>%
#     dplyr::filter(region != "WC") %>% 
#   dplyr::mutate(id = paste0(region, "_", cruisejoin, "_", hauljoin, "_", species_code)) %>%
#   dplyr::select(id) %>%
#   table() %>%
#   data.frame() %>%
#   dplyr::rename("id" = ".") %>%
#   dplyr::filter(Freq > 1)

catch <- racebase_catch0 %>% 
  dplyr::group_by(region, cruisejoin, hauljoin, vessel, haul, species_code) %>% 
  dplyr::summarise(weight = sum(weight, na.rm = TRUE), 
                   number_fish = sum(number_fish, na.rm = TRUE)) %>% 
  dplyr::ungroup()

# dim(catch) # 2021
# [1] 1613670       8

## haul_cruises_vess ----------------------------------------------------------

haul_cruises_vess <- dplyr::inner_join(
  x = cruises %>% 
    dplyr::select(cruisejoin, vessel, region,  
                  survey_definition_id, SRVY, SRVY_long, survey_name, year, cruise),  
  y = haul %>% 
    dplyr::select(cruisejoin, vessel, region, haul_type, 
                  hauljoin, stationid, stratum, haul, start_time, 
                  start_latitude, start_longitude, end_latitude, end_longitude, 
                  bottom_depth, gear_temperature, surface_temperature, performance, 
                  duration, distance_fished, net_width, net_height), 
  by = c("cruisejoin", "vessel", "region")) %>% 
  dplyr::left_join(
    x = .,
    y = race_data_vessels0 %>%
      dplyr::select(vessel_id, name) %>%
      dplyr::rename(vessel_name = name) %>% 
      dplyr::mutate(vessel_name = stringr::str_to_title(vessel_name)), 
    by = c("vessel" = "vessel_id"))

# Check 
# a <- unique(haul_cruises_vess[,c("SRVY", "year", "stationid", "haul_type")]); table(a$year, a$SRVY, a$haul_type)

## catch_haul_cruises_vess -----------------------------------------------------

# Essentially our presence-only data
catch_haul_cruises_vess <- dplyr::left_join(
  x = haul_cruises_vess, 
  y = catch %>% 
    dplyr::select(hauljoin, #cruisejoin, region, vessel, haul, 
                  species_code, weight, number_fish), 
  by = c("hauljoin"))
