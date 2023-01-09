<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

## This code is primarily maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[@EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
*Bering Sea Groundfish Survey Team*

Alaska Fisheries Science Center,  
National Marine Fisheries Service,  
National Oceanic and Atmospheric Administration,  
Seattle, WA 98195

## Table of contents

> - [*Cite this data*](#cite-this-data)
> - [*Metadata*](#metadata)
> - [*Data description*](#data-description)
> - [*Bottom trawl surveys and
>   regions*](#bottom-trawl-surveys-and-regions)
> - [*Relevant technical memorandums*](#relevant-technical-memorandums)
> - [*User resources*](#user-resources)
> - [*Access constraints*](#access-constraints)
> - [*Table short metadata*](#table-short-metadata)
> - [*Column-level metadata*](#column-level-metadata)
> - [*Access the data*](#access-the-data)
> - [*Access data interactively through the FOSS
>   platform*](#access-data-interactively-through-the-foss-platform)
>   - [*Connect to the API with R*](#connect-to-the-api-with-r)
>   - [*Select all data*](#select-all-data)
>   - [*Subset data*](#subset-data)
> - [*Access data via Oracle*](#access-data-via-oracle)
>   - [*Connect to Oracle from R*](#connect-to-oracle-from-r)
>   - [*Select all data*](#select-all-data)
>   - [*Subset data*](#subset-data)
>   - [*Join catch and haul data*](#join-catch-and-haul-data)
> - [*Suggestions and comments*](#suggestions-and-comments)
> - [*R version metadata*](#r-version-metadata)
> - [*NOAA README*](#noaa-readme)
> - [*NOAA License*](#noaa-license)

# Cite this data

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> NOAA Fisheries Alaska Fisheries Science Center. RACE Division Bottom
> Trawl Survey Data Query, Available at: www.fisheries.noaa.gov/foss,
> Accessed mm/dd/yyyy

The code is in development. Refer to
[releases](https://github.com/afsc-gap-products/gap_public_data/releases)
for finalized products. These data were last ran and pushed to the AFSC
oracle on **January 08, 2023**. *This is not the date that these data
were pulled into FOSS and the FOSS dataset may be behind.*

# Metadata

## Data description

The Resource Assessment and Conservation Engineering Division (RACE)
Groundfish Assessment Program (GAP) of the Alaska Fisheries Science
Center (AFSC) conducts fisheries-independent bottom trawl surveys to
monitor the condition of the demersal fish and crab stocks of Alaska.
These data are developed to describe the temporal distribution and
abundance of commercially and ecologically important groundfish species,
examine the changes in the species composition of the fauna over time
and space, and describe the physical environment of the groundfish
habitat.

There are no legal restrictions on access to the data. They reside in
the public domain and can be freely distributed. Users must read and
fully comprehend the metadata prior to use. Data should not be used
beyond the limits of the source scale. Acknowledgement of NOAA, as the
source from which these data were obtained, in any publications and/or
other representations of these data, is suggested. These data are
compiled and approved annually after each summer survey season. The data
from previous years are unlikely to change substantially once published.

These data are zero-filled (presence and absence) observations from
surveys conducted on fishing vessels. These surveys monitor trends in
distribution and abundance of groundfish, crab, and bottom-dwelling
species in Alaska’s marine ecosystems. These data include estimates of
catch-per-unit-effort (CPUE) for most identified species at a standard
set of stations. Some survey data are excluded, such as non-standard
stations, surveys completed in earlier years using
different/non-standard gear, and special tows and non-standard data
collections.

Though not included in the public data, these surveys also collect
oceanographic and environmental data, and biological data such as
length, weight, stomach contents (to learn more about diet), otoliths
(fish ear bones to learn about age), and tissue samples for genetic
analysis, all of which can be shared upon special request. Also not
included in the public data are estimated biomass (average total weight
of all fish and crabs sampled) of crabs and groundfish that support the
creation of annual stock assessments.

## Bottom trawl surveys and regions

<img src="img/_grid_bs.png" alt="Eastern and Northern Bering Sea Shelf" align="right" width="250"/>

<img src="img/_grid_ai.png" alt="Aleutian Islands" align="right" width="400"/>

- **Eastern Bering Sea Shelf (EBS)** (Markowitz et al., 2022)
  - Annual
  - Fixed stations at center of 20 x 20 nm grid
- **Northern Bering Sea (NBS)** (Markowitz et al., 2022)
  - Biennial/Annual
  - Fixed stations at center of 20 x 20 nm grid
- **Eastern Bering Sea Slope (BSS)** (Hoff, 2016)
  - Intermittent (funding dependent)
  - Modified Index-Stratified Random of Successful Stations Survey
    Design
- **Aleutian Islands (AI)** (Von Szalay and Raring, 2020)
  - Triennial (1990s)/Biennial since 2000 in even years
  - Modified Index-Stratified Random of Successful Stations Survey
    Design
- **Gulf of Alaska (GOA)** (Von Szalay and Raring, 2018)
  - Triennial (1990s)/Biennial since 2001 in odd years
  - Stratified Random Survey Design

## Relevant technical memorandums

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-RN979" class="csl-entry">

Hoff, G. R. (2016). *Results of the 2016 eastern Bering Sea upper
continental slope survey of groundfishes and invertebrate resources*
\[NOAA Tech. Memo.\]. *NOAA-AFSC-339*.
<https://doi.org/10.7289/V5/TM-AFSC-339>

</div>

<div id="ref-2021NEBS2022" class="csl-entry">

Markowitz, E. H., Dawson, E. J., Charriere, N. E., Prohaska, B. K.,
Rohan, S. K., Stevenson, D. E., and Britt, L. L. (2022). *Results of the
2021 eastern and northern Bering Sea continental shelf bottom trawl
survey of groundfish and invertebrate fauna* \[NOAA Tech. Memo.\].
https://doi.org/<https://doi.org/10.25923/g1ny-y360>

</div>

<div id="ref-cb2021" class="csl-entry">

Resource Assessment, A. F. S. C. (U.S.)., and Division, C. E. (2021).
*Groundfish survey data codes and forms*.
<https://repository.library.noaa.gov/view/noaa/31570>

</div>

<div id="ref-GOA2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2018). *Data report: 2017 gulf of
alaska bottom trawl survey* \[NOAA Tech. Memo.\]. *NMFS-AFSC-374*.
<https://apps-afsc.fisheries.noaa.gov/Publications/AFSC-TM/NOAA-TM-AFSC-374.pdf>

</div>

<div id="ref-AI2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2020). *Data report: 2018 aleutian
islands bottom trawl survey* \[NOAA Tech. Memo.\]. *NMFS-AFSC-409*.
<https://repository.library.noaa.gov/view/noaa/26367>

</div>

</div>

## User resources

- [AFSC’s Resource Assessment and Conservation Engineering
  Division](https://www.fisheries.noaa.gov/about/resource-assessment-and-conservation-engineering-division).
- For more information about codes used in the tables, please refer to
  the [survey code
  books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual)
  (Resource Assessment and Division, 2021).
- Find [past
  reports](http://apps-afsc.fisheries.noaa.gov/RACE/surveys/cruise_results.htm)
  about these surveys.
- [GitHub
  repository](https://github.com/afsc-gap-products/gap_public_data).
- Learn more about other [Research Surveys conducted at
  AFSC](https://www.fisheries.noaa.gov/alaska/ecosystems/alaska-fish-research-surveys).

## Access constraints

There are no legal restrictions on access to the data. They reside in
the public domain and can be freely distributed.

**User Constraints:** Users must read and fully comprehend the metadata
prior to use. Data should not be used beyond the limits of the source
scale. Acknowledgement of AFSC Groundfish Assessment Program, as the
source from which these data were obtained, in any publications and/or
other representations of these data, is suggested.

**Address:** Alaska Fisheries Science Center (AFSC) National Oceanic and
Atmospheric Administration (NOAA)  
Resource Assessment and Conservation Engineering Division (RACE)  
Groundfish Assessment Program (GAP) 7600 Sand Point Way, N.E. bldg. 4  
Seattle, WA 98115 USA

**General questions and more specific data requests** can be sent to
<afsc.gap.metadata@noaa.gov> or submitted as an [issue on our GitHub
Organization](https://github.com/afsc-gap-products/data-requests). The
version of this data used for stock assessments can be found through the
Alaska Fisheries Information Network (AKFIN). For questions about the
eastern Bering Sea surveys, contact Duane Stevenson
(<Duane.Stevenson@noaa.gov>). For questions about the Gulf of Alaska or
Aleutian Islands surveys, contact Ned Laman (<Ned.Laman@noaa.gov>). For
questions specifically about crab data in any region, contact Mike
Litzow (<Mike.Litzow@noaa.gov>), the Shellfish Assessment Program lead.

For questions, comments, and concerns specifically about the [Fisheries
One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform, please contact us using the Comments page on the
[FOSS](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
webpage.

## Table short metadata

This dataset includes zero-filled (presence and absence) observations
and catch-per-unit-effort (CPUE) estimates for most identified species
at a standard set of stations in the Northern Bering Sea (NBS), Eastern
Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), and
Aleutian Islands (AI) Surveys conducted by the esource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) of the Alaska Fisheries Science Center (AFSC). There are no legal
restrictions on access to the data. The data from this dataset are
shared on the Fisheries One Stop Stop (FOSS) platform
(<https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO>:::).
The GitHub repository for the scripts that created this code can be
found at <https://github.com/afsc-gap-products/gap_public_data>. For
more information about codes used in the tables, please refer to the
survey code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).
These data were last updated January 08, 2023.

## Column-level metadata

| Column name from data | Descriptive Column Name | Units | Description |
|:----------------------|:------------------------|:------|:------------|
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |

# Access the data

While pulling data, please keep in mind that this is a very large file.
For reference:

    ## RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED: 
    ##   rows: 36308030
    ##   cols: 37
    ##   9.691 GB

## Access data interactively through the FOSS platform

Select, filter, and package this and other NOAA Fisheries data from the
[Fisheries One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform. This user-friendly portal is maintained through `Oracle APEX`.
A useful intro to using APIs in `R` can be found
[here](https://www.dataquest.io/blog/r-api-tutorial/).

### Connect to the API with R

``` r
 # install.packages(c("httr", "jsonlite"))
library("httr")
library("jsonlite")
 # link to the API
api_link <- "https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/"
```

### Select all data

``` r
res <- httr::GET(url = api_link)
 # res # Test connection
data <- jsonlite::fromJSON(base::rawToChar(res$content))
 # names(data)
knitr::kable(head(data$items, 3)) 
```

### Subset data

Here, as an example, we can subset the data for the 2018 Aleutian
Islands Bottom Trawl Survey.

``` r
res <- httr::GET(url = api_link, query = list(year = "2018", srvy = "AI")
data <- jsonlite::fromJSON(base::rawToChar(res$content))
x <- data$items
x <- x[,c("srvy", "year", "stratum", "station", "vessel_name", "latitude_dd", "longitude_dd",
          "species_code", "common_name", "scientific_name", "taxon_confidence",
          "cpue_kgha", "cpue_noha", "weight_kg", "count",
          "bottom_temperature_c", "surface_temperature_c", "depth_m")]
knitr::kable(head(x, 3))
```

## Access data via Oracle

If the user has access to the AFSC `Oracle` database, the user can use
`SQL developer` to view and pull the FOSS public data directly from the
`RACEBASE_FOSS` `Oracle` schema.

### Connect to Oracle from R

Many users will want to access the data from `Oracle` using `R`. The
user will need to install the `RODBC` `R` package and ask OFIS (IT)
connect `R` to `Oracle`. Then, use the following code in `R` to
establish a connection from `R` to `Oracle`:

Here, the user can write in their username and password directly into
the `RODBC` connect function. Never save usernames or passwords in
scripts that may be intentionally or unintentionally shared with others.

``` r
library("RODBC")
 # Define RODBC connection to ORACLE
channel<-odbcConnect(dsn = "AFSC",
                     uid = "USERS_USERNAME", # change
                     pwd = "USERS_PASSWORD", # change
                     believeNRows = FALSE)
odbcGetInfo(channel) # Execute the connection
```

Or have the script prompt the user for the connection info. Here,
pop-ups will appear on the screen asking for the username and password.

``` r
library("RODBC")
library("getPass")
 # Define RODBC connection to ORACLE
get.connected <- function(schema='AFSC'){(echo=FALSE)
  username <- getPass(msg = "Enter your ORACLE Username: ")
  password <- getPass(msg = "Enter your ORACLE Password: ")
  channel  <- RODBC::odbcConnect(paste(schema),paste(username),paste(password), 
                                 believeNRows=FALSE)
}
channel <- get.connected() # Execute the connection
```

### Select all data

Once connected, pull and save (if needed) the table into the `R`
environment.

``` r
 # pull table from oracle into R environment
a <- RODBC::sqlQuery(channel, "SELECT * FROM RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED")
 # Save table to local directory
write.csv(x = a, file = "RACEBASE_FOSS-FOSS_CPUE_ZEROFILLED.csv")
```

### Subset data

To pull a small subset of the data (especially since files like
`RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED` are so big), use a variation of the
following code. Here, we are pulling EBS Pacific cod from 2010 - 2021:

``` r
 # Pull data
a <- RODBC::sqlQuery(channel, "SELECT * FROM RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED 
WHERE SRVY = 'EBS' 
AND COMMON_NAME = 'Pacific cod' 
AND YEAR >= 2010 
AND YEAR < 2021")
 # Save table to local directory
write.csv(x = a, file = "RACEBASE_FOSS-FOSS_CPUE_ZEROFILLED-ebs_pcod_2010-2020.csv")
```

### Join catch and haul data

If this file is too large, you can join catch and haul data. Pull the
`RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH` and
`RACEBASE_FOSS.JOIN_FOSS_CPUE_HAUL` tables, which are much smaller, and
combine the table locally yourself.

The full join the JOIN_FOSS_CPUE_CATCH and JOIN_FOSS_CPUE_HAUL datasets
using HAULJOIN to create zero-filled (presence and absence) observations
and catch-per-unit-effort (CPUE) estimates for all identified species at
a standard set of stations in the Northern Bering Sea (NBS), Eastern
Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), and
Aleutian Islands (AI) Surveys conducted by the esource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) of the Alaska Fisheries Science Center (AFSC). There are no legal
restrictions on access to the data. The data from this dataset are
shared on the Fisheries One Stop Stop (FOSS) platform
(<https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO>:::).
The GitHub repository for the scripts that created this code can be
found at <https://github.com/afsc-gap-products/gap_public_data>. For
more information about codes used in the tables, please refer to the
survey code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).
These data were last updated January 08, 2023.

    ## RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH: 
    ##   rows: 36308030
    ##   cols: 13
    ##   2.455 GB

    ## RACEBASE_FOSS.JOIN_FOSS_CPUE_HAUL: 
    ##   rows: 31608
    ##   cols: 24
    ##   0.006 GB

# Suggestions and comments

If the data or metadata can be improved, please create a pull request,
[submit an issue to the GitHub
organization](https://github.com/afsc-gap-products/data-requests/issues),
[submit an issue to the code’s
repository](https://github.com/afsc-gap-products/gap_public_data/issues),
reach out the the survey team leads (listed above), or to [Fisheries One
Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform managers.

## R version metadata

This data was compiled using the below `R` environment and `R` packages:

``` r
sessionInfo()
```

    ## R version 4.2.2 (2022-10-31 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19044)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8   
    ## [3] LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                          
    ## [5] LC_TIME=English_United States.utf8    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] jsonlite_1.8.4 httr_1.4.4     knitr_1.41     badger_0.2.2   stringr_1.5.0  taxize_0.9.100
    ##  [7] janitor_2.1.0  here_1.0.1     rmarkdown_2.19 readr_2.1.3    magrittr_2.0.3 dplyr_1.0.10  
    ## [13] tidyr_1.2.1   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] bit64_4.0.5         vroom_1.6.0         foreach_1.5.2       bold_1.2.0         
    ##  [5] assertthat_0.2.1    askpass_1.1         highr_0.10          BiocManager_1.30.19
    ##  [9] rvcheck_0.2.1       yulab.utils_0.0.6   cellranger_1.1.0    yaml_2.3.6         
    ## [13] pillar_1.8.1        lattice_0.20-45     glue_1.6.2          uuid_1.1-0         
    ## [17] digest_0.6.31       RColorBrewer_1.1-3  snakecase_0.11.0    colorspace_2.0-3   
    ## [21] htmltools_0.5.4     plyr_1.8.8          pkgconfig_2.0.3     httpcode_0.3.0     
    ## [25] gitcreds_0.1.2      purrr_1.0.0         scales_1.2.1        tzdb_0.3.0         
    ## [29] openssl_2.0.5       timechange_0.1.1    tibble_3.1.8        generics_0.1.3     
    ## [33] ggplot2_3.4.0       usethis_2.1.6       ellipsis_0.3.2      withr_2.5.0        
    ## [37] credentials_1.3.2   cli_3.5.0           crayon_1.5.2        readxl_1.4.1       
    ## [41] evaluate_0.19       fs_1.5.2            fansi_1.0.3         nlme_3.1-161       
    ## [45] xml2_1.3.3          gh_1.3.1            tools_4.2.2         data.table_1.14.6  
    ## [49] hms_1.1.2           lifecycle_1.0.3     gert_1.9.2          munsell_0.5.0      
    ## [53] RODBC_1.3-20        compiler_4.2.2      rlang_1.0.6         grid_4.2.2         
    ## [57] conditionz_0.1.0    sys_3.4.1           iterators_1.0.14    rstudioapi_0.14    
    ## [61] gtable_0.3.1        codetools_0.2-18    DBI_1.1.3           reshape_0.8.9      
    ## [65] curl_4.3.3          readtext_0.81       R6_2.5.1            zoo_1.8-11         
    ## [69] lubridate_1.9.0     fastmap_1.1.0       bit_4.0.5           utf8_1.2.2         
    ## [73] rprojroot_2.0.3     dlstats_0.1.6       ape_5.6-2           stringi_1.7.8      
    ## [77] parallel_4.2.2      crul_1.3            Rcpp_1.0.9          vctrs_0.5.1        
    ## [81] tidyselect_1.2.0    xfun_0.36

## NOAA README

This repository is a scientific product and is not official
communication of the National Oceanic and Atmospheric Administration, or
the United States Department of Commerce. All NOAA GitHub project code
is provided on an ‘as is’ basis and the user assumes responsibility for
its use. Any claims against the Department of Commerce or Department of
Commerce bureaus stemming from the use of this GitHub project will be
governed by all applicable Federal law. Any reference to specific
commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.

## NOAA License

Software code created by U.S. Government employees is not subject to
copyright in the United States (17 U.S.C. §105). The United
States/Department of Commerce reserve all rights to seek and obtain
copyright protection in countries other than the United States for
Software authored in its entirety by the Department of Commerce. To this
end, the Department of Commerce hereby grants to Recipient a
royalty-free, nonexclusive license to use, copy, and create derivative
works of the Software outside of the United States.

<img src="https://raw.githubusercontent.com/nmfs-general-modeling-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png" alt="NOAA Fisheries" height="75"/>

[U.S. Department of Commerce](https://www.commerce.gov/) \| [National
Oceanographic and Atmospheric Administration](https://www.noaa.gov) \|
[NOAA Fisheries](https://www.fisheries.noaa.gov/)
