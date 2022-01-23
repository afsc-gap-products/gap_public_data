#' ---------------------------------------------
#' title: Create public data 
#' author: EH Markowitz
#' start date: 2022-01-01
#' Notes: 
#' ---------------------------------------------

# INSTALL PACKAGES -------------------------------------
# Here we list all the packages we will need for this whole process
# We'll also use this in our works cited page!!!
PKG <- c(
  # Keeping Organized
  "devtools", # Package development tools for R; used here for downloading packages from GitHub
  # "renv", # saves the packages in the R environment
  
  "akgfmaps",
  
  "kableExtra",

  # other tidyverse
  "dplyr",
  "googledrive",
  "magrittr",
  "readr",
  "readxl", 
  "tidyr",
  
  # Text Management
  "stringr")


PKG <- unique(PKG)
for (p in PKG) {
  if(!require(p,character.only = TRUE)) {
    install.packages(p)
    require(p,character.only = TRUE)}
}


# General Functions ------------------------------------------------------------

SameColNames<-function(df.ls) {
  #All column names
  colnames0<-c()
  for (i in 1:length(df.ls)){
    df0<-df.ls[[i]]
    # colnames(df0)<-toupper(colnames(df0))
    df0<-janitor::clean_names(df0)
    df.ls[[i]]<-df0
    colnames0<-c(colnames0, (colnames(df0)))
  }
  colnames0<-sort(unique(colnames0), decreasing = T)
  
  #New df's
  df.ls0<-list()
  df.rbind0<-c()
  for (i in 1:length(df.ls)){
    df0<-df.ls[[i]]
    colnames.out<-colnames0[!(colnames0 %in% colnames(df0))]
    if (length(colnames.out) != 0) {
      for (ii in 1:length(colnames.out)){
        df0[,(ncol(df0)+1)]<-NA
        names(df0)[ncol(df0)]<-colnames.out[ii]
      }
    }
    df0<-df0[,match(table =  colnames(df0), x = colnames0)]
    df.ls0[[i]]<-df0
    names(df.ls0)[i]<-names(df.ls)[i]
    df.rbind0<-rbind.data.frame(df.rbind0, df0)
  }
  return(df.rbind0)
}
