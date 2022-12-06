#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-04-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Functions --------------------------------------------------------------------

library(taxize)


find_taxize <- function(dat,
                        known = NULL, 
                        db0 = "itis") {
  
  dat1 <- data.frame(dat, 
                     id = NA, 
                     notes = paste0(db0, " species ID was not defined."))
  
  if (is.null(known)) {
    known <- list(0, "")
  }
  
  for (i in 1:nrow(dat1)){
    print(i)
    
    # does this scientific name occur (matching exactly) anywhere else in the scientific_name column? Where?
    # I suspect that this will help save time in processing
    double_listings <- which(dat1$scientific_name == dat1$scientific_name[i])
    
    if (dat1$scientific_name[i]!="" & # if there is a scientific name
        is.na(dat1$id[i])) { # if there isn't a ID already listed there
      
      if (dat1$scientific_name[i] %in% names(lapply(X = known,"[", 1))) { # if already known
        
        dat1$id[double_listings] <- lapply(X = known,"[", 1)[names(lapply(X = known,"[", 1)) %in% dat1$scientific_name[i]][[1]]
        dat1$notes[double_listings] <- paste0(
          "ID defined by user", 
          ifelse(lapply(X = known,"[", 2)[names(lapply(X = known,"[", 1)) %in% 
                                            dat1$scientific_name[i]][[1]]=="", "", ": "),
          lapply(X = known,"[", 2)[names(lapply(X = known,"[", 1)) %in% dat1$scientific_name[i]][[1]] )
      } else { # if we don't already know
        id_indata <- taxize::classification(sci_id = dat1$scientific_name[i], db = db0)
        a <- lapply(X = id_indata,"[", 3)[[1]]
        
        if (sum(unlist(!is.na(a[1])))>0) { # A taxon was successfully identified
          
          a <- a$id[nrow(a)]
          
          dat1$id[double_listings] <- a
          dat1$notes[double_listings] <- paste0("Species ID was defined directly by ", db0, ". ",
                                                ifelse(test = nrow(id_indata) == 1, 
                                                       yes = " This species name is likely invalid.", 
                                                       no = ""))
        } else { # A taxon was NOT successfully identified
          
          # if this is a species (if there are two words, the first word is the genus) use the genus to define this entry instead. 
          if (grepl(pattern = " ", x = dat1$scientific_name[i], fixed = TRUE)) {
            
            genus_name <- strsplit(x = dat1$scientific_name[i], split = " ", fixed = TRUE)[[1]][1]
            
            if (genus_name %in% names(lapply(X = known,"[", 1))) { # if already known
              
              print("Genus defined by user.")
              
              dat1$id[double_listings] <- lapply(X = known,"[", 1)[names(lapply(X = known,"[", 1)) %in% genus_name][[1]]
              dat1$notes[double_listings] <- paste0(
                "Species was not defined directly by ", db0, 
                ", so genus was used to define the species. ID defined by user", 
                ifelse(lapply(X = known,"[", 2)[names(lapply(X = known,"[", 1)) %in% 
                                                  genus_name][[1]]=="", "", ": "),
                lapply(X = known,"[", 2)[names(lapply(X = known,"[", 1)) %in% genus_name][[1]] )
            } else {
              
              id_indata <- taxize::classification(sci_id = genus_name,
                                                  db = db0)
              a <- lapply(X = id_indata,"[", 3)[[1]] 
              
              if (sum(unlist(!is.na(a[1])))>0) { #(!is.na(a[1])) { # A genus was successfully identified
                print("Genus defined by database.")
                
                a <- a$id[nrow(a)]
                
                dat1$id[double_listings] <- a
                dat1$notes[double_listings] <- paste0("Species was not defined directly by ", db0, 
                                                      ", but ",db0," was able to use genus to define the entry. ",
                                                      ifelse(test = nrow(id_indata) == 1, 
                                                             yes = " This species name is likely invalid.", 
                                                             no = ""))
              } else { # there is nothing more to do or test - the genus couldnt be found. 
                dat1$id[double_listings] <- NA
                dat1$notes[double_listings] <- "Species was not found in the database or defined by user."
              }
            }
          } else { # there is nothing more to do or test - the species couldn't be found. 
            dat1$id[double_listings] <- NA
            dat1$notes[double_listings] <- "Species was not found in the database or defined by user."
          }
        }
      }
    }
  }
  
  still_missing <- 
    data.frame(dat1[is.na(dat1[,"id"]), ]) %>% 
    dplyr::select(#-species_name, -common_name, 
                  -species_code) %>%
    dplyr::distinct() %>% 
    dplyr::arrange(scientific_name, notes)
  
  names(dat1)[names(dat1) == "id"] <- db0
  names(dat1)[names(dat1) == "notes"] <- paste0("notes_", db0)
  
  return(list("spp_info" = dat1, 
              "still_missing" = still_missing ) )
  
}

