#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

## Taxonomic confidence data ---------------------------------------------------

  df.ls <- list()
  a <- list.files(path = here::here("data", "taxon_confidence"))
  a <- a[a != "taxon_confidence.csv"]
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
      dplyr::mutate(year = gsub(pattern = "[a-z]", 
                                      replacement = "", 
                                      x = year), 
                    year = gsub(pattern = "_0", replacement = "", 
                                x = year), 
                    year = as.numeric(year)) %>% 
      dplyr::distinct()
    
    cc <- strsplit(x = gsub(x = gsub(x = a[i], 
                                     pattern = "Taxon_confidence_", replacement = ""), 
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
  
  tax_conf <- dplyr::bind_rows(df.ls) %>% 
    dplyr::mutate(tax_conf0 = tax_conf, 
                  tax_conf = dplyr::case_when(
                    tax_conf == 1 ~ "High",
                    tax_conf == 2 ~ "Moderate",
                    tax_conf == 3 ~ "Low", 
                    TRUE ~ "Unassessed"))
  
  readr::write_csv(x = tax_conf, 
                   file = paste0(getwd(), "/data/taxon_confidence.csv"))
  
  save(tax_conf, file = paste0(getwd(), "/data/taxon_confidence.rdata"))
  
