# Load libraries, establish functions, and load external data
PKG <- c(
  # Keeping Organized
  "here",
  # "arsenal",
  
  # plotting
  "ggplot2",
  "rnaturalearth",
  "rnaturalearthdata",
  
  # other tidyverse
  "tidyr",
  "dplyr",
  "magrittr",
  "readr",
  
  # Text Management
  "stringr")


PKG <- unique(PKG)
for (p in PKG) {
  if(!require(p,character.only = TRUE)) {
    install.packages(p)
    require(p,character.only = TRUE)}
}


# Where/What are differences between columns
diff_between_cols <- function(dat, colx, coly, 
                              id_cols = c("species_code", "year", "srvy", "station", "stratum", "cruise")) {
  a <- dat[which(!(dat[,colx] == dat[,coly])),
           c(ifelse(colx != "common_name.x", "common_name.x", "scientific_name.x"),
             id_cols, colx, coly)] #%>% 
  # dplyr::rename(paste0(colx, ' | ', coly) = compare)
  if (nrow(a)>0) {
    if (is.character(unlist(dat[,colx])[1][[1]])) {
      a <- a %>%
        dplyr::mutate(compare = paste0(get(colx), " | ", get(coly)))
      out <- table(a$compare)
    } else if (is.numeric(unlist(dat[,colx])[1][[1]])) {
      out <- a %>%
        dplyr::mutate(difference = get(colx) - get(coly)) # %>% 
      # dplyr::select(species_code, difference)
      if (nrow(out)>100) {
        out$srvy <- as.factor(out$srvy)
        out$common_name.x <- as.factor(out$common_name.x)
        out$species_code <- as.factor(out$species_code)
        out <- summary(out)
      }
    }
  } else {
    out <- ""#paste0("No differences between ", colx, " and ", coly, ".")
  }
  return(out)
}

# find how prevelant issues in data are
wheres_trouble <- function(dat, col, trouble) {
  
  temp <- dat %>% 
    dplyr::rename(col = all_of(col)) #%>% 
  # dplyr::select(col)
  
  if (is.na(trouble)) {
    temp <- temp %>% 
      dplyr::filter(is.na(col))
  } else {
    temp <- temp %>% 
      dplyr::filter(col == trouble)
  }
  
  if (nrow(temp) == 0) {
    out <- ""#paste0("No '", trouble, "' were found in the column ", col, ".")
  } else {
    temp1 <- temp
    out <- list(#condition = paste0("Searching for '", trouble, "' in the column ", col, "."), 
      how_many = table(temp[,c("year", "srvy")])#, 
      # data_subset = temp1
    )
    names(out) <- paste0("Yes, '", trouble, "' occurred ",nrow(temp)," times in the column '", col, "'.")
    
  }
  return(out)
}


plot_stations <- function(dat, srvy0) {
  world <- map_data("world2")
  
  dat0 <- dat %>% 
    dplyr::filter(srvy == srvy0) %>% 
    dplyr::mutate(longitude_dd_start = 
                    ifelse(longitude_dd_start>0, 
                           abs(longitude_dd_start-360), 
                           abs(longitude_dd_start+360))) %>%
    dplyr::select(year, longitude_dd_start, latitude_dd_start) %>% 
    unique()
  
  gg <- ggplot(data = dat0,
               mapping = aes(x = longitude_dd_start, y = latitude_dd_start, group = factor(year))) +
    coord_fixed(1.3) + 
    geom_polygon(data = world,
                 mapping=aes(x=long, y=lat, group=group), 
                 color=NA, fill="lightgreen") +
    geom_point(size = .05) +
    ggplot2::ylim(range(dat0$latitude_dd_start)) + 
    ggplot2::xlim(range(dat0$longitude_dd_start)) 
  
  if (length(unique(dat0$year))>20) {
    gg <- gg + 
      facet_wrap("year", ncol = 4) 
  } else {
    # } else if (length(unique(dat0$year))>7) {
    gg <- gg +
      facet_wrap("year", ncol = 2)
    # } else {
    #   gg <- gg +
    #   facet_wrap("year", ncol = 1)
  }
  gg <- gg +
    ggtitle(paste0(srvy0)) +
    theme(panel.grid.major = element_line(colour = "grey90"), 
          panel.background = element_rect(fill = NA,
                                          colour = NA),
          panel.border = element_rect(fill = NA,
                                      colour = "grey20"),
          strip.background = element_blank(), 
          strip.text = element_text(size = 5, face = "bold"),
          axis.text = element_blank(), 
          axis.title = element_blank(), 
          axis.ticks = element_blank())
  
  return(gg)
}