# Load Data --------------------------------------------------------------------

## Oracle Data -----------------------------------------------------------------
a <- list.files(path = here::here("data", "oracle"), pattern = "species")
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

if (option == 1) { # Take species scientific names from species0
spp_info0 <- species0 %>%
  dplyr::select(species_code, species_name) %>% # ,
  # dplyr::filter(species_name == "Careproctus sp. cf. gilberti (Orr)") %>%
  dplyr::rename(scientific_name = species_name) 

} else if (option == 2) { # Take species scientific names from species_classification0$report_name_scientific
# Select data you need 
spp_info0 <- species_classification0 %>% 
  dplyr::select(report_name_scientific, species_code) %>% 
  dplyr::rename(scientific_name = report_name_scientific) %>% 
  dplyr::mutate(scientific_name1 = scientific_name, 
                scientific_name = ifelse(is.na(scientific_name), "", scientific_name))

} else if (option == 3) { # Take species scientific names from species_classification0$report_name_scientific
  # Select data you need 
  
  spp_info0 <- species_classification0
  
  # remove descriptve parts of names
  remove0 <- c("n. sp. ", " sp.", " spp.",
               " unid.", " new species",
               " cf.", #" n.", 
               " larvae", " egg case", " eggs", " egg")
  for (i in 1:length(spp_info0)) {
    
    spp_info0$subspecies_taxon <-
      gsub(pattern = remove0[i],
           replacement = "",
           x = spp_info0$subspecies_taxon,
           fixed = TRUE)
    
    spp_info0$species_taxon <-
      gsub(pattern = remove0[i],
           replacement = "",
           x = spp_info0$species_taxon,
           fixed = TRUE)
  }
  
  
  spp_info0 <- spp_info0 %>% 
    dplyr::mutate(report_name_scientific = dplyr::case_when(
      !is.na(subspecies_taxon) ~ paste0(genus_taxon, " ", species_taxon, " ", subspecies_taxon), 
      !is.na(species_taxon) ~ paste0(genus_taxon, " ", species_taxon), 
      !is.na(genus_taxon) ~ paste0(genus_taxon),       
      !is.na(subgenus_taxon) ~ paste0(subgenus_taxon),       
      !is.na(subtribe_taxon) ~ paste0(subtribe_taxon),       
      !is.na(tribe_taxon) ~ paste0(tribe_taxon),       
      !is.na(subfamily_taxon) ~ paste0(subfamily_taxon),       
      !is.na(family_taxon) ~ paste0(family_taxon),       
      !is.na(superfamily_taxon) ~ paste0(superfamily_taxon),       
      !is.na(infraorder_taxon) ~ paste0(infraorder_taxon),       
      !is.na(suborder_taxon) ~ paste0(suborder_taxon),       
      !is.na(superorder_taxon) ~ paste0(superorder_taxon),       
      !is.na(subdivision_taxon) ~ paste0(subdivision_taxon),       
      !is.na(division_taxon) ~ paste0(division_taxon),       
      !is.na(infraclass_taxon) ~ paste0(infraclass_taxon),       
      !is.na(subclass_taxon) ~ paste0(subclass_taxon),       
      !is.na(class_taxon) ~ paste0(class_taxon),       
      !is.na(superclass_taxon) ~ paste0(superclass_taxon),       
      !is.na(subphylum_taxon) ~ paste0(subphylum_taxon),       
      !is.na(phylum_taxon) ~ paste0(phylum_taxon),       
      !is.na(subkingdom_taxon) ~ paste0(subkingdom_taxon),       
      !is.na(kingdom_taxon) ~ paste0(kingdom_taxon)      
      )) %>% 
  dplyr::select(report_name_scientific, species_code) %>% 
  dplyr::rename(scientific_name = report_name_scientific)
  
} 


