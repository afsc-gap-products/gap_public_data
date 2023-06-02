## Install package -------------------------------------------------------------

PKG <- c(
  "gapindex", # library(devtools); devtools::install_github("afsc-gap-products/gapindex")
  "dplyr",
  "magrittr",
  "readr",
  "rmarkdown",
  "here", 
  "stringr")

PKG <- unique(PKG)
for (p in PKG) {
  if(!require(p,character.only = TRUE)) {
    install.packages(p)
    require(p,character.only = TRUE)}
}

## Create Citation File --------------------------------------------------------

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

link_repo <- "https://github.com/afsc-gap-products/gap_public_data/"

## Set output directory --------------------------------------------------------

dir_out <- paste0(here::here("output", Sys.Date()), "/")
dir.create(dir_out)

## Connect to Oracle -----------------------------------------------------------
# sql_channel <- gapindex::get_connected()
# obtain the channel_foss object
locations <- c("Z:/Projects/ConnectToOracle.R", 
               "C:/Users/emily.markowitz/Documents/Projects/ConnectToOracle.R")
for (i in 1:length(locations)){
  if (file.exists(locations[i])) {source(locations[i])}
}

## Additional Oracle Data -----------------------------------------------------------------

surveys <- 
  data.frame(SURVEY_DEFINITION_ID = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSS"),
             SURVEY = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope") )

a <- c("gap_products_metadata_table", 
       "gap_products_metadata_column", 
       "gap_products_old_taxonomics_worms",
       "race_data_vessels",
       "gap_products_old_v_taxonomics", 
       "gap_products_old_taxon_confidence")

for (i in 1:length(a)){
  print(a[i])
  b <- readr::read_csv(file = paste0(here::here("data", "oracle", a[i]), ".csv"))
  if (names(b)[1] %in% "...1"){
    b$...1<-NULL
  }
  if (names(b)[1] %in% "rownames"){
    b$rownames<-NULL
  }
  assign(x = gsub(pattern = "\\.csv", replacement = "", x = paste0(a[i], "0")), value = b) # 0 at the end of the name indicates that it is the orig unmodified file
}

## Pull data and calculate CPUE using {gapindex} -------------------------------
# See ?gapindex::get_data first for more details
maxyr <- (substr(x = Sys.Date(), start = 1, stop = 4))
surveys0 <- c("GOA", "AI", "EBS", "NBS", "EBS_SLOPE")
data_cpue0 <- data_haul0 <- data.frame()

for (i in 1:length(surveys0)) {
  
  print(surveys0[i])
  
  # Gather data for survey
  data <- gapindex::get_data( 
    year_set = c(1982:maxyr),
    survey_set = surveys0[i], 
    spp_codes = unique(gap_products_old_taxonomics_worms0$species_code), 
    haul_type = 3,
    abundance_haul = "Y",
    sql_channel = channel_foss)
  
  ## Fill in zeros and calculate CPUE
  data_cpue0 <- dplyr::bind_rows(
    data_cpue0, 
    gapindex::calc_cpue(racebase_tables = data))
  ## Collect haul data
  data_haul0 <- dplyr::bind_rows(data_haul0, data$haul)
}

JOIN_FOSS_CPUE_CATCH_gi <- data_cpue0 %>% 
  dplyr::select(SRVY = SURVEY, YEAR, HAULJOIN, 
                SURVEY_DEFINITION_ID, SPECIES_CODE, WEIGHT_KG, 
                COUNT, AREA_SWEPT_KM2, CPUE_KGKM2, CPUE_NOKM2) %>% 
  dplyr::mutate(dplyr::across(dplyr::starts_with("CPUE_"), round, digits = 6), 
                WEIGHT_KG = round(WEIGHT_KG, digits = 6) , 
                COUNT = round(COUNT, digits = 0) ) %>%
  dplyr::filter(YEAR != 2020 & # no surveys happened this year because of COVID
                  (YEAR >= 1982 & SRVY %in% c("EBS", "NBS") | # 1982 BS inclusive - much more standardized after this year
                     SRVY %in% "BSS" | # keep all years of the BSS
                     YEAR >= 1991 & SRVY %in% c("AI", "GOA")) ) %>% # 1991 AI and GOA (1993) inclusive - much more standardized after this year

  dplyr::left_join( # Add worms + species info
    x = .,
    y = gap_products_old_v_taxonomics0, 
    by = "SPECIES_CODE") %>%
  dplyr::left_join( # Add species info
    x = .,
    y = gap_products_old_taxon_confidence0 %>% 
      dplyr::mutate(TAXON_CONFIDENCE = ifelse(is.na(TAXON_CONFIDENCE), "Unassessed", TAXON_CONFIDENCE)) %>% 
      dplyr::select(YEAR, TAXON_CONFIDENCE, SRVY, SPECIES_CODE), 
    by = c("YEAR", "SRVY", "SPECIES_CODE")) %>% 
  dplyr::arrange(SRVY, CPUE_KGKM2) %>% 
  dplyr::distinct()

# Create paired HAUL table -----------------------------------------------------

JOIN_FOSS_CPUE_HAUL_gi <- data_haul0 %>%
  dplyr::select(HAULJOIN, 
                VESSEL_ID = VESSEL, 
                HAUL, 
                PERFORMANCE, 
                DATE_TIME = START_TIME, 
                DURATION_HR = DURATION, 
                DISTANCE_FISHED_KM = DISTANCE_FISHED, 
                NET_WIDTH_M = NET_WIDTH, 
                NET_HEIGHT_M = NET_HEIGHT, 
                STRATUM, 
                LATITUDE_DD_START = START_LATITUDE, 
                LATITUDE_DD_END = END_LATITUDE, 
                LONGITUDE_DD_START = START_LONGITUDE, 
                LONGITUDE_DD_END = END_LONGITUDE, 
                STATION = STATIONID, 
                DEPTH_M = BOTTOM_DEPTH, 
                SURFACE_TEMPERATURE_C = SURFACE_TEMPERATURE, 
                BOTTOM_TEMPERATURE_C = GEAR_TEMPERATURE) %>% 
  dplyr::filter(HAULJOIN %in% unique(JOIN_FOSS_CPUE_CATCH_gi$HAULJOIN)) %>% # make sure the haul data is limited to the enteries in the cpue data
  dplyr::left_join(
    x = ., 
    y = JOIN_FOSS_CPUE_CATCH_gi %>% 
      dplyr::select(HAULJOIN, YEAR, SURVEY_DEFINITION_ID, AREA_SWEPT_KM2), 
    by = "HAULJOIN") %>% 
  dplyr::left_join(
    x = ., 
    y = surveys, 
    by = "SURVEY_DEFINITION_ID") %>% 
  dplyr::mutate(
    DATE_TIME = base::as.POSIXlt(x = DATE_TIME, 
                                 format = "%m/%d/%Y %H:%M:%OS", 
                                 tz = "America/Nome")) %>%
  dplyr::left_join( # Add worms + species info
    x = .,
    y = race_data_vessels0 %>% 
      dplyr::select(VESSEL_ID, VESSEL_NAME = NAME) %>% 
      dplyr::mutate(VESSEL_NAME = paste0("F/V ", stringr::str_to_sentence(VESSEL_NAME))), 
    by = "VESSEL_ID") %>% 
    dplyr::arrange(DATE_TIME) %>% 
  dplyr::distinct()

JOIN_FOSS_CPUE_CATCH_gi <- JOIN_FOSS_CPUE_CATCH_gi %>% 
  dplyr::select(-YEAR, -SRVY, -SURVEY_DEFINITION_ID, -AREA_SWEPT_KM2)

# setdiff(y = names(JOIN_FOSS_CPUE_HAUL_gi), x = c("HAULJOIN", # Join these
#     "CRUISEJOIN", "YEAR", "SRVY", "SURVEY", "SURVEY_DEFINITION_ID", "CRUISE", 
#     "HAUL", "VESSEL_NAME", "VESSEL_ID", "STATION", "STRATUM", "DATE_TIME", 
#     "BOTTOM_TEMPERATURE_C", "SURFACE_TEMPERATURE_C",
#     "DEPTH_M", "LATITUDE_DD_START", "LATITUDE_DD_END", "LONGITUDE_DD_START", "LONGITUDE_DD_END", 
#     "NET_HEIGHT_M", "NET_WIDTH_M", "DISTANCE_FISHED_KM", "DURATION_HR", "AREA_SWEPT_KM2", "PERFORMANCE"))
# 
# 
# setdiff(x = names(JOIN_FOSS_CPUE_CATCH_gi), y = c("HAULJOIN", "SPECIES_CODE", 
#                 "CPUE_KGKM2", "CPUE_NOKM2", "COUNT", "WEIGHT_KG",
#                 "TAXON_CONFIDENCE", 
#                 "SCIENTIFIC_NAME", "COMMON_NAME", "WORMS", "ITIS"))

## Metadata prep ----------------------------------------------------------------

# table metadata

for (i in 1:nrow(gap_products_metadata_table0)){
  # print(paste0("metadata_sentence_", gap_products_metadata_table0$metadata_sentence_name[i]))
  assign(x = paste0("metadata_sentence_", gap_products_metadata_table0$METADATA_SENTENCE_NAME[i]), 
         value = gap_products_metadata_table0$METADATA_SENTENCE[i])
}

metadata_sentence_github <- gsub(
  x = metadata_sentence_github, 
  pattern = "INSERT_REPO", 
  replacement = link_repo)

metadata_sentence_last_updated <- gsub(
  x = metadata_sentence_last_updated, 
  pattern = "INSERT_DATE", 
  replacement = format(x = as.Date(strsplit(x = dir_out, split = "/", fixed = TRUE)[[1]][length(strsplit(x = dir_out, split = "/", fixed = TRUE)[[1]])]), "%B %d, %Y") )

# Save output ------------------------------------------------------------------

## Metadata maintenance --------------------------------------------------------
metadata_column <- gap_products_metadata_column0[match(c(names(JOIN_FOSS_CPUE_HAUL_gi), names(JOIN_FOSS_CPUE_CATCH_gi)), 
                                                       (gap_products_metadata_column0$METADATA_COLNAME)),]  

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
  "These datasets, JOIN_FOSS_CPUE_CATCH_gi and JOIN_FOSS_CPUE_HAUL_gi, 
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
  JOIN_FOSS_CPUE_HAUL_gi, 
  JOIN_FOSS_CPUE_CATCH_gi, 
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
  name0 = "FOSS_CPUE_ZEROFILLED_gi", 
  dir_out = dir_out)