data_check <- function(dat) {
  
  data <- data0 <- data1 <- dat
  
  print("------------ Are there NAs or 0s in the station column? ...why? ------------")
  
  temp <- data0 %>% 
    dplyr::filter(station %in% c(0, NA)) %>% 
    dplyr::mutate(id = paste0(srvy,"_",cruise)) %>%
    dplyr::select(id) %>% 
    table() %>% 
    data.frame()
  
  if (nrow(temp)>0) {
    
    data <- data %>%
      dplyr::filter(!(station %in% c(0, NA)))  
    
    data1 <- data0 %>%
      dplyr::filter(!(station %in% c(0, NA))) 
    
    print(paste0("Yes, there were ",nrow(temp)," survey-cruise combinations where there were NAs or 0s in the station names."))
    print(paste0("This removed ",
                 nrow(data0)-nrow(data1),
                 " rows from the initial dataset."))
    
    if (nrow(temp)<20) {
      print(temp)
    } else {
      print("here are the first 6 rows:")
      print(head(temp))
    }
    
  } else {
    print("Nope! No rows were removed from the dataset for this issue. ")
  }
  
  print("------------ Are there NAs or 0s in the stratum column? ...why? ------------")
  
  temp <- data0 %>% 
    dplyr::filter((stratum %in% c(0, NA))) %>% 
    dplyr::mutate(id = paste0(srvy,"_",cruise)) %>%
    dplyr::select(id) %>% 
    table() %>% 
    data.frame()
  
  if (nrow(temp)>0) {
    
    data <- data %>%
      dplyr::filter(!(stratum %in% c(0, NA)))  
    
    data1 <- data0 %>%
      dplyr::filter(!(stratum %in% c(0, NA))) 
    
    print(paste0("Yes, there were ",nrow(temp)," survey-cruise combinations where there were NAs or 0s in the stratum names."))
    print(paste0("This removed ",
                 nrow(data0)-nrow(data1),
                 " rows from the initial dataset."))
    
    if (nrow(temp)<20) {
      print(temp)
    } else {
      print("here are the first 6 rows:")
      print(head(temp))
    }
    
  } else {
    print("Nope! No rows were removed from the dataset for this issue. ")
  }
  
  
  print("------------ Are there NAs or 0s in the species_code column? ...why? ------------")
  
  temp <- data0 %>% 
    dplyr::filter((species_code %in% c(0, NA))) %>% 
    dplyr::mutate(id = paste0(srvy,"_",cruise)) %>%
    dplyr::select(id) %>% 
    table() %>% 
    data.frame()
  
  if (nrow(temp)>0) {
    
    data <- data %>%
      dplyr::filter(!(species_code %in% c(0, NA)))  
    
    data1 <- data0 %>%
      dplyr::filter(!(species_code %in% c(0, NA))) 
    
    print(paste0("Yes, there were ",nrow(temp)," survey-cruise combinations where there were NAs or 0s in the species_code names."))
    print(paste0("This removed ",
                 nrow(data0)-nrow(data1),
                 " rows from the initial dataset."))
    
    if (nrow(temp)<20) {
      print(temp)
    } else {
      print("here are the first 6 rows:")
      print(head(temp))
    }
    
  } else {
    print("Nope! No rows were removed from the dataset for this issue. ")
  }
  
  print("------------ Are there rows with 0s in the cpue_kgha and cpue_noha columns? ------------")
  
  temp <- data0 %>%
    dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
      (cpue_kgha %in% c(NA, 0) & cpue_noha %in% c(NA, 0)) ) # !(cpue_kgha == 0 & cpue_noha == 0)
  
  if (nrow(temp)>0){
    
    data <- data %>%
      dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
        !(cpue_kgha %in% c(NA, 0) & cpue_noha %in% c(NA, 0)) ) # !(cpue_kgha == 0 & cpue_noha == 0)  
    
    data1 <- data0 %>%
      dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
        !(cpue_kgha %in% c(NA, 0) & cpue_noha %in% c(NA, 0)) ) # !(cpue_kgha == 0 & cpue_noha == 0)
    
    print(paste0("Yes, there are 0s ro NAs in both the cpue_kgha and cpue_noha columns."))
    print(paste0("This removed ",
                 nrow(data0)-nrow(data1),
                 " rows from the initial dataset.")) 
    
    if (nrow(temp)<20) {
      print(temp)
    } else {
      print("here are the first 6 rows:")
      print(head(temp))
    }
    
  } else {
    print("Nope! No rows were removed from the dataset for this issue. ")
  }
  
  
  
  # if (sum(names(data0) %in% c("count", "weight_kg"))>0) {
  # 
  #   print("------------ Are there rows with 0s in the count and weight_kg columns? ------------")
  #   
  #   temp <- data0 %>%
  #     dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
  #       (count %in% c(NA, 0) & weight_kg %in% c(NA, 0)) ) 
  #   
  #   if (nrow(temp)>0){
  #     
  #     data <- data %>%
  #       dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
  #         !(count %in% c(NA, 0) & weight_kg %in% c(NA, 0)) ) 
  #     
  #     data1 <- data0 %>%
  #       dplyr::filter( # this will remove usless 0-cpue values, which shouldn't happen, but good to double check
  #         !(count %in% c(NA, 0) & weight_kg %in% c(NA, 0)) ) 
  #     
  #     print(paste0("Yes, there are 0s or NAs in both the count and weight_kg columns."))
  #     print(paste0("This removed ",
  #                  nrow(data0)-nrow(data1),
  #                  " rows from the initial dataset.")) 
  #     
  #     if (nrow(temp)<20) {
  #       print(temp)
  #     } else {
  #       print("here are the first 6 rows:")
  #       print(head(temp))
  #     }
  #     
  #   } else {
  #     print("Nope! No rows were removed from the dataset for this issue. ")
  #   }
  #   
  # }
  
  print("------------ Are there duplicates/unsummarized data in the dataset? ------------")
  
  
  # # To be able to match my data, we'll need to summarize the data so there is one spp observation per haul. For this example, I will summarize on srvy, cruise, stratum, station, haul, and vessel_id
  # 
  # # I have no way of knowing if/how catchjoin or other *join columns were used to create the OG data
  # 
  # 
  # print("******* Test1: group_by: srvy, cruise, stratum, station, and vessel_id")
  # 
  # temp <- data %>%
  #   dplyr::mutate(id = paste0(srvy,"_",cruise,"_",stratum,"_",station,"_",vessel_id)) %>%
  #   dplyr::select(id, species_code) %>%
  #   table() %>%
  #   data.frame() %>%
  #   dplyr::filter(Freq > 1) %>%
  #   dplyr::arrange(-Freq, id)
  # 
  # 
  # data0 %>%
  #   dplyr::filter(srvy == "AI" &
  #                   cruise == 199401 &
  #                   stratum == 322 &
  #                   station == "112-22" &
  #                   vessel_id == 94 &
  #                   species_code == 21720)
  # 
  # 
  # if (nrow(temp)>0){
  # 
  #   # data <- data %>%
  #   #   dplyr::group_by(srvy, cruise, stratum, station, vessel_id, # haul,
  #   #                   year, survey, common_name, species_code, scientific_name,
  #   #                   longitude_dd_start, latitude_dd_start, date_time,
  #   #                   surface_temperature_c, bottom_temperature_c, depth_m) %>%
  #   #   dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE), # THIS IS WRONG
  #   #                    cpue_noha = sum(cpue_noha, na.rm = TRUE))
  # 
  #   data1 <- data0 %>%
  #     dplyr::group_by(srvy, cruise, stratum, station, vessel_id, # haul,
  #                     year, survey, common_name, species_code, scientific_name,
  #                     longitude_dd_start, latitude_dd_start, date_time,
  #                     surface_temperature_c, bottom_temperature_c, depth_m) %>%
  #     dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE),
  #                      cpue_noha = sum(cpue_noha, na.rm = TRUE))
  # 
  #   data1 <- data0 %>%
  #     dplyr::group_by(srvy, cruise, stratum, station, vessel_id # haul
  #                     ) %>%
  #     dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE),
  #                      cpue_noha = sum(cpue_noha, na.rm = TRUE))
  # 
  #   print(paste0("Yes, there are ", nrow(temp),
  #                " unique instances when srvy, cruise, stratum, station, and vessel_id were not summarized to one observation per haul event. ",
  #                "This could remove ",
  #                nrow(data0)-nrow(data1),
  #                " rows from the initial dataset... but I'll remove them in test 2"))
  # 
  #   if (nrow(temp)<20) {
  #     print(temp)
  #   } else {
  #     print("here are the first 6 rows:")
  #     print(head(temp))
  #   }
  # 
  # } else {
  #   print("Nope! No rows were removed from the dataset for this issue. ")
  # }
  # 
  
  # print("******* Test2: group_by: srvy, cruise, stratum, station, vessel_id, and haul")
  print("group_by: srvy, cruise, stratum, station, vessel_id, and haul")
  
  temp <- data0 %>% 
    dplyr::mutate(id = paste0(srvy,"_",cruise,"_",stratum,"_",station,"_",vessel_id,"_",haul)) %>%
    dplyr::select(id, species_code) %>%
    table() %>% 
    data.frame() %>% 
    dplyr::filter(Freq > 1) %>% 
    dplyr::arrange(-Freq, id)
  
  
  if (nrow(temp)>0) {
    
    if (sum(names(data) %in% "weight_kg")==0) {
      data <- data %>%
        dplyr::mutate(weight_kg = NA, 
                      count = NA)
      
      data0 <- data0 %>%
        dplyr::mutate(weight_kg = NA, 
                      count = NA)
    }
    
    if (sum(names(data) %in% "surface_temperature_c")>0) {
      data <- data %>%
        dplyr::group_by(srvy, cruise, stratum, station, vessel_id, haul, 
                        year, common_name, species_code, scientific_name, 
                        surface_temperature_c, bottom_temperature_c, depth_m, survey, date_time, 
                        longitude_dd_start, latitude_dd_start) %>% 
        dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE), 
                         cpue_noha = sum(cpue_noha, na.rm = TRUE), 
                         weight_kg = sum(weight_kg, na.rm = TRUE), 
                         count = sum(count, na.rm = TRUE),
                         area_swept_ha = mean(area_swept_ha, na.rm = TRUE))
      
      data1 <- data0 %>%
        dplyr::group_by(srvy, cruise, stratum, station, vessel_id, haul, 
                        year, common_name, species_code, scientific_name, 
                        surface_temperature_c, bottom_temperature_c, depth_m, survey, date_time, 
                        longitude_dd_start, latitude_dd_start) %>% 
        dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE), 
                         cpue_noha = sum(cpue_noha, na.rm = TRUE), 
                         weight_kg = sum(weight_kg, na.rm = TRUE), 
                         count = sum(count, na.rm = TRUE),
                         area_swept_ha = mean(area_swept_ha, na.rm = TRUE))
    } else {
      data <- data %>%
        dplyr::group_by(srvy, cruise, stratum, station, vessel_id, haul, 
                        year, common_name, species_code, scientific_name, 
                        longitude_dd_start, latitude_dd_start) %>% 
        dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE), 
                         cpue_noha = sum(cpue_noha, na.rm = TRUE), 
                         weight_kg = sum(weight_kg, na.rm = TRUE), 
                         count = sum(count, na.rm = TRUE),
                         area_swept_ha = mean(area_swept_ha, na.rm = TRUE))
      
      data1 <- data0 %>%
        dplyr::group_by(srvy, cruise, stratum, station, vessel_id, haul, 
                        year, common_name, species_code, scientific_name, 
                        longitude_dd_start, latitude_dd_start) %>% 
        dplyr::summarise(cpue_kgha = sum(cpue_kgha, na.rm = TRUE), 
                         cpue_noha = sum(cpue_noha, na.rm = TRUE), 
                         weight_kg = sum(weight_kg, na.rm = TRUE), 
                         count = sum(count, na.rm = TRUE),
                         area_swept_ha = mean(area_swept_ha, na.rm = TRUE)) 
    }
    
    print(paste0("Yes, there are instances when these vars were not summarized to one observation per haul event. "))
    print(paste0("This removed ",
                 nrow(data0)-nrow(data1),
                 " rows from the initial dataset.")) 
    
    if (nrow(temp)<20) {
      print(temp)
    } else {
      print("here are the first 6 rows:")
      print(head(temp))
    }
    
  } else {
    print("Nope! No rows were removed from the dataset for this issue. ")
  }
  
  return(data %>% 
           dplyr::ungroup())
  
}