## Clean data -----------------------------------
  spp_info0 <- spp_info0 %>% 
    dplyr::mutate(
      scientific_name1 = scientific_name, 
      scientific_name = ifelse(is.na(scientific_name), "", scientific_name), 
              scientific_name = gsub(pattern = "  ", replacement = " ",
                                       x = trimws(scientific_name), fixed = TRUE),
                
                scientific_name1 = scientific_name,
                scientific_name1 = gsub(pattern = "\\s*\\([^\\)]+\\)", # remove parentheses and anything within
                                        replacement = "",
                                        x = scientific_name1),
                scientific_name1 = gsub(pattern = "[0-9]+", # remove all numbers
                                        replacement = "",
                                        x = scientific_name1),
                scientific_name1 = ifelse(is.na(scientific_name1), "", scientific_name1),
                scientific_name1 = gsub(pattern = "  ", replacement = " ",
                                        x = trimws(scientific_name1), fixed = TRUE)) %>% 
  dplyr::arrange(scientific_name1)


# remove descriptve parts of names
remove0 <- c(" sp.", " spp.",
             " unid.", " new species",
             " cf.", " n.",
             " larvae", " egg case", " eggs", " egg")
for (i in 1:length(remove0)) {
  spp_info0$scientific_name1 <-
    gsub(pattern = remove0[i],
         replacement = "",
         x = spp_info0$scientific_name1,
         fixed = TRUE)
}

# remove singluar letters at the end of names
remove0 <- paste0(" ", c(LETTERS))
for (i in 1:length(remove0)) {
  spp_info0 <- spp_info0 %>%
    dplyr::mutate(scientific_name1 =
                    ifelse(substr(x = scientific_name1,
                                  start = (nchar(scientific_name1)-1),
                                  stop = nchar(scientific_name1)) == remove0[i],
                           substr(x = scientific_name1,
                                  start = 1,
                                  stop = (nchar(scientific_name1)-1)),
                           scientific_name1))
}

spp_info0 <- spp_info0 %>%
  dplyr::mutate(
    scientific_name1 = ifelse(is.na(scientific_name1), "", scientific_name1),
    scientific_name1 = gsub(pattern = "  ", replacement = " ",
                            x = trimws(scientific_name1), fixed = TRUE) )  %>%
  dplyr::distinct() %>%
  dplyr::arrange(scientific_name1)

# Create data ------------------------------------------------------------------

more_than_one_opt <- "ITIS returned more than one option. "

