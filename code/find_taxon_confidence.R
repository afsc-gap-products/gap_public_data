#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

## Taxonomic confidence data ---------------------------------------------------

  df.ls <- list()
  a <- list.files(path = here::here("data", "TAXON_CONFIDENCE"))
  a <- a[a != "TAXON_CONFIDENCE.csv"]
  for (i in 1:length(a)){
    print(a[i])
    b <- readxl::read_xlsx(path = paste0(here::here("data", "TAXON_CONFIDENCE", a[i])), 
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
                          values_to = "TAXON_CONFIDENCE") %>% 
      dplyr::mutate(year = gsub(pattern = "[a-z]", 
                                      replacement = "", 
                                      x = year), 
                    year = gsub(pattern = "_0", replacement = "", 
                                x = year), 
                    year = as.numeric(year)) %>% 
      dplyr::distinct()
    
    cc <- strsplit(x = gsub(x = gsub(x = a[i], 
                                     pattern = "TAXON_CONFIDENCE_", replacement = ""), 
                            pattern = ".xlsx", 
                            replacement = ""), 
                   split = "_")[[1]]
    
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
  
  # Quality Codes
  # 1 – High confidence and consistency.  Taxonomy is stable and reliable at this 
  #     level, and field identification characteristics are well known and reliable.
  # 2 – Moderate confidence.  Taxonomy may be questionable at this level, or field  
  #     identification characteristics may be variable and difficult to assess consistently.
  # 3 – Low confidence.  Taxonomy is incompletely known, or reliable field  
  #     identification characteristics are unknown.
  
  TAXON_CONFIDENCE <- dplyr::bind_rows(df.ls) %>% 
    dplyr::mutate(TAXON_CONFIDENCE0 = TAXON_CONFIDENCE, 
                  TAXON_CONFIDENCE = dplyr::case_when(
                    TAXON_CONFIDENCE == 1 ~ "High",
                    TAXON_CONFIDENCE == 2 ~ "Moderate",
                    TAXON_CONFIDENCE == 3 ~ "Low", 
                    TRUE ~ "Unassessed"))
  
  # fill in TAXON_CONFIDENCE with, if missing, the values from the year before
  
  cruises <- read.csv("./data/oracle/v_cruises.csv") %>% 
    janitor::clean_names() %>% 
    dplyr::left_join(
      x = surveys, # a data frame of all surveys and survey_definition_ids we want included in the public data, created in the run.R script
      y = ., 
      by  = c("survey_definition_id"))
  comb1 <- unique(cruises[, c("SRVY", "year")] )
  comb2 <- unique(TAXON_CONFIDENCE[, c("SRVY", "year")])
  # names(comb2) <- names(comb1) <- c("SRVY", "year")
  comb1$comb <- paste0(comb1$SRVY, "_", comb1$year)
  comb2$comb <- paste0(comb2$SRVY, "_", comb2$year)
  comb <- strsplit(x = setdiff(comb1$comb, comb2$comb), split = "_")
  
  TAXON_CONFIDENCE <- dplyr::bind_rows(
    TAXON_CONFIDENCE, 
    TAXON_CONFIDENCE %>% 
      dplyr::filter(
        SRVY %in% sapply(comb,"[[",1) &
          year == 2021) %>% 
      dplyr::mutate(year = 2022)) %>% 
    dplyr::rename(taxon_confidence = TAXON_CONFIDENCE, 
                  taxon_confidence0 = TAXON_CONFIDENCE0)
  
  readr::write_csv(x = TAXON_CONFIDENCE, 
                   file = paste0(getwd(), "/data/TAXON_CONFIDENCE.csv"))
  
  table_metadata <- paste0(
    "The quality and specificity of field identifications for many taxa have 
    fluctuated over the history of the surveys due to changing priorities and resources. 
    The matrix lists a confidence level for each taxon for each survey year 
    and is intended to serve as a general guideline for data users interested in 
    assessing the relative reliability of historical species identifications 
    on these surveys. This dataset includes an identification confidence matrix 
    for all fishes and invertebrates identified ", 
         metadata_sentence_survey_institution, 
         metadata_sentence_legal_restrict,  
         metadata_sentence_github, 
         metadata_sentence_codebook, 
         metadata_sentence_last_updated)
  
  readr::write_lines(x = gsub(pattern = "\n", replacement = "", x = table_metadata), 
                     file = paste0(getwd(), "/data/", "TAXON_CONFIDENCE_table_metadata.txt"))
  
  column_metadata <- column_metadata[which(column_metadata$colname %in% names(a)),]
  
  save(TAXON_CONFIDENCE, 
       table_metadata, 
       column_metadata, 
       file = paste0(getwd(), "/data/TAXON_CONFIDENCE.rdata"))
  
