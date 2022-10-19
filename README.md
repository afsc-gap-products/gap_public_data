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
# base::rawToChar(res$content) # Test connection
data <- jsonlite::fromJSON(base::rawToChar(res$content))
# names(data)
knitr::kable(head(data$items, 3)) 
```

| year | srvy | survey                               | survey_id | cruise | haul | stratum | station | vessel_name | vessel_id | date_time             | latitude_dd | longitude_dd | species_code | common_name         | scientific_name        | taxon_confidence | cpue_kgha | cpue_kgkm2 | cpue_kg1000km2 | cpue_noha | cpue_nokm2 | cpue_no1000km2 | weight_kg | count | bottom_temperature_c | surface_temperature_c | depth_m | distance_fished_km | net_width_m | net_height_m | area_swept_ha | duration_hr | tsn | ak_survey_id | links                                                                                   |
|-:|:-|:---|:-|:-|:-|:-|:-|:-|:-|:--|:-|:-|:-|:--|:--|:-|:-|:-|:-|:-|:-|:-|:-|:-|:--|:--|:-|:--|:-|:-|:-|:-|:-|-:|:----------|
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 68560        | Tanner crab         | Chionoecetes bairdi    | High             | 0.010185  | 1.018504   | NA             | 0.424377  | 42.437674  | 42437.674334   | 0.024     | 1     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            1 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/1> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 66031        | Alaskan pink shrimp | Pandalus eous          | Moderate         | 0.016975  | 1.697507   | NA             | 2.970637  | 297.06372  | 297063.720338  | 0.04      | 7     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            2 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/2> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 52        | 200201 | 2    | 722     | 303-64  | Vesteraalen | 94        | 5/17/2002 10:20:08 AM | 53.79037    | -167.2581    | 72500        | Oregon triton       | Fusitriton oregonensis | High             | 0.018673  | 1.867258   | NA             | 0.424377  | 42.437674  | 42437.674334   | 0.044     | 1     | 4.1                  | 5                     | 164     | 1.488              | 15.836      | 7.159        | 2.3563968     | 0.27        | NA  |            3 | self , <https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/3> |

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
data were last updated 2022-10-18 16:33:36.

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
| NA                    | NA                      | NA    | NA          |
| NA                    | NA                      | NA    | NA          |

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