FOSS_CPUE_ZEROFILLED_gi <- dplyr::full_join(JOIN_FOSS_CPUE_CATCH_gi, JOIN_FOSS_CPUE_HAUL_gi, by = "HAULJOIN")

base::save(
  FOSS_CPUE_ZEROFILLED_gi, 
  metadata_column, 
  metadata_table, 
  file = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_gi.RData"))

## Pres-only data --------------------------------------------------------------

FOSS_CPUE_PRESONLY_gi <- FOSS_CPUE_ZEROFILLED_gi %>%
  dplyr::filter(
    !(COUNT %in% c(NA, 0) & # this will remove 0-filled values
        WEIGHT_KG %in% c(NA, 0)) | 
      !(CPUE_KGKM2 %in% c(NA, 0) & # this will remove usless 0-cpue values, 
          CPUE_NOKM2 %in% c(NA, 0)) ) # which shouldn't happen, but good to double check

metadata_table <- gsub(pattern = "zero-filled (presence and absence)", 
                       replacement = "presence-only",
                       x = paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_gi_metadata_table.txt")), collapse="\n"))
metadata_table <- fix_metadata_table(
  metadata_table0 = metadata_table, 
  name0 = "FOSS_CPUE_PRESONLY_gi", 
  dir_out = dir_out)

base::save(
  FOSS_CPUE_PRESONLY_gi, 
  metadata_column, 
  metadata_table, 
  file = paste0(dir_out, "FOSS_CPUE_PRESONLY_gi.RData"))

## Save CSV's ------------------------------------------------------------------

list_to_save <- c(
  "JOIN_FOSS_CPUE_CATCH_gi", 
  "JOIN_FOSS_CPUE_HAUL_gi",
  "FOSS_CPUE_PRESONLY_gi", 
  "FOSS_CPUE_ZEROFILLED_gi")

for (i in 1:length(list_to_save)) {
  readr::write_csv(
    x = get(list_to_save[i]), 
    file = paste0(dir_out, list_to_save[i], ".csv"), 
    col_names = TRUE)
}

## Make Taxonomic grouping searching table -----------------------------------------------
names(gap_products_old_taxonomics_worms0) <- tolower(names(gap_products_old_taxonomics_worms0))
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
                                                       toupper(gap_products_metadata_column0$METADATA_COLNAME)),]  