known_itis <- list( # will have to check these each year
  # ITIS returned more than one option
  'Anthozoa' = c(51938, more_than_one_opt),
  'Aplidium' = c(159038, more_than_one_opt),
  # 'Ascidian' = c(158854, more_than_one_opt), 
  'Astyris' = c(205062, more_than_one_opt),
  "Caryophylliidae" = c(571698, more_than_one_opt),
  'Chondrichthyes' = c(159785, more_than_one_opt),
  'Cnemidocarpa finmarkiensis' = c(159253, more_than_one_opt),
  "Colus" = c(73892, more_than_one_opt),
  "Cranopsis" = c(566965, more_than_one_opt),
  "Ctenophora" = c(118845, more_than_one_opt),
  'Cucumaria' = c(158191, more_than_one_opt),
  'Cyanea' = c(51669, more_than_one_opt),
  "Echinacea" = c(157891, more_than_one_opt),
  "Echiura" = c(914211, more_than_one_opt),
  "Gammarida" = c(93745, "Possibly misspelled and should be Gammaridae?"),
  # 'gastropod' = c(69459, more_than_one_opt),
  'Halichondria panicea' = c(48396, more_than_one_opt),
  "Hippolytidae" = c(1173151, more_than_one_opt),
  "Hirudinea" = c(69290, paste0(more_than_one_opt, " Could also be 914192, but all options were invalid.")),
  "Hyas" = c(98421, more_than_one_opt),
  'Lepidopsetta' = c(172879, more_than_one_opt),
  'Lepidozona' = c(78909, more_than_one_opt),
  'Liparidae' = c(555701, more_than_one_opt),
  'Liparis' = c(167550, more_than_one_opt),
  "Lumpenus fabricii" = c(631020, more_than_one_opt),
  "Musculus" = c(79472, more_than_one_opt),
  "Pectinaria" = c(67706, more_than_one_opt),
  "Polychaeta" = c(64358, more_than_one_opt),
  "Psolus" = c(1077949, more_than_one_opt),
  "Porella" = c(156418, more_than_one_opt),
  "Pectinaria" = c(67706, more_than_one_opt),
  'Psolus squamatus' = c(1081156, more_than_one_opt),
  "Rhynocrangon sharpi" = c(1187507, more_than_one_opt),
  "Scorpaenichthys marmoratus" = c(692068, more_than_one_opt),
  'Selachii' = c(NA, "Couldn't find what this was refering to."),
  'Serpula' = c(68243, more_than_one_opt),
  'sp.' = c(NA, "Couldn't find what this was refering to."),
  'Suberites ficus' = c(48488, more_than_one_opt),
  'Tellina modesta' = c(81086, more_than_one_opt),
  'Weberella' = c(659295, more_than_one_opt), 
  #   "Polychaete" = c(64358, more_than_one_opt), 

  #   "Admete virdula" = c(205086, "Code for Admete viridula (Fabricius, 1780) (slight misspelling)"), 
  #   "Alaskagorgia aleutiana" = c(NA, "Not available in ITIS."), 
  #   "Argentiformes" = c(553133, "Used code for Osmeriformes, as this is likely what this name is refering to."),
  #   "Artemisina arcigera" = c(204017, "Used code for Artemisina arciger (Schmidt, 1870) (similar (synonym) spelling)."),
  #   # 'Astronebris tatafilius' = c(NA, "Not available in ITIS."), 
  #   'Astronebris tatafilius' = c(NA, "Not available in ITIS."),
  #   'Esperiopsis flagrum' = c(48280, "Worms unaccepted 233110. Used code for Abyssocladia (Levi, 1964)."), 
  #   'Chionoecetes hybrid' = c(98427, "Code for Chionoecetes (Krøyer, 1838) because this is a AFSC custom name."), 
  #   "Chlamys pseudoislandica" = c(79625, "Code for Chlamys pseudislandica  MacNeil, 1967 (old name)"),
  #   'Ciliatoclinocardium ciliatum' = c(NA, "Could not find in WoRMS or ITIS."), 
  #   "Colus datuzenbergii" = c(656335, "Used code for Colus verkruezeni (Kobelt, 1876) (old name)"), 
  #   "Colus oceandromae" = c(74038, "Plicifusus oceanodromae  Dall, 1919 (new name)."), 
  #   "Colossendeis dofleini" = c(1138931, "Hedgpethia dofleini (Loman, 1911) (new name)."), 
  #   'Compsomyax subdiaphanus' = c(81450, "Compsomyax subdiaphana (Carpenter, 1864) (similar spelling)."), 
  #   'Grandicrepidula grandis' = c(72621, 'Used code for Crepidula grandis (old name)'),
  #   'Glebocarcinus oregonensis' = c(98677, "Cancer oregonensis (Dana, 1852) (possible old name?)."), 
  #   'Grandicrepidula grandis' = c(72621, 'Used code for Crepidula grandis (old name)'),
  #   "Halipteris finmarchia" = c(719237,"Possible similar name Halipteris finmarchica (Sars, 1851)"), 
  #   # 'Metacarcinus gracilis' = c(NA, "Cancer gracilis (Dana, 1852) (old name)."), 
  #   # 'Metacarcinus magister' = c(98675, "Cancer magister (Dana, 1852)."), 
  #   'Neoiphinoe coronata' = c(72601, "Used code for Trichotropis coronata (old name)"), 
  #   "Neoiphinoe kroyeri" = c(72602, "Code for Trichotropis kroyeri (old name)"),
  #   # 'Neomenia efgamatoi' = c(205397, "Couldn't find in ITIS or WoRMS, so used Neomenia genus."), 
  #   "Nipponotrophon stuarti" = c(73274, "Code for Trophonopsis stuarti (E. A. Smith, 1880) (old name)"), 
  #   "Olivella beatica" = c(74229, "Olivella baetica (Carpenter, 1864) (similar spelling)."), 
  #   "Peltodoris lentiginosa" = c(78186, "Anisodoris lentiginosa (Millen, 1982) (old name)."), 
  #   'Retifusus roseus' = c(72621, "Crepidula grandis (Middendorff, 1849) (old name)"),
  #   'Laqueus vancouverensis' = c(156850, "Laqueus vancouveriensis (Davidson, 1887) (possibly misspelled). ITIS code 156851 (invalid), so using Laqueus californianus (Koch in Chemnitz, 1848) ITIS code 156850"), 
  #   # "Limneria prolongata" = c(72722, ""), 
  #   "Leukoma staminea" = c(NA, "Not available in ITIS."),
  #   'Liocyma fluctosa' = c(81452, "Liocyma fluctuosum (Gould, 1841) (similar spelling)."), 
  #   'Ophiura sarsii' = c(157424, "Ophiura sarsi (Lütken, 1855) (Similar spelling)"),
  #   "Scabrotrophon rossicus" = c(655972, "Used code for Scabrotrophon rossica  (Egorov, 1993) (similar spelling)"), 
  #   "Tochuina gigantea" = c(78486, "Used code for Tochuina tetraquetra  (Pallas, 1788) (old name)."), 
  #   "Torellivelutina ammonia" = c(72591, "Code for Torellia ammonia (old name)"), 
  #   "Mallotus" = c(162034, more_than_one_opt), 
  #   "Parophrys vetulus X Platichthys stellatus hybrid" = c(NA, "AFSC defined species."), 
  #   "Platichthys stellatus X Pleuronectes quadrituberculatus hybrid" = c(NA, "AFSC defined species."), 
  #   # "Labidochirusendescens" = c(NA, "Not available in ITIS or WoRMS, though may be a misspelling of something like 'Labidochirus endescens'."), 
  #   # "Myriapora subgracilis" = c(156608, "Typo: Used code for Leieschara subgracilis (d'Orbigny, 1852), new name for Myriapora subgracilis (d'Orbigny, 1853)."), 
  "0" = c(0, "0")
)


