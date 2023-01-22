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

Use the below bibtext
[citation](https://github.com/afsc-gap-products/gap_public_data/blob/main/CITATION.bib),
as cited in our group’s [citation
repository](https://github.com/afsc-gap-products/citations/blob/main/cite/bibliography.bib)
for citing the data from this dataportal (NOAA Fisheries Alaska
Fisheries Science Center, 2023). Add “note = {Accessed: mm/dd/yyyy}” to
append the day this data was accessed.

    ## @misc{FOSSAFSCData,
    ##    author = {{NOAA Fisheries Alaska Fisheries Science Center}},
    ##    year = {2023}, 
    ##    title = {Fisheries One Stop Shop Public Data: RACE Division Bottom Trawl Survey Data Query},
    ##    howpublished = {https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243:::::},
    ##    publisher = {{U.S. Dep. Commer.}},
    ##    copyright = {Public Domain} 
    ## }

The code is in development. Refer to
[releases](https://github.com/afsc-gap-products/gap_public_data/releases)
for finalized products. These data were last ran and pushed to the AFSC
oracle on **January 21, 2023**. *This is not the date that these data
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
<https://doi.org/10.25923/g1ny-y360>

</div>

<div id="ref-FOSSAFSCData" class="csl-entry">

NOAA Fisheries Alaska Fisheries Science Center. (2023). *Fisheries one
stop shop public data: RACE division bottom trawl survey data query*.
https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243::::: U.S.
Dep. Commer.

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
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243:::::)
platform, please contact us using the Comments page on the
[FOSS](https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243:::::)
webpage.

## Table short metadata

This dataset includes zero-filled (presence and absence) observations
and catch-per-unit-effort (CPUE) estimates for most identified species
at a standard set of stations in the northern Bering Sea (NBS), eastern
Bering Sea (EBS), Gulf of Alaska (GOA), Aleutian Islands (AI), Bering
Sea Slope (BSS) Surveys conducted by the Resource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) oThere are no legal restrictions on access to the data.The data
from this dataset are shared on the Fisheries One Stop Stop (FOSS)
platform
(<https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243>:::::).The
GitHub repository for the scripts that created this code can be found at
<https://github.com/afsc-gap-products/gap_public_data.For> more
information about codes used in the tables, please refer to the survey
code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).These
data were last updated January 21, 2023.

## Column-level metadata

