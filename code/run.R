#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------


# No stratum listed for AI in racebase.stratum???


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

# *** Run Analysis -------------------------------------------------------------