metadata_column$metadata_colname <- toupper(metadata_column$METADATA_COLNAME)

base::save(
  TAXON_GROUPS, 
  metadata_column,
  metadata_table, 
  file = paste0(dir_out, "TAXON_GROUPS.RData"))

readr::write_csv(
  x = TAXON_GROUPS, 
  file = paste0(dir_out, "TAXON_GROUPS.csv"), 
  col_names = TRUE)

## Check output ----------------------------------------------------------------

FOSS_CPUE_PRESONLY <- FOSS_CPUE_PRESONLY_gi
JOIN_FOSS_CPUE_HAUL <- JOIN_FOSS_CPUE_HAUL_gi
JOIN_FOSS_CPUE_CATCH <- JOIN_FOSS_CPUE_CATCH_gi %>% 
  dplyr::left_join(y = JOIN_FOSS_CPUE_HAUL_gi %>% 
                     dplyr::select(HAULJOIN, SRVY, YEAR), 
                   by = "HAULJOIN") %>% 
  dplyr::mutate(CRUISE = YEAR)
FOSS_CPUE_ZEROFILLED <- FOSS_CPUE_ZEROFILLED_gi %>% 
  dplyr::mutate(CRUISE = YEAR)

rmarkdown::render(input = here::here("code", "calc_cpue_check.rmd"),
                  output_dir = dir_out, 
                  output_format = 'pdf_document', 
                  output_file = "calc_cpue_check_gi.pdf")