| Column name from data | Descriptive Column Name | Units                  | Description                                              | NA                                              | NA                                                                                                                                                                                                                                                                  |
|----------------------:|------------------------:|:-----------------------|:---------------------------------------------------------|:------------------------------------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|                     1 |                       1 | year                   | Year                                                     | numeric                                         | Year the survey was conducted in.                                                                                                                                                                                                                                   |
|                     2 |                       2 | srvy                   | Survey                                                   | Abbreviated text                                | Abbreviated survey names. The column ‘srvy’ is associated with the ‘survey’ and ‘survey_id’ columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI).                                 |
|                     3 |                       3 | survey                 | Survey Name                                              | text                                            | Name and description of survey. The column ‘survey’ is associated with the ‘srvy’ and ‘survey_id’ columns.                                                                                                                                                          |
|                     4 |                       4 | survey_id              | Survey ID                                                | ID code                                         | This number uniquely identifies a survey. Name and description of survey. The column ‘survey_id’ is associated with the ‘srvy’ and ‘survey’ columns. For a complete list of surveys, review the \[code books\](<https://www.fisheries.noaa.gov/resource/document/g> |
|                     5 |                       5 | cruise                 | Cruise ID                                                | ID code                                         | This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.).                           |
|                     6 |                       6 | haul                   | Haul Number                                              | ID code                                         | This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence.                                                                                                                           |
|                     7 |                       7 | hauljoin               | hauljoin                                                 | ID Code                                         | This is a unique numeric identifier assigned to each (vessel, cruise, and haul) combination.                                                                                                                                                                        |
|                     8 |                       8 | stratum                | Stratum ID                                               | ID Code                                         | RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows.                            |
|                     9 |                       9 | station                | Station ID                                               | ID code                                         | Alpha-numeric designation for the station established in the design of a survey.                                                                                                                                                                                    |
|                    10 |                      10 | vessel_id              | Vessel ID                                                | ID Code                                         | ID number of the vessel used to collect data for that haul. The column ‘vessel_id’ is associated with the ‘vessel_name’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes,     |
|                    11 |                      11 | vessel_name            | Vessel Name                                              | text                                            | Name of the vessel used to collect data for that haul. The column ‘vessel_name’ is associated with the ‘vessel_id’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, revi     |
|                    12 |                      12 | date_time              | Date and Time of Haul                                    | MM/DD/YYYY HH::MM                               | The date (MM/DD/YYYY) and time (HH:MM) of the beginning of the haul.                                                                                                                                                                                                |
|                    13 |                      13 | longitude_dd_start     | Start Longitude (decimal degrees)                        | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                    |
|                    14 |                      14 | latitude_dd_start      | Start Latitude (decimal degrees)                         | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                     |
|                    15 |                      15 | longitude_dd_end       | End Longitude (decimal degrees)                          | decimal degrees, 1e-05 resolution               | Longitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                      |
|                    16 |                      16 | latitude_dd_end        | End Latitude (decimal degrees)                           | decimal degrees, 1e-05 resolution               | Latitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                       |
|                    17 |                      17 | species_code           | Taxon Code                                               | ID code                                         | The species code of the organism associated with the ‘common_name’ and ‘scientific_name’ columns. For a complete species list, review the \[code books\](<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-ma> |
|                    18 |                      18 | common_name            | Taxon Common Name                                        | text                                            | The common name of the marine organism associated with the ‘scientific_name’ and ‘species_code’ columns. For a complete species list, review the \[code books\](<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-c> |
|                    19 |                      19 | scientific_name        | Taxon Scientific Name                                    | text                                            | The scientific name of the organism associated with the ‘common_name’ and ‘species_code’ columns. For a complete taxon list, review the \[code books\](<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manu> |
|                    20 |                      20 | taxon_confidence       | Taxon Confidence Rating                                  | rating                                          | Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow:     |
|                    21 |                      21 | taxon_confidence0      | Taxon Confidence Rating                                  | numeric rating                                  | Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow:     |
|                    22 |                      22 | cpue_kgha              | Weight CPUE (kg/ha)                                      | kilograms/hectare                               | Relative Density. Catch weight (kilograms) divided by area (hectares) swept by the net.                                                                                                                                                                             |
|                    23 |                      23 | cpue_kgkm2             | Weight CPUE (kg/km<sup>2</sup>)                          | kilograms/kilometers<sup>2</sup>                | Relative Density. Catch weight (kilograms) divided by area (squared kilometers) swept by the net.                                                                                                                                                                   |
|                    24 |                      24 | cpue_noha              | Number CPUE (no./ha)                                     | count/hectare                                   | Relative Abundance. Catch number (in number of organisms) per area (hectares) swept by the net.                                                                                                                                                                     |
|                    25 |                      25 | cpue_nokm2             | Number CPUE (no./km<sup>2</sup>)                         | count/kilometers<sup>2</sup>                    | Relative Abundance. Catch number (in number of organisms) per area (squared kilometers) swept by the net.                                                                                                                                                           |
|                    26 |                      26 | weight_kg              | Taxon Weight (kg)                                        | kilograms, thousandth resolution                | Weight (thousandths of a kilogram) of individuals in a haul by taxon.                                                                                                                                                                                               |
|                    27 |                      27 | count                  | Taxon Count                                              | count, whole number resolution                  | Total number of individuals caught in haul by taxon, represented in whole numbers.                                                                                                                                                                                  |
|                    28 |                      28 | bottom_temperature_c   | Bottom Temperature (Degrees Celsius)                     | degrees Celsius, tenths of a degree resolution  | Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                            |
|                    29 |                      29 | surface_temperature_c  | Surface Temperature (Degrees Celsius)                    | degrees Celsius, tenths of a degree resolution  | Surface temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                           |
|                    30 |                      30 | bottom_temperature_c   | Bottom Temperature (Degrees Celsius)                     | degrees Celsius, tenths of a degree resolution  | Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                            |
|                    31 |                      31 | depth_m                | Depth (m)                                                | meters, tenths of a meter resolution            | Bottom depth (tenths of a meter).                                                                                                                                                                                                                                   |
|                    32 |                      32 | distance_fished_km     | Distance Fished (km)                                     | kilometers, thousandths of kilometer resolution | Distance the net fished (thousandths of kilometers).                                                                                                                                                                                                                |
|                    33 |                      33 | net_width_m            | Net Width (m)                                            | meters                                          | Measured or estimated distance (meters) between wingtips of the trawl.                                                                                                                                                                                              |
|                    34 |                      34 | net_height_m           | Net Height (m)                                           | meters                                          | Measured or estimated distance (meters) between footrope and headrope of the trawl.                                                                                                                                                                                 |
|                    35 |                      35 | area_swept_ha          | Area Swept (ha)                                          | hectares                                        | The area the net covered while the net was fishing (hectares), defined as the distance fished times the net width.                                                                                                                                                  |
|                    36 |                      36 | duration_hr            | Tow Duration (decimal hr)                                | decimal hours                                   | This is the elapsed time between start and end of a haul (decimal hours).                                                                                                                                                                                           |
|                    37 |                      37 | performance            | Haul Performance Code (rating)                           | rating                                          | This denotes what, if any, issues arose during the haul. For more information, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                               |
|                    38 |                      38 | itis                   | ITIS Taxonomic Serial Number                             | ID code                                         | Species code as identified in the Integrated Taxonomic Information System (<https://itis.gov/>). Codes were last updated NA.                                                                                                                                        |
|                    39 |                      39 | worms                  | World Register of Marine Species Taxonomic Serial Number | ID code                                         | Species code as identified in the World Register of Marine Species (WoRMS) (<https://www.marinespecies.org/>). Codes were last updated NA.                                                                                                                          |
|                    40 |                      40 | metadata_colname       | Column name                                              | text                                            | Name of the column in a table                                                                                                                                                                                                                                       |
|                    41 |                      41 | metadata_colname_long  | Column name spelled out                                  | text                                            | Long name for the column                                                                                                                                                                                                                                            |
|                    42 |                      42 | metadata_units         | Units                                                    | text                                            | units the column is in                                                                                                                                                                                                                                              |
|                    43 |                      43 | metadata_colname_desc  | column description                                       | text                                            | Descritpion of the column                                                                                                                                                                                                                                           |
|                    44 |                      44 | metadata_sentence_type | Sentence type                                            | text                                            | Type of sentence to have in table metadata                                                                                                                                                                                                                          |
|                    45 |                      45 | metadata_sentence      | Sentence                                                 | text                                            | Table metadata sentence                                                                                                                                                                                                                                             |
|                    46 |                      46 | dummy                  | dummy                                                    | dummy                                           | dummy                                                                                                                                                                                                                                                               |

# Access the data

While pulling data, please keep in mind that this is a very large file.
For reference:

    ## RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED: 
    ##   rows: 36317744
    ##   cols: 37
    ##   9.694 GB

## Access data interactively through the FOSS platform

Select, filter, and package this and other NOAA Fisheries data from the
[Fisheries One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243:::::)
platform. This user-friendly portal is maintained through `Oracle APEX`.
A useful intro to using APIs in `R` can be found
[here](https://www.dataquest.io/blog/r-api-tutorial/).

### Connect to the API with R

``` r
 # install.packages(c("httr", "jsonlite"))
library("httr")
library("jsonlite")
 # link to the API
api_link <- "https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/"
```

### Select all data

``` r
res <- httr::GET(url = api_link)
 # res # Test connection
data <- jsonlite::fromJSON(base::rawToChar(res$content))
 # names(data)
knitr::kable(head(data$items, 3)) 
```

| year | srvy | survey                               | survey_id | cruise       | haul     | stratum   | station | vessel_name | vessel_id | date_time           | latitude_dd             | longitude_dd             | species_code | common_name       | scientific_name   | taxon_confidence | cpue_kgha               | cpue_kgkm2              | cpue_kg1000km2          | cpue_noha               | cpue_nokm2              | cpue_no1000km2          | weight_kg               | count    | bottom_temperature_c    | surface_temperature_c   | depth_m   | distance_fished_km      | net_width_m             | net_height_m | area_swept_ha           | duration_hr             |    tsn | ak_survey_id | links                                                                              |
|-----:|:-----|:-------------------------------------|:----------|:-------------|:---------|:----------|:--------|:------------|:----------|:--------------------|:------------------------|:-------------------------|:-------------|:------------------|:------------------|:-----------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:---------|:------------------------|:------------------------|:----------|:------------------------|:------------------------|:-------------|:------------------------|:------------------------|-------:|-------------:|:-----------------------------------------------------------------------------------|
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 6.0E+000 | 7.22E+002 | 307-63  | Vesteraalen | 9.4E+001  | 05/17/2002 18:56:58 | 5.3737209999999997E+001 | -1.6701570000000001E+002 | 9.502E+004   | feathery bryozoan | Eucratea loricata | Low              | 1.7493999999999999E-002 | 1.7494449999999999E+000 | 1.7494451079999999E+003 | NA                      | NA                      | NA                      | 4.3999999999999997E-002 | 0        | 4.0999999999999996E+000 | 5.2999999999999998E+000 | 1.87E+002 | 1.5609999999999999E+000 | 1.6111999999999998E+001 | 7.25E+000    | 2.5150831999999994E+000 | 2.8000000000000003E-001 | 155809 |       878821 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878821> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 6.0E+000 | 7.22E+002 | 307-63  | Vesteraalen | 9.4E+001  | 05/17/2002 18:56:58 | 5.3737209999999997E+001 | -1.6701570000000001E+002 | 7.9E+004     | squid unid.       | Decapodiformes    | High             | 2.2266000000000001E-002 | 2.2265670000000002E+000 | 2.2265665009999998E+003 | 3.180809E+000           | 3.1808092900000003E+002 | 3.1808092869500001E+005 | 5.6000000000000001E-002 | 8.0E+000 | 4.0999999999999996E+000 | 5.2999999999999998E+000 | 1.87E+002 | 1.5609999999999999E+000 | 1.6111999999999998E+001 | 7.25E+000    | 2.5150831999999994E+000 | 2.8000000000000003E-001 |     NA |       878822 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878822> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 6.0E+000 | 7.22E+002 | 307-63  | Vesteraalen | 9.4E+001  | 05/17/2002 18:56:58 | 5.3737209999999997E+001 | -1.6701570000000001E+002 | 2.4191E+004  | shortfin eelpout  | Lycodes brevipes  | High             | 3.5784000000000003E-002 | 3.5784099999999999E+000 | 3.5784104480000001E+003 | 7.9520199999999996E-001 | 7.9520231999999993E+001 | 7.9520232174000004E+004 | 8.9999999999999997E-002 | 2.0E+000 | 4.0999999999999996E+000 | 5.2999999999999998E+000 | 1.87E+002 | 1.5609999999999999E+000 | 1.6111999999999998E+001 | 7.25E+000    | 2.5150831999999994E+000 | 2.8000000000000003E-001 | 165258 |       878823 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878823> |

### Subset data

Here, as an example, we can subset the data for the 2018 Aleutian
Islands Bottom Trawl Survey.

``` r
res <- httr::GET(url = api_link, query = list(year = "2018", srvy = "AI"))
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
using HAULJOIN tocreate zero-filled (presence and absence) observations
andcatch-per-unit-effort (CPUE) estimates for all identified species at
a standard set of stations in the northern Bering Sea (NBS), eastern
Bering Sea (EBS), Gulf of Alaska (GOA), Aleutian Islands (AI), Bering
Sea Slope (BSS) Surveys conducted by the Resource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) oThere are no legal restrictions on access to the data.The data
from this dataset are shared on the Fisheries One Stop Stop (FOSS)
platform
(<https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243>:::::).The
GitHub repository for the scripts that created this code can be found at
<https://github.com/afsc-gap-products/gap_public_data.For> more
information about codes used in the tables, please refer to the survey
code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).These
data were last updated January 21, 2023.

    ## RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH: 
    ##   rows: 36317744
    ##   cols: 14
    ##   2.594 GB

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
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:28:2283554735243:::::)
platform managers.

## R version metadata

This data was compiled using the below `R` environment and `R` packages:

``` r
sessionInfo()
```

    ## R version 4.2.2 (2022-10-31 ucrt)
    ## Platform: x86_64-w64-mingw32/x64 (64-bit)
    ## Running under: Windows 10 x64 (build 19045)
    ## 
    ## Matrix products: default
    ## 
    ## locale:
    ## [1] LC_COLLATE=English_United States.utf8  LC_CTYPE=English_United States.utf8    LC_MONETARY=English_United States.utf8
    ## [4] LC_NUMERIC=C                           LC_TIME=English_United States.utf8    
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ##  [1] jsonlite_1.8.4 httr_1.4.4     knitr_1.41     badger_0.2.2   stringr_1.5.0  taxize_0.9.100 janitor_2.1.0  rmarkdown_2.19 readr_2.1.3   
    ## [10] magrittr_2.0.3 dplyr_1.0.10   tidyr_1.2.1   
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] bit64_4.0.5         vroom_1.6.0         foreach_1.5.2       bold_1.2.0          here_1.0.1          assertthat_0.2.1    askpass_1.1        
    ##  [8] highr_0.10          BiocManager_1.30.19 rvcheck_0.2.1       yulab.utils_0.0.6   yaml_2.3.6          pillar_1.8.1        lattice_0.20-45    
    ## [15] glue_1.6.2          uuid_1.1-0          digest_0.6.31       RColorBrewer_1.1-3  snakecase_0.11.0    colorspace_2.0-3    htmltools_0.5.4    
    ## [22] plyr_1.8.8          pkgconfig_2.0.3     httpcode_0.3.0      gitcreds_0.1.2      purrr_1.0.1         scales_1.2.1        tzdb_0.3.0         
    ## [29] timechange_0.1.1    tibble_3.1.8        openssl_2.0.5       generics_0.1.3      ggplot2_3.4.0       usethis_2.1.6       ellipsis_0.3.2     
    ## [36] withr_2.5.0         credentials_1.3.2   cli_3.6.0           crayon_1.5.2        evaluate_0.19       fs_1.5.2            fansi_1.0.3        
    ## [43] nlme_3.1-161        xml2_1.3.3          gh_1.3.1            tools_4.2.2         data.table_1.14.6   hms_1.1.2           lifecycle_1.0.3    
    ## [50] gert_1.9.2          munsell_0.5.0       compiler_4.2.2      rlang_1.0.6         grid_4.2.2          conditionz_0.1.0    sys_3.4.1          
    ## [57] iterators_1.0.14    rstudioapi_0.14     gtable_0.3.1        codetools_0.2-18    DBI_1.1.3           reshape_0.8.9       curl_4.3.3         
    ## [64] readtext_0.81       R6_2.5.1            zoo_1.8-11          lubridate_1.9.0     fastmap_1.1.0       bit_4.0.5           utf8_1.2.2         
    ## [71] rprojroot_2.0.3     dlstats_0.1.6       ape_5.6-2           stringi_1.7.8       parallel_4.2.2      crul_1.3            Rcpp_1.0.9         
    ## [78] vctrs_0.5.1         tidyselect_1.2.0    xfun_0.36

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
