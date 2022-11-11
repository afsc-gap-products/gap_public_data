<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> Code is always in development

## This code is primarily maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[@EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
Bering Sea Survey Team Alaska Fisheries Science Center,  
National Marine Fisheries Service,  
National Oceanic and Atmospheric Administration,  
Seattle, WA 98195

# Cite this Data

NOAA Fisheries Alaska Fisheries Science Center. RACE Division Bottom
Trawl Survey Data Query, Available at: www.fisheries.noaa.gov/foss,
Accessed mm/dd/yyyy

These data were last ran and pushed to the AFSC oracle on November 10,
2022. This is not the date that these data were pulled into FOSS and the
FOSS dataset may be behind.

# Access the Data

## Access data interactively through the [Fisheries One Stop Shop (FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::) platform

Select, filter, and package this and other NOAA Fisheries data from the
[Fisheries One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform. This user-friendly portal is maintained through Oracle APEX.

## Access data via the API

A useful intro to using APIs in R can be found
[here](https://www.dataquest.io/blog/r-api-tutorial/).

### Obtain data by connecting to the API

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

| year | srvy | survey                               | survey_id | cruise | haul | stratum | station | vessel_name | vessel_id | date_time             | latitude_dd | longitude_dd | species_code | common_name         | scientific_name        | taxon_confidence | cpue_kgha | cpue_kgkm2 | cpue_kg1000km2 | cpue_noha | cpue_nokm2 | cpue_no1000km2 | weight_kg | count | bottom_temperature_c | surface_temperature_c | depth_m | distance_fished_km | net_width_m | net_height_m | area_swept_ha | duration_hr | tsn | ak_survey_id | links                                                                                   |
|-:|:-|:---|:-|:-|:-|:-|:-|:-|:-|:--|:-|:-|:-|:--|:--|:-|:-|:-|:-|:-|:-|:-|:-|:-|:--|:--|:-|:--|:-|:-|:-|:-|:-|-:|:----------|
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 68560        | Tanner crab         | Chionoecetes bairdi    | High             | 0.010185  | 1.018504   | NA             | 0.424377  | 42.437674  | 42437.674334   | 0.024     | 1     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            1 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/1> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 66031        | Alaskan pink shrimp | Pandalus eous          | Moderate         | 0.016975  | 1.697507   | NA             | 2.970637  | 297.06372  | 297063.720338  | 0.04      | 7     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            2 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/2> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 72500        | Oregon triton       | Fusitriton oregonensis | High             | 0.018673  | 1.867258   | NA             | 0.424377  | 42.437674  | 42437.674334   | 0.044     | 1     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            3 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/3> |

## Access data via Oracle (AFSC-only)

If you have access to the AFSC Oracle data base, you can pull the data
directly from the Oracle schema these data are pulled from for FOSS.

You will need to install the `RODBC` R package and have OFIS (IT)
connect R to Oracle. Once connected, you can use the following code in R
to connect to Oracle.

``` r
library("RODBC")

channel<-odbcConnect(dsn = "AFSC",
                     uid = "USERNAME", # change
                     pwd = "PASSWORD", #change
                     believeNRows = FALSE)

odbcGetInfo(channel)
```

Then, you can pull and save (if you need) the table into your R
environment.

``` r
locations <- c(
  "RACEBASE_FOSS.RACEBASE_PUBLIC_FOSS", # Presence-only data. This is a much smaller file than the zero-filled one
  "RACEBASE_FOSS.FOSS_ZEROFILLED", # Presence and absensece data. This is a huge file but with the minimal columns
  "RACEBASE_FOSS.RACEBASE_PUBLIC_FOSS_ZEROFILLED") # Presence and absensece data. This is a huge file but with all of the bells and whistels

# loop through each oracle table you want to pull
for (i in 1:length(locations)){
  print(locations[i])
  # pull table from oracle into R environment
  a <- RODBC::sqlQuery(channel, paste0("SELECT * FROM ", locations[i]))
  # Save table to local directory
  write.csv(x = a, 
            paste0(getwd(), "/",
                   gsub(pattern = '.', 
                        replacement = "", 
                        x = locations[i], 
                        fixed = TRUE, 
                        perl = TRUE),
                   ".csv"))
}
```

For reference:

    ## RACEBASE_FOSS.RACEBASE_PUBLIC_FOSS: 
    ## rows: 1038632
    ## cols: 37
    ## 0.319 GB
    ## 
    ## RACEBASE_FOSS.FOSS_ZEROFILLED: 
    ## rows: 36350712
    ## cols: 11
    ## 1.616 GB
    ## 
    ## RACEBASE_FOSS.RACEBASE_PUBLIC_FOSS_ZEROFILLED: 
    ## rows: 36440900
    ## cols: 37
    ## 4.514 GB

# Metadata

## Data Description

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

These data are all (presence and absence) observations from surveys
conducted on fishing vessels. These surveys monitor trends in
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

## Bottom Trawl Surveys and Regions

<img src="img/_grid_bs.png" alt="Eastern and Northern Bering Sea Shelf" align="right" width="250"/>
<img src="img/_grid_ai.png" alt="Aleutian Islands" align="right" width="300"/>

-   **Eastern Bering Sea Shelf (EBS)**
    -   Annual
    -   Fixed stations at center of 20 x 20 nm grid
-   **Northern Bering Sea (NBS)**
    -   Biennial/Annual
    -   Fixed stations at center of 20 x 20 nm grid
-   **Eastern Bering Sea Slope (BSS)**
    -   Intermittent (funding dependent)
    -   Modified Index-Stratified Random of Successful Stations Survey
        Design
-   **Aleutian Islands (AI)**
    -   Triennial (1990s)/Biennial since 2000 in even years
    -   Modified Index-Stratified Random of Successful Stations Survey
        Design
-   **Gulf of Alaska (GOA)**
    -   Triennial (1990s)/Biennial since 2001 in odd years
    -   Stratified Random Survey Design

## User Resources:

-   [AFSC’s Resource Assessment and Conservation Engineering
    Division](https://www.fisheries.noaa.gov/about/resource-assessment-and-conservation-engineering-division).
-   For more information about codes used in the tables, please refer to
    the [survey code
    books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).
-   Find [past
    reports](http://apps-afsc.fisheries.noaa.gov/RACE/surveys/cruise_results.htm)
    about these surveys.
-   [GitHub
    repository](https://github.com/afsc-gap-products/gap_public_data).
-   Learn more about other [Research Surveys conducted at
    AFSC](https://www.fisheries.noaa.gov/alaska/ecosystems/alaska-fish-research-surveys).

## Access Constraints:

There are no legal restrictions on access to the data. They reside in
public domain and can be freely distributed.

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

This dataset includes non-zero (presence) observations and
catch-per-unit-effort (CPUE) estimates for most identified species at a
standard set of stations in the Northern Bering Sea (NBS), Eastern
Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), and
Aleutian Islands (AI) Surveys conducted by the esource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) of the Alaska Fisheries Science Center (AFSC). There are no legal
restrictions on access to the data. The data from this dataset are
shared on the Fisheries One Stop Stop (FOSS) platform
(<https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO>:::).
The GitHub repository for the scripts that created this code can be
found at <https://github.com/afsc-gap-products/gap_public_dataThese>
data were last updated 2022-11-10 18:37:20.

## Column-level metadata

| Column name from data | Descriptive Column Name                                  | Units                                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|:--|:----|:---|:------------------------------------------------------------|
| year                  | Year                                                     | numeric                                         | Year the survey was conducted in.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| srvy                  | Survey                                                   | Abbreviated text                                | Abbreviated survey names. The column ‘srvy’ is associated with the ‘survey’ and ‘survey_id’ columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| survey                | Survey Name                                              | text                                            | Name and description of survey. The column ‘survey’ is associated with the ‘srvy’ and ‘survey_id’ columns.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| survey_id             | Survey ID                                                | ID code                                         | This number uniquely identifies a survey. Name and description of survey. The column ‘survey_id’ is associated with the ‘srvy’ and ‘survey’ columns. For a complete list of surveys, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| cruise                | Cruise ID                                                | ID code                                         | This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| haul                  | Haul Number                                              | ID code                                         | This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| hauljoin              | hauljoin                                                 | ID Code                                         | This is a unique numeric identifier assigned to each (vessel, cruise, and haul) combination.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| stratum               | Stratum ID                                               | ID Code                                         | RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| station               | Station ID                                               | ID code                                         | Alpha-numeric designation for the station established in the design of a survey.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| vessel_name           | Vessel Name                                              | text                                            | Name of the vessel used to collect data for that haul. The column ‘vessel_name’ is associated with the ‘vessel_id’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| vessel_id             | Vessel ID                                                | ID Code                                         | ID number of the vessel used to collect data for that haul. The column ‘vessel_id’ is associated with the ‘vessel_name’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| date_time             | Date and Time of Haul                                    | MM/DD/YYYY HH::MM                               | The date (MM/DD/YYYY) and time (HH:MM) of the beginning of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| latitude_dd_start     | Start Latitude (decimal degrees)                         | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| longitude_dd_start    | Start Longitude (decimal degrees)                        | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| latitude_dd_end       | End Latitude (decimal degrees)                           | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| longitude_dd_end      | End Longitude (decimal degrees)                          | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| species_code          | Taxon Code                                               | ID code                                         | The species code of the organism associated with the ‘common_name’ and ‘scientific_name’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| itis                  | ITIS Taxonomic Serial Number                             | ID code                                         | Species code as identified in the Integrated Taxonomic Information System (<https://itis.gov/>). Codes were last updated 2022-06-09 21:09:42.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| worms                 | World Register of Marine Species Taxonomic Serial Number | ID code                                         | Species code as identified in the World Register of Marine Species (WoRMS) (<https://www.marinespecies.org/>). Codes were last updated 2022-06-09 21:09:42.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| common_name           | Taxon Common Name                                        | text                                            | The common name of the marine organism associated with the ‘scientific_name’ and ‘species_code’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| scientific_name       | Taxon Scientific Name                                    | text                                            | The scientific name of the organism associated with the ‘common_name’ and ‘species_code’ columns. For a complete taxon list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| taxon_confidence      | Taxon Confidence Rating                                  | rating                                          | Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow: **‘High’**: High confidence and consistency. Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable. **‘Moderate’**: Moderate confidence. Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently. **‘Low’**: Low confidence. Taxonomy is incompletely known, or reliable field identification characteristics are unknown. Documentation: [Species identification confidence in the eastern Bering Sea shelf survey (1982-2008)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2009-04.pdf), [Species identification confidence in the eastern Bering Sea slope survey (1976-2010)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-05.pdf), and [Species identification confidence in the Gulf of Alaska and Aleutian Islands surveys (1980-2011)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-01.pdf). |
| cpue_kgha             | Weight CPUE (kg/ha)                                      | kilograms/hectare                               | Relative Density. Catch weight (kilograms) divided by area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| cpue_kgkm2            | Weight CPUE (kg/km<sup>2</sup>)                          | kilograms/kilometers<sup>2</sup>                | Relative Density. Catch weight (kilograms) divided by area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| cpue_noha             | Number CPUE (no./ha)                                     | count/hectare                                   | Relative Abundance. Catch number (in number of organisms) per area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| cpue_nokm2            | Number CPUE (no./km<sup>2</sup>)                         | count/kilometers<sup>2</sup>                    | Relative Abundance. Catch number (in number of organisms) per area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| weight_kg             | Taxon Weight (kg)                                        | kilograms, thousandth resolution                | Weight (thousandths of a kilogram) of individuals in a haul by taxon.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| count                 | Taxon Count                                              | count, whole number resolution                  | Total number of individuals caught in haul by taxon, represented in whole numbers.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| bottom_temperature_c  | Bottom Temperature (Degrees Celsius)                     | degrees Celsius, tenths of a degree resolution  | Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| surface_temperature_c | Surface Temperature (Degrees Celsius)                    | degrees Celsius, tenths of a degree resolution  | Surface temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| depth_m               | Depth (m)                                                | meters, tenths of a meter resolution            | Bottom depth (tenths of a meter).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| distance_fished_km    | Distance Fished (km)                                     | kilometers, thousandths of kilometer resolution | Distance the net fished (thousandths of kilometers).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| net_width_m           | Net Width (m)                                            | meters                                          | Measured or estimated distance (meters) between wingtips of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| net_height_m          | Net Height (m)                                           | meters                                          | Measured or estimated distance (meters) between footrope and headrope of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| area_swept_ha         | Area Swept (ha)                                          | hectares                                        | The area the net covered while the net was fishing (hectares), defined as the distance fished times the net width.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| duration_hr           | Tow Duration (decimal hr)                                | decimal hours                                   | This is the elapsed time between start and end of a haul (decimal hours).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| performance           | Haul Performance Code (rating)                           | rating                                          | This denotes what, if any, issues arose during the haul. For more information, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

# Suggestions and Comments

If you feel that the data or metadata can be improved, please create a
pull request, [submit an issue to the GitHub
organization](https://github.com/afsc-gap-products/data-requests/issues),
[submit an issue to the code’s
repository](https://github.com/afsc-gap-products/gap_public_data/issues),
reach out the the survey team leads (listed above), or to [Fisheries One
Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform managers.

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