## Save to Oracle --------------------------------------------------------------

file_paths <- data.frame(
  file_path = 
    paste0(dir_out,
           c("TAXON_GROUPS", 
             "FOSS_CPUE_PRESONLY_gi",
             "JOIN_FOSS_CPUE_HAUL_gi",
             "JOIN_FOSS_CPUE_CATCH_gi",
             "FOSS_CPUE_ZEROFILLED_gi"
           ),
           ".csv"), 
  "metadata_table" = c(
    paste(readLines(con = paste0(dir_out, "TAXON_GROUPS_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_PRESONLY_gi_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "JOIN_FOSS_CPUE_metadata_table.txt")), collapse="\n"),
    paste(readLines(con = paste0(dir_out, "FOSS_CPUE_ZEROFILLED_gi_metadata_table.txt")), collapse="\n")
  ) 
)

metadata_column <- readr::read_csv(paste0(dir_data, "/oracle/gap_products_metadata_column.csv")) 

for (i in 1:nrow(file_paths)){
  oracle_upload(
    # update_metadata = FALSE, 
    # update_table = FALSE,
    file_path = file_paths$file_path[i], 
    metadata_table = file_paths$metadata_table[i], 
    metadata_column = metadata_column, 
    channel = channel_foss, 
    schema = "RACEBASE_FOSS")
}


