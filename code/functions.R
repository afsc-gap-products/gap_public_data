#' -----------------------------------------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' -----------------------------------------------------------------------------

# Install Packages -------------------------------------------------------------
# Here we list all the packages we will need for this whole process

PKG <- c(
  # other tidyverse
  "tidyr",
  "dplyr",
  "magrittr",
  "readr",
  "rmarkdown",
  "here", 

  "janitor",
  # "taxize",
  
  # Text Management
  "stringr")


PKG <- unique(PKG)
for (p in PKG) {
  if(!require(p,character.only = TRUE)) {
    install.packages(p)
    require(p,character.only = TRUE)}
}


# Create Citation File ----------------------------------------------

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

# Set output directory ---------------------------------------------------------

dir_out <- paste0(getwd(), "/output/", Sys.Date(),"/")
dir.create(dir_out)
dir_data <- paste0(getwd(), "/data/")

# Save scripts from each run to output -----------------------------------------
# Just for safe keeping

dir.create(paste0(dir_out, "/code/"))
listfiles<-list.files(path = paste0("./code/"))
listfiles0<-c(listfiles[grepl(pattern = "\\.r",
                              x = listfiles, ignore.case = T)],
              listfiles[grepl(pattern = "\\.rmd",
                              x = listfiles, ignore.case = T)])
listfiles0<-listfiles0[!(grepl(pattern = "~",ignore.case = T, x = listfiles0))]

for (i in 1:length(listfiles0)){
  file.copy(from = paste0("./code/", listfiles0[i]),
            to = paste0(dir_out, "/code/", listfiles0[i]),
            overwrite = T)
}

# General Functions ------------------------------------------------------------

