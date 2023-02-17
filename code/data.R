#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

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
  if (names(b)[1] %in% "rownames"){
    b$rownames<-NULL
  }
  assign(x = gsub(pattern = "\\.csv", replacement = "", x = paste0(a[i], "0")), value = b) # 0 at the end of the name indicates that it is the orig unmodified file
}

# Metadata prep ----------------------------------------------------------------

# column metadata
# metadata_column <- gap_products_metadata_column0

# table metadata
link_repo <- "https://github.com/afsc-gap-products/gap_public_data"

for (i in 1:nrow(gap_products_metadata_table0)){
  # print(paste0("metadata_sentence_", gap_products_metadata_table0$metadata_sentence_name[i]))
  assign(x = paste0("metadata_sentence_", gap_products_metadata_table0$metadata_sentence_name[i]), 
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

# Wrangle Data -----------------------------------------------------------------

## Taxon Confidence Data -------------------------------------------------------

taxon_confidence0 <- gap_products_old_taxon_confidence0 %>% 
  dplyr::rename(SRVY = srvy)

# > head(taxon_confidence0)
# # A tibble: 6 × 5
# species_code  year taxon_confidence SRVY  taxon_confidence_code
# <dbl> <dbl> <chr>            <chr>                 <dbl>
#   1          435  1997 Low              AI                        3
# 2          435  2000 High             AI                        1
# 3          435  2002 High             AI                        1


## Taxonomy and ITIS and WoRMS Data --------------------------------------------

# Make sure there are no duplicate species_codes
# > sum(duplicated(gap_products_old_v_taxonomics0$species_code))
# [1] 0

## cruises ---------------------------------------------------------------------
cruises <-  
  dplyr::left_join(
    y = surveys, # a data frame of all surveys and survey_definition_ids we want included in the public data, created in the run.R script
    x = race_data_v_cruises0, 
    by  = c("survey_definition_id")) %>% 
  dplyr::filter(survey_definition_id %in% surveys$survey_definition_id) %>% 
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
# > dim(cruises)
# [1] 156  13 # 2021
# [1] 167  13 # 2022

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
# # 139 result rows
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
# [1] id   Freq
# <0 rows> (or 0-length row.names)

haul <- racebase_haul0 %>%
  dplyr::filter(
    abundance_haul == "Y" & # defined historically as being good tows for abundance estimates
      haul_type == 3 & # standard non-retow or special proj tows
      performance >= 0 #&
      # !(year == 2018 & region == "BS" & stratum %in% c(70, 71, 81)) # remove 2018 NBS (actually called EBS in data!!!)
    # curious, but not removing, keeping in line with where abundance_haul = Y
    # !(is.null(stationid)) & 
    # !(is.na(stationid)) 
  ) %>% 
  dplyr::select(-auditjoin, -net_measured) # not valuable to us, here

# > dim(haul)
# [1] 34231    29 # 2021
# [1] 35096    29 # 2022

## catch -----------------------------------------------------------------------

# ## there should only be one species_code observation per haul event, however
# ## there are occasionally multiple (with unique catchjoins). 
# ## I suspect that this is because a species_code was updated or changed, 
# ## so we will need to sum those counts and weights
# 
# racebase_catch0 %>%
#     dplyr::filter(region != "WC") %>%
#   dplyr::mutate(id = paste0(region, "_", cruisejoin, "_", hauljoin, "_", species_code)) %>%
#   dplyr::select(id) %>%
#   table() %>%
#   data.frame() %>%
#   dplyr::filter(Freq > 1)
# id Freq
# 1 BS_104_3915_69010    2
# 2 BS_104_3916_69010    2
# 3 BS_104_3919_69010    2

catch <- racebase_catch0 %>% 
  dplyr::group_by(region, cruisejoin, hauljoin, vessel, haul, species_code) %>% 
  dplyr::summarise(weight = sum(weight, na.rm = TRUE), 
                   number_fish = sum(number_fish, na.rm = TRUE)) %>% 
  dplyr::ungroup()

# dim(catch)
# [1] 1613670       8 # 2021
# [1] 1641255       8 # 2022

## haul_cruises_vess ----------------------------------------------------------

haul_cruises_vess <- dplyr::inner_join(
  y = cruises %>% 
    dplyr::select(cruisejoin, vessel, region,  
                  survey_definition_id, SRVY, SRVY_long, survey_name, year, cruise),  
  x = haul %>% 
    dplyr::select(cruisejoin, vessel, region, haul_type, 
                  hauljoin, stationid, stratum, haul, start_time, 
                  start_latitude, start_longitude, end_latitude, end_longitude, 
                  bottom_depth, gear_temperature, surface_temperature, performance, 
                  duration, distance_fished, net_width, net_height) %>% 
    dplyr::filter(cruisejoin %in% cruises$cruisejoin), 
  by = c("cruisejoin", "vessel", "region")) %>% 
  dplyr::left_join(
    x = .,
    y = race_data_vessels0 %>%
      dplyr::select(vessel_id, name) %>%
      dplyr::rename(vessel_name = name) %>% 
      dplyr::mutate(vessel_name = stringr::str_to_title(vessel_name)), 
    by = c("vessel" = "vessel_id"))

# > dim(haul_cruises_vess)
# [1] 31608    28 # 2022

# Check 
# a <- unique(haul_cruises_vess[,c("SRVY", "year", "stationid", "haul_type")]); table(a$year, a$SRVY, a$haul_type)
#       AI BSS EBS GOA NBS # 2022
# 1982   0   0 334   0   0
# 1983   0   0 353   0   0
# 1984   0   0 355   0   0
# 1985   0   0 356   0   0
# 1986   0   0 354   0   0
# 1987   0   0 357   0   0
# 1988   0   0 372   0   0
# 1989   0   0 374   0   0
# 1990   0   0 371   0   0
# 1991 283   0 372   0   0
# 1992   0   0 356   0   0
# 1993   0   0 375 767   0
# 1994 339   0 375   0   0
# 1995   0   0 376   0   0
# 1996   0   0 375 795   0
# 1997 348   0 376   0   0
# 1998   0   0 375   0   0
# 1999   0   0 373 757   0
# 2000 358   0 372   0   0
# 2001   0   0 375 486   0
# 2002 354 141 375   0   0
# 2003   0   0 376 804   0
# 2004 375 230 375   0   0
# 2005   0   0 373 831   0
# 2006 335   0 376   0   0
# 2007   0   0 376 805   0
# 2008   0 200 375   0   0
# 2009   0   0 376 821   0
# 2010 384 200 376   0 141
# 2011   0   0 376 669   0
# 2012 386 189 376   0   0
# 2013   0   0 376 547   0
# 2014 381   0 376   0   0
# 2015   0   0 376 768   0
# 2016 383 175 376   0   0
# 2017   0   0 376 534 143
# 2018 390   0 376   0   0
# 2019   0   0 376 541 144
# 2021   0   0 376 529 144
# 2022 375   0 376   0 144

## catch_haul_cruises_vess -----------------------------------------------------

# Essentially our presence-only data
catch_haul_cruises_vess <- dplyr::left_join(
  y = haul_cruises_vess, 
  x = catch %>% 
    dplyr::select(hauljoin, #cruisejoin, region, vessel, haul, 
                  species_code, weight, number_fish) %>% 
    dplyr::filter(hauljoin %in% haul_cruises_vess$hauljoin), 
  by = c("hauljoin"))

# > dim(catch_haul_cruises_vess)
# [1] 905770     31 # 2022 data
