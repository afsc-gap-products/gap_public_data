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

# Check work -------------------------------------------------------------------

# source('./code/data_dl_check.R')
# dir.create(path = paste0(dir_out, "/check/"))
# rmarkdown::render(paste0("./code/check.Rmd"),
#                   output_dir = dir_out,
#                   output_file = paste0("./check/check.docx"))

# Update README ----------------------------------------------------------------

source('./code/functions.R')
dir_out <- paste0(getwd(), "/output/2023-04-10/")

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
  rmarkdown::render(input = here::here("docs", paste0(comb[i],".Rmd")),
                    output_dir = "./", 
                    output_format = 'html_document', 
                    output_file = here::here("docs", paste0(comb[i],".html")))
  file.copy(from = here::here(paste0(comb[i],".html")), 
            to = here::here("docs", paste0(comb[i],".html")), 
            overwrite = TRUE)
  file.remove(here::here(paste0(comb[i],".html")))
  
}

tocTF <- TRUE
rmarkdown::render(input = "./docs/README.Rmd",
                  output_dir = "./", 
                  output_format = 'md_document', 
                  output_file = "./README.md")

file.copy(from = "./docs/README.md", to = "./README.md", overwrite = TRUE)

# Share table to oracle --------------------------------------------------------

source("./code/oracle_upload.R") 
