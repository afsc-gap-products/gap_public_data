#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz (emily.markowitz AT noaa.gov)
#' Notes: 
#' # Each year you will need to: 
#' # - download the new data using the data_dl.R script
#' # - aquire the new taxonomic_confidence tables. Contact D Stevenson. 
#' # - run the find_taxize_species_codes.R script to find the appropriate and most up to date ITIS and WoRMS codes for species. 
#' # - run the check to compare this year's data to last years. Make sure the data are similar and look right! 
#' -----------------------------------------------------------------------------

# START ------------------------------------------------------------------------

# source("./code/run.R")

# *** REPORT KNOWNS ------------------------------------------------------------

# The surveys we will consider covering in this data are: 
surveys <- 
  data.frame(survey_definition_id = c(143, 98, 47, 52, 78), 
             SRVY = c("NBS", "EBS", "GOA", "AI", "BSS"), 
             SRVY_long = c("northern Bering Sea", 
                           "eastern Bering Sea", 
                           "Gulf of Alaska", 
                           "Aleutian Islands", 
                           "Bering Sea Slope") )

# Support scripts --------------------------------------------------------------

source("https://raw.githubusercontent.com/afsc-gap-products/metadata/main/code/functions_oracle.R")
source('./code/functions.R')
# source('./code/data_dl.R')

source('./code/data.R')

source('./code/calc_cpue.R')

# Check report -----------------------------------------------------------------

rmarkdown::render(input = here::here("code", "calc_cpue_check.rmd"),
                  output_dir = dir_out, 
                  output_format = 'pdf_document', 
                  output_file = "calc_cpue_check.pdf")

# Update README ----------------------------------------------------------------

source('./code/functions.R')
dir_out <- paste0(getwd(), "/output/2023-05-15/")

load(paste0(dir_out, "FOSS_CPUE_PRESONLY.RData"))
load(paste0(dir_out, "FOSS_CPUE_JOIN.RData"))
load(paste0(dir_out, "FOSS_CPUE_ZEROFILLED.RData"))

link_code_books <- gsub("[\\(\\)]", "", 
                        regmatches(metadata_table, 
                                   gregexpr("\\(.*?\\)", metadata_table))[[1]])
link_code_books <- link_code_books[grep(pattern = "manual-and-data", x = link_code_books)]

comb <- list.files(path = "docs/", pattern = ".Rmd", ignore.case = TRUE)
comb <- comb[comb != "footer.Rmd"]
comb <- gsub(pattern = ".Rmd", replacement = "", x = comb, ignore.case = TRUE)
for (i in 1:length(comb)) {
  tocTF <- FALSE
  file_in <- here::here("docs", paste0(comb[i],".Rmd"))
  file_out <- here::here("docs", 
                         ifelse(comb[i] == "README", "index.html", paste0(comb[i], ".html")))
  file_out_main <- here::here(ifelse(comb[i] == "README", "index.html", paste0(comb[i], ".html")))
  
  rmarkdown::render(input = file_in,
                    output_dir = "./", 
                    output_format = 'html_document', 
                    output_file = file_out)
  file.copy(from = file_out_main, 
            to = file_out, 
            overwrite = TRUE)
  file.remove(file_out_main)
  
}

tocTF <- TRUE
rmarkdown::render(input = "./docs/README.Rmd",
                  output_dir = "./", 
                  output_format = 'md_document', 
                  output_file = "./README.md")

# Share table to oracle --------------------------------------------------------

source("./code/oracle_upload.R")
