#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Functions --------------------------------------------------------------------

library(taxize)


find_itis <- function(sci, common, known) {
  
  spp_info_new <- data.frame(scientific_name = sci, 
                             common_name = common, 
                             tsn = NA)
  
  for (i in 1:nrow(spp_info_new)){
    # if already known
    if (sci[i] %in% names(lapply(X = known,"[", 1))) {
      spp_info_new$tsn[i] <- lapply(X = known,"[", 1)[names(lapply(X = known,"[", 1)) %in% sci[i]][[1]]
    } else { # if we don't already know
      tsn_indata <- taxize::classification(sci_id = sci[i], db = "itis")
      a <- lapply(X = tsn_indata,"[", 3)[[1]]
      
      if (!is.na(a)) {
        spp_info_new$tsn[i] <- a$id[nrow(a)]
      }
      
      if (is.na(a) & common[i] != "") {
        tsn_indata <- taxize::classification(
          sci_id = taxize::comm2sci(common[i], db = "itis"), 
          db = "itis")
        a <- lapply(X = tsn_indata,"[", 3)[[1]]
        if (is.na(a)) {
          spp_info_new$tsn[i] <- NA
        } else {
          spp_info_new$tsn[i] <- a$id[nrow(a)]
        }
      }
    }
  }
  return(spp_info_new)
  
}

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

# Wrangle ----------------------------------------------------------------------

spp_info <- 
  # dplyr::left_join(
  # x = 
  species0 %>% 
  dplyr::select(species_code, common_name, species_name) %>% # ,
  # y = species_taxonomics0 %>% 
  # dplyr::select(), 
  # by = c("")) %>% 
  dplyr::rename(scientific_name = species_name) %>%
  dplyr::mutate( # fix rouge spaces in species names
    common_name = ifelse(is.na(common_name), "", common_name), 
    common_name = gsub(pattern = "  ", replacement = " ", 
                       x = trimws(common_name), fixed = TRUE), 
    scientific_name = ifelse(is.na(scientific_name), "", scientific_name), 
    scientific_name = gsub(pattern = "  ", replacement = " ", 
                           x = trimws(scientific_name), fixed = TRUE))

spp_info$scientific_name1 <- spp_info$scientific_name
remove0 <- c(" sp.", " .spp")
for (i in 1:length(remove0)) {
  spp_info$scientific_name1<-gsub(pattern = remove0[i], replacement = "", x = spp_info$scientific_name1)
}




# Create data ------------------------------------------------------------------

spp_info <- find_itis(sci = spp_info$scientific_name1[1], 
                          common = spp_info$common_name[1], 
                          known = list("Cyanea" = 51669, 
                                       "Anthozoa" = 51938)) # will have to check these each year

save(spp_info, file = "./data/spp_info.rdata")

# Halipteris finmarchica -> Balticina finmarchica (Sars, 1851)
