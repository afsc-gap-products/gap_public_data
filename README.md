<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> Code is always in development

## This code is primarily maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[@EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
Bering Sea Groundfish Survey Team Alaska Fisheries Science Center,  
National Marine Fisheries Service,  
National Oceanic and Atmospheric Administration,  
Seattle, WA 98195

## Table of Contents

> -   [*Cite this Data*](#cite-this-data)
> -   [*Metadata*](#metadata)
> -   [*Data Description*](#data-description)
> -   [*Bottom Trawl Surveys and
>     Regions*](#bottom-trawl-surveys-and-regions)
> -   [*User Resources*](#user-resources)
> -   [*Access Constraints*](#access-constraints)
> -   [*Table short metadata*](#table-short-metadata)
> -   [*Column-level metadata*](#column-level-metadata)
> -   [*Access the Data*](#access-the-data)
> -   [*Access data interactively through the FOSS
>     platform*](#access-data-interactively-through-the-foss-platform)
>     -   [*Connect to the API with R*](#connect-to-the-api-with-r)
>     -   [*Select all data*](#select-all-data)
>     -   [*Subset data*](#subset-data)
> -   [*Access data via Oracle*](#access-data-via-oracle)
>     -   [*Connect to Oracle from R*](#connect-to-oracle-from-r)
>     -   [*Select all data*](#select-all-data)
>     -   [*Subset data*](#subset-data)
> -   [*Suggestions and Comments*](#suggestions-and-comments)
> -   [*R Version Metadata*](#r-version-metadata)
> -   [*NOAA README*](#noaa-readme)
> -   [*NOAA License*](#noaa-license)

# Cite this Data

> NOAA Fisheries Alaska Fisheries Science Center. RACE Division Bottom
> Trawl Survey Data Query, Available at: www.fisheries.noaa.gov/foss,
> Accessed mm/dd/yyyy

These data were last ran and pushed to the AFSC oracle on **November 30,
2022**. *This is not the date that these data were pulled into FOSS and
the FOSS dataset may be behind.*

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

These data are non-zero (presence) observations from surveys conducted
on fishing vessels. These surveys monitor trends in distribution and
abundance of groundfish, crab, and bottom-dwelling species in Alaska’s
marine ecosystems. These data include estimates of catch-per-unit-effort
(CPUE) for most identified species at a standard set of stations. Some
survey data are excluded, such as non-standard stations, surveys
completed in earlier years using different/non-standard gear, and
special tows and non-standard data collections.

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

\<\>

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

## User Resources

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

## Access Constraints

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
found at <https://github.com/afsc-gap-products/gap_public_dataThese>
data were last updated NA.

## Column-level metadata

| Column name from data | Descriptive Column Name                                  | Units                                           | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|:----------------------|:---------------------------------------------------------|:------------------------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| YEAR                  | Year                                                     | numeric                                         | Year the survey was conducted in.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| SRVY                  | Survey                                                   | Abbreviated text                                | Abbreviated survey names. The column ‘srvy’ is associated with the ‘survey’ and ‘survey_id’ columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| SURVEY                | Survey Name                                              | text                                            | Name and description of survey. The column ‘survey’ is associated with the ‘srvy’ and ‘survey_id’ columns.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| SURVEY_ID             | Survey ID                                                | ID code                                         | This number uniquely identifies a survey. Name and description of survey. The column ‘survey_id’ is associated with the ‘srvy’ and ‘survey’ columns. For a complete list of surveys, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| CRUISE                | Cruise ID                                                | ID code                                         | This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| HAUL                  | Haul Number                                              | ID code                                         | This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| HAULJOIN              | hauljoin                                                 | ID Code                                         | This is a unique numeric identifier assigned to each (vessel, cruise, and haul) combination.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| STRATUM               | Stratum ID                                               | ID Code                                         | RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| STATION               | Station ID                                               | ID code                                         | Alpha-numeric designation for the station established in the design of a survey.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| VESSEL_NAME           | Vessel Name                                              | text                                            | Name of the vessel used to collect data for that haul. The column ‘vessel_name’ is associated with the ‘vessel_id’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| VESSEL_ID             | Vessel ID                                                | ID Code                                         | ID number of the vessel used to collect data for that haul. The column ‘vessel_id’ is associated with the ‘vessel_name’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| DATE_TIME             | Date and Time of Haul                                    | MM/DD/YYYY HH::MM                               | The date (MM/DD/YYYY) and time (HH:MM) of the beginning of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| LATITUDE_DD_START     | Start Latitude (decimal degrees)                         | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| LONGITUDE_DD_START    | Start Longitude (decimal degrees)                        | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| LATITUDE_DD_END       | End Latitude (decimal degrees)                           | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| LONGITUDE_DD_END      | End Longitude (decimal degrees)                          | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| SPECIES_CODE          | Taxon Code                                               | ID code                                         | The species code of the organism associated with the ‘common_name’ and ‘scientific_name’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ITIS                  | ITIS Taxonomic Serial Number                             | ID code                                         | Species code as identified in the Integrated Taxonomic Information System (<https://itis.gov/>). Codes were last updated 2022-06-09 21:09:42.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| WORMS                 | World Register of Marine Species Taxonomic Serial Number | ID code                                         | Species code as identified in the World Register of Marine Species (WoRMS) (<https://www.marinespecies.org/>). Codes were last updated 2022-06-09 21:09:42.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| COMMON_NAME           | Taxon Common Name                                        | text                                            | The common name of the marine organism associated with the ‘scientific_name’ and ‘species_code’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| SCIENTIFIC_NAME       | Taxon Scientific Name                                    | text                                            | The scientific name of the organism associated with the ‘common_name’ and ‘species_code’ columns. For a complete taxon list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| TAXON_CONFIDENCE      | Taxon Confidence Rating                                  | rating                                          | Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow: **‘High’**: High confidence and consistency. Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable. **‘Moderate’**: Moderate confidence. Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently. **‘Low’**: Low confidence. Taxonomy is incompletely known, or reliable field identification characteristics are unknown. Documentation: [Species identification confidence in the eastern Bering Sea shelf survey (1982-2008)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2009-04.pdf), [Species identification confidence in the eastern Bering Sea slope survey (1976-2010)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-05.pdf), and [Species identification confidence in the Gulf of Alaska and Aleutian Islands surveys (1980-2011)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-01.pdf). |
| CPUE_KGHA             | Weight CPUE (kg/ha)                                      | kilograms/hectare                               | Relative Density. Catch weight (kilograms) divided by area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| CPUE_KGKM2            | Weight CPUE (kg/km<sup>2</sup>)                          | kilograms/kilometers<sup>2</sup>                | Relative Density. Catch weight (kilograms) divided by area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| CPUE_NOHA             | Number CPUE (no./ha)                                     | count/hectare                                   | Relative Abundance. Catch number (in number of organisms) per area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| CPUE_NOKM2            | Number CPUE (no./km<sup>2</sup>)                         | count/kilometers<sup>2</sup>                    | Relative Abundance. Catch number (in number of organisms) per area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| WEIGHT_KG             | Taxon Weight (kg)                                        | kilograms, thousandth resolution                | Weight (thousandths of a kilogram) of individuals in a haul by taxon.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| COUNT                 | Taxon Count                                              | count, whole number resolution                  | Total number of individuals caught in haul by taxon, represented in whole numbers.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| BOTTOM_TEMPERATURE_C  | Bottom Temperature (Degrees Celsius)                     | degrees Celsius, tenths of a degree resolution  | Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| SURFACE_TEMPERATURE_C | Surface Temperature (Degrees Celsius)                    | degrees Celsius, tenths of a degree resolution  | Surface temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| DEPTH_M               | Depth (m)                                                | meters, tenths of a meter resolution            | Bottom depth (tenths of a meter).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DISTANCE_FISHED_KM    | Distance Fished (km)                                     | kilometers, thousandths of kilometer resolution | Distance the net fished (thousandths of kilometers).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| NET_WIDTH_M           | Net Width (m)                                            | meters                                          | Measured or estimated distance (meters) between wingtips of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| NET_HEIGHT_M          | Net Height (m)                                           | meters                                          | Measured or estimated distance (meters) between footrope and headrope of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| AREA_SWEPT_HA         | Area Swept (ha)                                          | hectares                                        | The area the net covered while the net was fishing (hectares), defined as the distance fished times the net width.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| DURATION_HR           | Tow Duration (decimal hr)                                | decimal hours                                   | This is the elapsed time between start and end of a haul (decimal hours).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| PERFORMANCE           | Haul Performance Code (rating)                           | rating                                          | This denotes what, if any, issues arose during the haul. For more information, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

# Access the Data

While pulling data, please keep in mind that this is a very large file.
For reference:

    ## RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED: 
    ##   rows: 36440900
    ##   cols: 37
    ##   4.514 GB

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
res <- httr::GET(url = api_link, query = list(year = "2018")) # year = 2018, srvy = "EBS"
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

# Suggestions and Comments

If the data or metadata can be improved, please create a pull request,
[submit an issue to the GitHub
organization](https://github.com/afsc-gap-products/data-requests/issues),
[submit an issue to the code’s
repository](https://github.com/afsc-gap-products/gap_public_data/issues),
reach out the the survey team leads (listed above), or to [Fisheries One
Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13045102793007:Mail:NO:::)
platform managers.

## R Version Metadata

This data was compiled using the below `R` environment and `R` packages:

``` r
sessionInfo()
```

    ## R version 4.2.1 (2022-06-23 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19044)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8    LC_MONETARY=English_United States.utf8 LC_NUMERIC=C                           LC_TIME=English_United States.utf8    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] stringi_1.7.8  getPass_0.2-2  jsonlite_1.8.3 httr_1.4.4     knitr_1.41     badger_0.2.2   RODBC_1.3-19   stringr_1.4.1  taxize_0.9.100 janitor_2.1.0  here_1.0.1     rmarkdown_2.18 readr_2.1.3    magrittr_2.0.3 dplyr_1.0.10   tidyr_1.2.1   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] nlme_3.1-157        fs_1.5.2            usethis_2.1.6       bold_1.2.0          lubridate_1.9.0     bit64_4.0.5         RColorBrewer_1.1-3  rprojroot_2.0.3     worrms_0.4.2        gh_1.3.1            tools_4.2.1         utf8_1.2.2          R6_2.5.1            DBI_1.1.3           colorspace_2.0-3    withr_2.5.0         tidyselect_1.2.0   
    ## [18] bit_4.0.5           curl_4.3.3          compiler_4.2.1      ritis_1.0.0         cli_3.4.1           xml2_1.3.3          triebeard_0.3.0     scales_1.2.1        askpass_1.1         yulab.utils_0.0.5   digest_0.6.30       solrium_1.2.0       pkgconfig_2.0.3     htmltools_0.5.3     highr_0.9           fastmap_1.1.0       rlang_1.0.6        
    ## [35] readxl_1.4.1        rstudioapi_0.14     httpcode_0.3.0      generics_0.1.3      zoo_1.8-11          vroom_1.6.0         credentials_1.3.2   Rcpp_1.0.9          munsell_0.5.0       fansi_1.0.3         ape_5.6-2           lifecycle_1.0.3     yaml_2.3.6          snakecase_0.11.0    plyr_1.8.8          grid_4.2.1          parallel_4.2.1     
    ## [52] crayon_1.5.2        lattice_0.20-45     conditionz_0.1.0    hms_1.1.2           sys_3.4.1           pillar_1.8.1        uuid_1.1-0          codetools_0.2-18    readtext_0.81       crul_1.3            glue_1.6.2          evaluate_0.18       data.table_1.14.6   BiocManager_1.30.19 vctrs_0.5.1         tzdb_0.3.0          urltools_1.7.3     
    ## [69] foreach_1.5.2       cellranger_1.1.0    openssl_2.0.4       gtable_0.3.1        purrr_0.3.5         reshape_0.8.9       assertthat_0.2.1    ggplot2_3.4.0       xfun_0.35           gitcreds_0.1.2      gert_1.9.1          dlstats_0.1.5       tibble_3.1.8        iterators_1.0.14    rvcheck_0.2.1       timechange_0.1.1    ellipsis_0.3.2

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