more_than_one_opt <- "WoRMS returned more than one option. "

known_worms <- list( # will have to check these each year
  # "Neptunea neptunea" = c(NA, "Did not find this species in WoRMS"),
  # "Neptunea vermii" = c(NA, 
  #                       "Did not find this species in WoRMS"), 
  "Alcyonidium" = c(110993, more_than_one_opt),
  "Alcyonium" = c(125284, more_than_one_opt),
  'Anonyx nugax' = c(102514, more_than_one_opt),
  "Amicula" = c(159926, paste0(more_than_one_opt, "But may also be 602771 (A. Witkowski, H. Lange-Bertalot & D. Metzeltin, 2000). ")),
  # "Ascidian" = c(562518, more_than_one_opt), # selected Ascidianibacter ?
  'Axinella rugosa' = c(132491, more_than_one_opt),
  'Axinella' = c(131774, more_than_one_opt),
  'Beroe' = c(1434803, more_than_one_opt),
  "Belonella" = c(341411, paste0(more_than_one_opt, "But unacepted.")), 
  'Buccinum costatum' = c(1023579, paste0(more_than_one_opt, "But unacepted. ")), 
  'Buccinum obsoletum' = c(877185, more_than_one_opt),
  'Buccinum scalariforme' = c(138875, more_than_one_opt),
  'Calliotropis' = c(138585, more_than_one_opt), 
  'Calliostoma canaliculatum' = c(467171, more_than_one_opt),
  'Careproctus gilberti' = c(367288, more_than_one_opt),
  'Chaetopterus' = c(129229, more_than_one_opt),
  'Chlamys' = c(138315, more_than_one_opt),
  'Chrysaora' = c(135261, more_than_one_opt),
  'Clavularia' = c(125286, paste0(more_than_one_opt, "Could also be 602367. ")), 
  "Cidarina" = c(512091, paste0(more_than_one_opt)), 
  'Ctenophora' = c(1248, paste0(more_than_one_opt, "Could also be 163921. ")), 
  'Flabellina' = c(138019, more_than_one_opt),
  'Gadus' = c(125732, more_than_one_opt),
  'gastropod' = c(101, more_than_one_opt), # Gastropoda  Cuvier, 1795
  'Geodia mesotriaena' = c(134035, more_than_one_opt),
  'Glycera' = c(129296, more_than_one_opt),
  'Gonostomatidae' = c(125601, more_than_one_opt),
  'Haliclona digitata' = c(184508, more_than_one_opt),
  'Henricia sanguinolenta' = c(123974, more_than_one_opt),
  'Heteropora' = c(248342, more_than_one_opt),
  'Hiatella' = c(138068, more_than_one_opt),
  'Hippodiplosia' = c(146979, paste0(more_than_one_opt, " But unacepted. ")), # not accepted
  "Howella" = c(126040, more_than_one_opt), 
  "Jordania" = c(397586, more_than_one_opt), 
  "Lepidopus" = c(126097, more_than_one_opt), 
  'Liparis' = c(126160, more_than_one_opt),
  'Lumpenus fabricii' = c(127073 , more_than_one_opt),
  'Lycodes concolor' = c(367289, more_than_one_opt),
  'Molpadia' = c(123540, more_than_one_opt),
  'Musculus' = c(138225, more_than_one_opt),
  'Myxicola infundibulum' = c(130932, more_than_one_opt),
  'Natica russa' = c(749499, paste0(more_than_one_opt, "But unacepted. ")), # 254470 Natica russa Gould, 1859 unaccepted/749499 Natica russa  Dall, 1874 unaccepted
  "Nitidiscala" = c(137943, paste0(more_than_one_opt, "But unacepted - accepted is likely Epitonium Röding, 1798 (code used here). ")), 
  'Nucula tenuis' = c(152323, paste0(more_than_one_opt, "But unacepted. ")),  # 1 152989             Nucula tenuis  Philippi, 1836 unaccepted/607396             Nucula tenuis (Montagu, 1808) unaccepted/152323             Nucula tenuis  (Powell, 1927) unaccepted
  'Pagurus setosus' = c(366787, more_than_one_opt),
  'Pandalopsis' = c(107044, paste0(more_than_one_opt, "Accepted now as Pandalus Leach, 1814 [in Leach, 1813-1815. ")), 
  'Pectinaria' = c(129437, more_than_one_opt),
  'Platichthys' = c(126119, more_than_one_opt),
  'Polymastia pacifica' = c(170653, more_than_one_opt),
  'Polyorchis' = c(267759, more_than_one_opt),
  'Psolidae' = c(123189, more_than_one_opt),
  'Psolus peroni' = c(529651, more_than_one_opt),
  'Rectiplanes' = c(432545, paste0(more_than_one_opt, "Accepted now as Antiplanes Dall, 1902, 432398. ")), 
  'Rossia' = c(138481, more_than_one_opt), 
  'Scorpaenichthys marmoratus' = c(282726, more_than_one_opt),
  'Serpula vermicularis' = c(131051, more_than_one_opt),
  'Searlesia' = c(719179, more_than_one_opt), 
  'Stylatula elongata' = c(286695, more_than_one_opt),
  "Torpedo" = c(826639, more_than_one_opt), 
  'Themisto' = c(101800, more_than_one_opt),
  "Velella" = c(117200, more_than_one_opt),
  'Vulcanella' = c(170325, paste0(more_than_one_opt, "Could also be 602186 ")),
  "Weberella" = c(132059 more_than_one_opt),
  'Yoldia hyperborea' = c(141989, more_than_one_opt),
  # "Iphinoe" = 110391, 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # # '' = c(, more_than_one_opt), 
  # 'Buccinum ectomycina' = c(NA, "WoRMS could not find."), 
  # 'Esperiopsis flagrum' = c(864174, "Worms unaccepted 233110. Used code for Abyssocladia flagrum (Lehnert, Stone & Heimler, 2006).")
  # 
  # # "" = c(NA, 
  # #        ""), 
  "0" = c(0, "0")
)

