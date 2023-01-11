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

  "janitor",
  "taxize",
  
  # Text Management
  "stringr")


PKG <- unique(PKG)
for (p in PKG) {
  if(!require(p,character.only = TRUE)) {
    install.packages(p)
    require(p,character.only = TRUE)}
}

# Set output directory ---------------------------------------------------------

dir_out <- paste0(getwd(), "/output/", Sys.Date(),"/")
dir.create(dir_out)

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