plot_cpue <- function(dat, spp0, 
                      dataset1 = "public_new", 
                      dataset2 = "public_old") {
  
  dat0 <- dat %>% 
    dplyr::select(srvy, year, species_code, 
                  dplyr::starts_with("cpue_kgha."), 
                  dplyr::starts_with("cpue_noha.")) %>% 
    dplyr::filter(species_code == spp0 #& 
                  # srvy == unique(dat$srvy)[i]
    ) %>% 
    dplyr::group_by(srvy, year, species_code) %>% 
    dplyr::summarise(cpue_kgha.x = sum(cpue_kgha.x, na.rm = TRUE), 
                     cpue_kgha.y = sum(cpue_kgha.y, na.rm = TRUE), 
                     cpue_noha.x = sum(cpue_noha.x, na.rm = TRUE), 
                     cpue_noha.y = sum(cpue_noha.y, na.rm = TRUE)) 
  
  dat0 <- 
    dplyr::full_join(
      dat0 %>%
        dplyr::select(-dplyr::starts_with("cpue_noha.")) %>%
        tidyr::pivot_longer(cols = dplyr::starts_with("cpue_kgha."),
                            values_to = "cpue_kgha",
                            names_to = "dataset_cpue_kgha",
                            values_drop_na = TRUE) %>% 
        dplyr::mutate(
          dataset = dplyr::case_when(
            dataset_cpue_kgha == "cpue_kgha.x" ~ dataset1, 
            dataset_cpue_kgha == "cpue_kgha.y" ~ dataset2)), 
      dat0 %>%
        dplyr::select(-dplyr::starts_with("cpue_kgha.")) %>%
        tidyr::pivot_longer(cols = dplyr::starts_with("cpue_noha."),
                            values_to = "cpue_noha",
                            names_to = "dataset_cpue_noha",
                            values_drop_na = TRUE) %>% 
        dplyr::mutate(dataset = dplyr::case_when(
          dataset_cpue_noha == "cpue_noha.x" ~ dataset1, 
          dataset_cpue_noha == "cpue_noha.y" ~ dataset2 
        )), 
      by = c("srvy", "year", "species_code", "dataset")) #%>% 
  # tidyr::pivot_longer(cols = dplyr::starts_with("dataset_"),
  #                     values_to = "cpue",
  #                     names_to = "dataset",
  #                     values_drop_na = TRUE)
  
  g1 <- ggplot(data = dat0) +
    ggplot2::geom_point(
      mapping = aes(x = year, y = cpue_kgha, 
                    group = dataset, 
                    col = dataset, 
                    shape = dataset), 
      alpha = .5) +    
    ggtitle(dat$common_name.x[dat$species_code == spp0][1]) + 
    facet_wrap("srvy", ncol = 2) + 
    theme_minimal() +
    theme(legend.position = "bottom", 
          legend.title = element_blank())
  
  g2 <- ggplot(data = dat0) +
    ggplot2::geom_point(
      mapping = aes(x = year, y = cpue_noha, 
                    group = dataset, 
                    col = dataset, 
                    shape = dataset), 
      alpha = .5) +
    ggtitle("") + 
    facet_wrap("srvy", ncol = 2, scales = "free") + 
    theme_minimal() +
    theme(legend.position = "bottom", 
          legend.title = element_blank())
  
  library(cowplot)
  gg <- cowplot::plot_grid(g1, g2)
  
  return(gg)
}