# Run function -----------------------------------------------------------------

rnge <- 1:nrow(spp_info0) # rnge <- 329:350

# ITIS
spp_info_itis <- find_taxize(
  dat = data.frame(
    # species_name = spp_info0$scientific_name[rnge], 
    scientific_name = spp_info0$scientific_name1[rnge], 
    # common_name = spp_info0$common_name[rnge],
    species_code = spp_info0$species_code[rnge]), 
  known = known_tsn,
    db0 = "itis")

# WoRMS
spp_info_worms <- find_taxize(
  dat = data.frame(
    # species_name = spp_info0$scientific_name[rnge], 
    scientific_name = spp_info0$scientific_name1[rnge], 
    # common_name = spp_info0$common_name[rnge],
    species_code = spp_info0$species_code[rnge]), 
  known = known_worms,
  db0 = "worms")

# Combine
spp_info <- 
  dplyr::full_join(
    x = spp_info_itis$spp_info, 
    y = spp_info_worms$spp_info, 
    by = c("scientific_name", "species_code")) %>% 
  dplyr::full_join(
    x = ., 
    y = species0 %>% 
           dplyr::select(species_code, species_name, common_name), 
     by = "species_code") %>% 
  dplyr::mutate(common_name = ifelse(is.na(common_name), "", common_name), 
                common_name = gsub(pattern = "  ", replacement = " ",
                                   x = trimws(common_name), fixed = TRUE)) 

still_missing <- dplyr::bind_rows(
  spp_info_itis$still_missing %>% 
    dplyr::mutate(db = "itis"), 
  spp_info_worms$still_missing%>% 
    dplyr::mutate(db = "worms"))


# Save
save(spp_info, still_missing, 
     file = paste0("./data/spp_info",option,".rdata"))

readr::write_csv(x = spp_info, file = paste0("./data/spp_info",option,".csv"))

readr::write_csv(x = still_missing, file = paste0("./data/still_missing",option,".csv"))

