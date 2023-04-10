<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data/) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

## This code is primarily maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[@EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
*Bering Sea Groundfish Survey Team*

Alaska Fisheries Science Center,  
National Marine Fisheries Service,  
National Oceanic and Atmospheric Administration,  
Seattle, WA 98195

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> The code in this repository is regularly being updated and improved.
> Please refer to
> [releases](https://github.com/afsc-gap-products/gap_public_data//releases)
> for finalized products and project milestones. *The FOSS dataset is
> only updated once a year and may be slightly behind the GitHub
> repository.* This metadata is regarding scripts and data last ran and
> pushed to the AFSC oracle on **April 10, 2023**.

## Table of contents

> - [*Cite this data*](#cite-this-data)
> - [*NOAA Fisheries Alaska Fisheries Science Center. RACE Division
>   Bottom Trawl Survey Data Query, Available at:
>   www.fisheries.noaa.gov/foss, Accessed
>   mm/dd/yyyy*](#noaa-fisheries-alaska-fisheries-science-center.-race-division-bottom-trawl-survey-data-query,-available-at:-www.fisheries.noaa.gov/foss,-accessed-mm/dd/yyyy)
> - [*Collabrators and data users*](#collabrators-and-data-users)
> - [*DisMAP*](#dismap)
> - [*DSE*](#dse)
> - [*Metadata*](#metadata)
>   - [*Data description (short)*](#data-description-(short))
>   - [*Data description (long)*](#data-description-(long))
>   - [*Bottom trawl surveys and
>     regions*](#bottom-trawl-surveys-and-regions)
>   - [*Relevant technical
>     memorandums*](#relevant-technical-memorandums)
>   - [*User resources*](#user-resources)
>   - [*Access constraints*](#access-constraints)
>   - [*Column-level metadata*](#column-level-metadata)
> - [*Access the data*](#access-the-data)
>   - [*Access data interactively through the FOSS
>     platform*](#access-data-interactively-through-the-foss-platform)
>     - [*Connect to the API with R*](#connect-to-the-api-with-r)
> - [*install.packages(c(“httr”,
>   “jsonlite”))*](#install.packages(c(%22httr%22,-%22jsonlite%22)))
> - [*link to the API*](#link-to-the-api)
> - \[\*res \> - [*Test connection*](#res-test-connection)
> - [*names(data)*](#names(data))
> - [*Filter by Year: Show all the data greater than the year
>   2020,*](#filter-by-year:-show-all-the-data-greater-than-the-year-2020,)
> - \[\*<https://apps-st.fisheries.noaa.gov/ods/foss/trade_data/?q=>{“year”:{“$gt": 2010}}*](#https://apps-st.fisheries.noaa.gov/ods/foss/trade_data/?q={"year":{"$gt”:-2010}})
> - [*Combination of year and name filters: Show all the data where
>   years \> 2020 and the product name contains
>   pollock*](#combination-of-year-and-name-filters:-show-all-the-data-where-years-%3E-2020-and-the-product-name-contains-pollock)
> - [*Combination of year, srvy, stratum: Show all the data where year =
>   1989, srvy = “EBS”, and stratum is not equal to
>   81*](#combination-of-year,-srvy,-stratum:-show-all-the-data-where-year-=-1989,-srvy-=-%22ebs%22,-and-stratum-is-not-equal-to-81)
> - \[\*<https://apps-st.fisheries.noaa.gov/ods/foss/trade_data/?q=>{“year”:“1989”,“srvy”:
>   “EBS”,“stratum”:{“$ne": "81"}}*](#https://apps-st.fisheries.noaa.gov/ods/foss/trade_data/?q={"year":"1989","srvy":-"ebs","stratum":{"$ne”:-“81”}})
>   - [*Subset data*](#subset-data)
>   - [*Access data via Oracle*](#access-data-via-oracle)
>     - [*Connect to Oracle from R*](#connect-to-oracle-from-r) \#’
>       Define RODBC connection to
>       ORACLE*\](#‘-define-rodbc-connection-to-oracle) \#’*\](#‘) \#’
>       (**param?**) schema default = ‘AFSC’.
>       *\](#‘-(**param-schema-default?**)-=-’afsc’.-) \#‘*\](#’) \#’
>       (**return?**) oracle channel
>       connection*\](#’-(**return-oracle-channel-connection?**)) \#’
>       (**export?**)*\](#‘-(**export?**)) \#’*\](#‘) \#’
>       (**examples?**)*\](#‘-(**examples?**)) \#’ \> - [*Not
>       run*](#'-not-run) \#’ \> - [*channel \<-
>       oracle_connect()*](#'-channel-%3C--oracle_connect())
>     - [*Select all data*](#select-all-data)
> - [*Pull table from oracle into R
>   environment*](#pull-table-from-oracle-into-r-environment)
> - [*Save table to local directory*](#save-table-to-local-directory)
>   - [*Subset data*](#subset-data)
> - [*Pull data*](#pull-data)
> - [*Save table to local directory*](#save-table-to-local-directory)
>   - [*Join catch and haul data*](#join-catch-and-haul-data)
> - [*Suggestions and comments*](#suggestions-and-comments)
>   - [*R version metadata*](#r-version-metadata)
>   - [*NOAA README*](#noaa-readme)
>   - [*NOAA License*](#noaa-license)

# Cite this data

Use the below bibtext
[citation](https://github.com/afsc-gap-products/gap_public_data//blob/main/CITATION.bib),
as cited in our group’s [citation
repository](https://github.com/afsc-gap-products/citations/blob/main/cite/bibliography.bib)
for citing the data from this data portal (NOAA Fisheries Alaska
Fisheries Science Center, 2023). Add “note = {Accessed: mm/dd/yyyy}” to
append the day this data was accessed.

    ## @misc{FOSSAFSCData,
    ##    author = {{NOAA Fisheries Alaska Fisheries Science Center}},
    ##    year = {2023}, 
    ##    title = {Fisheries One Stop Shop Public Data: RACE Division Bottom Trawl Survey Data Query},
    ##    howpublished = {https://www.fisheries.noaa.gov/foss},
    ##    publisher = {{U.S. Dep. Commer.}},
    ##    copyright = {Public Domain} 
    ## }

# Collabrators and data users

Below are a few packages and products currently using this data. If you
have developed a product, performed an analysis, or exhibited this data
in any way, reach out so we can showcase your hard work.

<div id="nfnebdyksc" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#nfnebdyksc table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#nfnebdyksc thead, #nfnebdyksc tbody, #nfnebdyksc tfoot, #nfnebdyksc tr, #nfnebdyksc td, #nfnebdyksc th {
  border-style: none;
}

#nfnebdyksc p {
  margin: 0;
  padding: 0;
}

#nfnebdyksc .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#nfnebdyksc .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#nfnebdyksc .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#nfnebdyksc .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#nfnebdyksc .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nfnebdyksc .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nfnebdyksc .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#nfnebdyksc .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#nfnebdyksc .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#nfnebdyksc .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#nfnebdyksc .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#nfnebdyksc .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#nfnebdyksc .gt_spanner_row {
  border-bottom-style: hidden;
}

#nfnebdyksc .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#nfnebdyksc .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#nfnebdyksc .gt_from_md > :first-child {
  margin-top: 0;
}

#nfnebdyksc .gt_from_md > :last-child {
  margin-bottom: 0;
}

#nfnebdyksc .gt_row {
  padding-top: 1px;
  padding-bottom: 1px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#nfnebdyksc .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#nfnebdyksc .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#nfnebdyksc .gt_row_group_first td {
  border-top-width: 2px;
}

#nfnebdyksc .gt_row_group_first th {
  border-top-width: 2px;
}

#nfnebdyksc .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfnebdyksc .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#nfnebdyksc .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#nfnebdyksc .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nfnebdyksc .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfnebdyksc .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#nfnebdyksc .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#nfnebdyksc .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#nfnebdyksc .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#nfnebdyksc .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nfnebdyksc .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfnebdyksc .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#nfnebdyksc .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#nfnebdyksc .gt_left {
  text-align: left;
}

#nfnebdyksc .gt_center {
  text-align: center;
}

#nfnebdyksc .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#nfnebdyksc .gt_font_normal {
  font-weight: normal;
}

#nfnebdyksc .gt_font_bold {
  font-weight: bold;
}

#nfnebdyksc .gt_font_italic {
  font-style: italic;
}

#nfnebdyksc .gt_super {
  font-size: 65%;
}

#nfnebdyksc .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#nfnebdyksc .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#nfnebdyksc .gt_indent_1 {
  text-indent: 5px;
}

#nfnebdyksc .gt_indent_2 {
  text-indent: 10px;
}

#nfnebdyksc .gt_indent_3 {
  text-indent: 15px;
}

#nfnebdyksc .gt_indent_4 {
  text-indent: 20px;
}

#nfnebdyksc .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="url">url</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Description">Description</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="Contacts">Contacts</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="url" class="gt_row gt_left"><img src="https://www.noaa.gov/sites/default/files/2022-03/noaa_emblem_logo-2022.png" style="height:30px;"></td>
<td headers="Description" class="gt_row gt_left"><a href = 'https://apps-st.fisheries.noaa.gov/dismap'>NOAA Fisheries Distribution Mapping and Analysis Portal</a></td>
<td headers="Contacts" class="gt_row gt_left"><a href = 'https://www.fisheries.noaa.gov/contact/office-science-and-technology'>NOAA Fisheries Office of Science and Technology</a></td></tr>
    <tr><td headers="url" class="gt_row gt_left"><img src="https://dse.berkeley.edu/sites/default/files/styles/openberkeley_image_full/public/general/dse_logostack.png" style="height:30px;"></td>
<td headers="Description" class="gt_row gt_left"><a href = 'https://pyafscgap.org/'>Pull data with python</a> and explore the <a href = 'https://app.pyafscgap.org/'>in-browser visualization tool</a>. Reference their <a href = 'https://mybinder.org/v2/gh/SchmidtDSE/afscgap/main?urlpath=/tree/index.ipynb'>example Python notebook</a></td>
<td headers="Contacts" class="gt_row gt_left"><a href = 'https://dse.berkeley.edu/'>The Eric and Wendy Schmidt Center for Data Science and the Environment at UC Berkeley</a>; <a href = 'mailto: sam.pottinger@berkeley.edu'>Sam Pottinger</a>, <a href = 'mailto: ccmartinez@berkeley.edu'>Ciera Martinez</a>, <a href = 'mailto: gzarpellon@berkeley.edu'>Giulia Zarpellon</a>, and <a href = 'mailto: kkoy@berkeley.edu'>Kevin Koy</a></td></tr>
  </tbody>
  
  
</table>
</div>

# Metadata

## Data description (short)

This dataset includes zero-filled (presence and absence) observations
and catch-per-unit-effort (CPUE) estimates for all identified species at
for index stations by the Resource Assessment and Conservation
Engineering Division (RACE) Groundfish Assessment Program (GAP) of the
Alaska Fisheries Science Center (AFSC). There are no legal restrictions
on access to the data. The data from this dataset are shared on the
Fisheries One Stop Stop (FOSS) platform
(<https://www.fisheries.noaa.gov/foss/>). The GitHub repository for the
scripts that created this code can be found at
<https://github.com/afsc-gap-products/gap_public_data>. For more
information about codes used in the tables, please refer to the survey
code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).
These data were last updated April 10, 2023.

## Data description (long)

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
catch-per-unit-effort (CPUE) for all identified species for index
stations. Some survey data are excluded, such as non-standard stations,
surveys completed in earlier years using different/non-standard gear,
and special tows and non-standard data collections.

Though not included in the public data, these surveys also collect
oceanographic and environmental data, and biological data such as
length, weight, stomach contents (to learn more about diet), otoliths
(fish ear bones to learn about age), and tissue samples for genetic
analysis, all of which can be shared upon special request. Also not
included in the public data are estimated biomass (average total weight
of all fish and crabs sampled) of crabs and groundfish that support the
creation of annual stock assessments.

## Bottom trawl surveys and regions

![](Z:/Projects/gap_public_data/README_files/figure-gfm/survey-map-1.png)<!-- -->

- **Eastern Bering Sea Shelf (EBS)** (Markowitz et al., 2022)
- Annual
- Fixed stations at center of 20 x 20 nm grid
- **Northern Bering Sea (NBS)** (Markowitz et al., 2022)
- Biennial/Annual
- Fixed stations at center of 20 x 20 nm grid
- **Eastern Bering Sea Slope (BSS)** (Hoff, 2016)
- Intermittent (funding dependent)
- Modified Index-Stratified Random of Successful Stations Survey Design
- **Aleutian Islands (AI)** (Von Szalay and Raring, 2020)
- Triennial (1990s)/Biennial since 2000 in even years
- Modified Index-Stratified Random of Successful Stations Survey Design
- **Gulf of Alaska (GOA)** (Von Szalay and Raring, 2018)
- Triennial (1990s)/Biennial since 2001 in odd years
- Stratified Random Survey Design

## Relevant technical memorandums

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-RN979" class="csl-entry">

Hoff, G. R. (2016). *Results of the 2016 eastern Bering Sea upper
continental slope survey of groundfishes and invertebrate resources*
(NOAA Tech. Memo. NOAA-AFSC-339). U.S. Dep. Commer.
<https://doi.org/10.7289/V5/TM-AFSC-339>

</div>

<div id="ref-2021NEBS2022" class="csl-entry">

Markowitz, E. H., Dawson, E. J., Charriere, N. E., Prohaska, B. K.,
Rohan, S. K., Stevenson, D. E., and Britt, L. L. (2022). *Results of the
2021 eastern and northern Bering Sea continental shelf bottom trawl
survey of groundfish and invertebrate fauna* (NOAA Tech. Memo.
NMFS-F/SPO-452; p. 227). U.S. Dep. Commer.
<https://doi.org/10.25923/g1ny-y360>

</div>

<div id="ref-FOSSAFSCData" class="csl-entry">

NOAA Fisheries Alaska Fisheries Science Center. (2023). *Fisheries one
stop shop public data: RACE division bottom trawl survey data query*.
https://www.fisheries.noaa.gov/foss; U.S. Dep. Commer.

</div>

<div id="ref-cb2021" class="csl-entry">

Resource Assessment, A. F. S. C. (U.S.)., and Division, C. E. (2021).
*Groundfish survey data codes and forms*.
<https://repository.library.noaa.gov/view/noaa/31570>

</div>

<div id="ref-GOA2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2018). *Data report: 2017 <span
class="nocase">Gulf of Alaska</span> bottom trawl survey* (NOAA Tech.
Memo. NMFS-AFSC-374). U.S. Dep. Commer.
<https://apps-afsc.fisheries.noaa.gov/Publications/AFSC-TM/NOAA-TM-AFSC-374.pdf>

</div>

<div id="ref-AI2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2020). *Data report: 2018 Aleutian
Islands bottom trawl survey* (NOAA Tech. Memo. NMFS-AFSC-409). U.S. Dep.
Commer. <https://repository.library.noaa.gov/view/noaa/26367>

</div>

</div>

## User resources

- [AFSC RACE Groundfish Assessment Program
  (GAP)](https://www.fisheries.noaa.gov/contact/groundfish-assessment-program).
- [AFSC Resource Assessment and Conservation Engineering Division
  (RACE)](https://www.fisheries.noaa.gov/about/resource-assessment-and-conservation-engineering-division).
- For more information about codes used in the tables, please refer to
  the [survey code
  books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual)
  (Resource Assessment and Division, 2021).
- Find [past
  reports](https://www.fisheries.noaa.gov/resource/publication-database/noaa-institutional-repository)
  about these surveys.
- [GitHub
  repository](https://github.com/afsc-gap-products/gap_public_data/).
- Learn more about other [research surveys conducted at
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
One Stop Shop (FOSS)](https://www.fisheries.noaa.gov/foss) platform,
please contact us using the Comments page on the
[FOSS](https://www.fisheries.noaa.gov/foss) webpage.

## Column-level metadata

| Column name           | Column name (long)                                       | Units                            | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|:----------------------|:---------------------------------------------------------|:---------------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| YEAR                  | Year                                                     | year                             | Year the survey was conducted in.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| SRVY                  | Survey                                                   | text abbreviated                 | Abbreviated survey names. The column ‘srvy’ is associated with the ‘survey’ and ‘survey_id’ columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| SURVEY                | Survey Name                                              | text                             | Name and description of survey. The column ‘survey’ is associated with the ‘srvy’ and ‘survey_id’ columns.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| SURVEY_DEFINITION_ID  | Survey ID                                                | ID code                          | This number uniquely identifies a survey. Name and description of survey. The column ‘survey_id’ is associated with the ‘srvy’ and ‘survey’ columns. For a complete list of surveys, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| CRUISE                | Cruise ID                                                | ID code                          | This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| HAUL                  | Haul Number                                              | ID code                          | This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| HAULJOIN              | Haul ID                                                  | ID code                          | This is a unique numeric identifier assigned to each (vessel, cruise, and haul) combination.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| STRATUM               | Stratum ID                                               | ID code                          | RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| STATION               | Station ID                                               | ID code                          | Alpha-numeric designation for the station established in the design of a survey.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| VESSEL_NAME           | Vessel Name                                              | text                             | Name of the vessel used to collect data for that haul. The column ‘vessel_name’ is associated with the ‘vessel_id’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| VESSEL_ID             | Vessel ID                                                | ID code                          | ID number of the vessel used to collect data for that haul. The column ‘vessel_id’ is associated with the ‘vessel_name’ column. Note that it is possible for a vessel to have a new name but the same vessel id number. For a complete list of vessel ID codes, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| DATE_TIME             | Date and Time of Haul                                    | MM/DD/YYYY HH::MM                | The date (MM/DD/YYYY) and time (HH:MM) of the beginning of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| LATITUDE_DD_START     | Start Latitude (decimal degrees)                         | decimal degrees                  | Latitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| LONGITUDE_DD_START    | Start Longitude (decimal degrees)                        | decimal degrees                  | Longitude (one hundred thousandth of a decimal degree) of the start of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| LATITUDE_DD_END       | End Latitude (decimal degrees)                           | decimal degrees                  | Latitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| LONGITUDE_DD_END      | End Longitude (decimal degrees)                          | decimal degrees                  | Longitude (one hundred thousandth of a decimal degree) of the end of the haul.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| SPECIES_CODE          | Taxon Code                                               | ID code                          | The species code of the organism associated with the ‘common_name’ and ‘scientific_name’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| ITIS                  | ITIS Taxonomic Serial Number                             | ID code                          | Species code as identified in the Integrated Taxonomic Information System (<https://itis.gov/>).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| WORMS                 | World Register of Marine Species Taxonomic Serial Number | ID code                          | Species code as identified in the World Register of Marine Species (WoRMS) (<https://www.marinespecies.org/>).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| COMMON_NAME           | Taxon Common Name                                        | text                             | The common name of the marine organism associated with the ‘scientific_name’ and ‘species_code’ columns. For a complete species list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| SCIENTIFIC_NAME       | Taxon Scientific Name                                    | text                             | The scientific name of the organism associated with the ‘common_name’ and ‘species_code’ columns. For a complete taxon list, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| TAXON_CONFIDENCE      | Taxon Confidence Rating                                  | category                         | Confidence in the ability of the survey team to correctly identify the taxon to the specified level, based solely on identification skill (e.g., not likelihood of a taxon being caught at that station on a location-by-location basis). Quality codes follow: **‘High’**: High confidence and consistency. Taxonomy is stable and reliable at this level, and field identification characteristics are well known and reliable. **‘Moderate’**: Moderate confidence. Taxonomy may be questionable at this level, or field identification characteristics may be variable and difficult to assess consistently. **‘Low’**: Low confidence. Taxonomy is incompletely known, or reliable field identification characteristics are unknown. Documentation: [Species identification confidence in the eastern Bering Sea shelf survey (1982-2008)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2009-04.pdf), [Species identification confidence in the eastern Bering Sea slope survey (1976-2010)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-05.pdf), and [Species identification confidence in the Gulf of Alaska and Aleutian Islands surveys (1980-2011)](http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-01.pdf). |
| CPUE_KGHA             | Weight CPUE (kg/ha)                                      | kilograms per hectare            | Catch weight (kilograms) divided by area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| CPUE_KGKM2            | Weight CPUE (kg/km<sup>2</sup>)                          | kilograms per kilometers squared | Catch weight (kilograms) divided by area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| CPUE_NOHA             | Number CPUE (no/ha)                                      | count per hectare                | Catch number (in number of organisms) per area (hectares) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| CPUE_NOKM2            | Number CPUE (no/km<sup>2</sup>)                          | count per kilometers squared     | Catch number (in number of organisms) per area (squared kilometers) swept by the net.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| WEIGHT_KG             | Taxon Weight (kg)                                        | kilograms                        | Weight (thousandths of a kilogram) of individuals in a haul by taxon.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| COUNT                 | Taxon Count                                              | count, whole number resolution   | Total number of individuals caught in haul by taxon, represented in whole numbers.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| BOTTOM_TEMPERATURE_C  | Bottom Temperature (Degrees Celsius)                     | degrees Celsius                  | Bottom temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| SURFACE_TEMPERATURE_C | Surface Temperature (Degrees Celsius)                    | degrees Celsius                  | Surface temperature (tenths of a degree Celsius); NA indicates removed or missing values.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| DEPTH_M               | Depth (m)                                                | degrees Celsius                  | Bottom depth (tenths of a meter).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DISTANCE_FISHED_KM    | Distance Fished (km)                                     | degrees Celsius                  | Distance the net fished (thousandths of kilometers).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| NET_WIDTH_M           | Net Width (m)                                            | meters                           | Measured or estimated distance (meters) between wingtips of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| NET_HEIGHT_M          | Net Height (m)                                           | meters                           | Measured or estimated distance (meters) between footrope and headrope of the trawl.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| AREA_SWEPT_HA         | Area Swept (ha)                                          | hectares                         | The area the net covered while the net was fishing (hectares), defined as the distance fished times the net width.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| DURATION_HR           | Tow Duration (decimal hr)                                | hours, tenths resolution         | This is the elapsed time between start and end of a haul (decimal hours).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| PERFORMANCE           | Haul Performance Code                                    | category                         | This denotes what, if any, issues arose during the haul. For more information, review the [code books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |

# Access the data

While pulling data, please keep in mind that this is a very large file.
For reference:

    ## RACEBASE_FOSS.FOSS_CPUE_ZEROFILLED: 
    ##   rows: 36342299
    ##   cols: 37
    ##   10.064 GB

## Access data interactively through the FOSS platform

Select, filter, and package this and other NOAA Fisheries data from the
[Fisheries One Stop Shop (FOSS)](https://www.fisheries.noaa.gov/foss)
platform. This user-friendly portal is maintained through `Oracle APEX`.
A useful intro to using APIs in `R` can be found
[here](https://www.dataquest.io/blog/r-api-tutorial/). A user guide for
the FOSS platform can be found
[here](https://www.fisheries.noaa.gov/foss/f?p=215:7:7542600605674:::::).

### Connect to the API with R

More information about how to amend API links can be found
[here](https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/22.3/books.html#AELIG90103/).

Load the first 25 rows of data

``` r
# install.packages(c("httr", "jsonlite"))
library("httr")
library("jsonlite")
# link to the API
api_link <- "https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/"
```

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

Load the first 10000 rows of data

``` r
res <- httr::GET(url = paste0(api_link, "?offset=0&limit=10000"))
data <- jsonlite::fromJSON(base::rawToChar(res$content))
dim(data$items)
```

    ## [1] 10000    36

Filter by Species name: Show all the data where the product name
contains pollock Please note that here the word pollock is case
sensitive.

The notation for finding a string is to use % around it. Since % is a
reserved character in a URL, you have to replace `%` with `%25`.

``` r
res <- httr::GET(url = paste0(api_link, '?q={"common_name":{"$like":"%25pollock%25"}}'))
data <- jsonlite::fromJSON(base::rawToChar(res$content))
knitr::kable(head(data$items, 3))
```

| year | srvy | survey                               | survey_id | cruise       | haul     | stratum   | station | vessel_name | vessel_id | date_time           | latitude_dd             | longitude_dd             | species_code | common_name     | scientific_name     | taxon_confidence | cpue_kgha               | cpue_kgkm2              | cpue_kg1000km2          | cpue_noha               | cpue_nokm2              | cpue_no1000km2          | weight_kg               | count     | bottom_temperature_c    | surface_temperature_c   | depth_m   | distance_fished_km      | net_width_m             | net_height_m            | area_swept_ha           | duration_hr             |    tsn | ak_survey_id | links                                                                              |
|-----:|:-----|:-------------------------------------|:----------|:-------------|:---------|:----------|:--------|:------------|:----------|:--------------------|:------------------------|:-------------------------|:-------------|:----------------|:--------------------|:-----------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|:----------|:------------------------|:------------------------|:----------|:------------------------|:------------------------|:------------------------|:------------------------|:------------------------|-------:|-------------:|:-----------------------------------------------------------------------------------|
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 5.0E+000 | 7.21E+002 | 306-64  | Vesteraalen | 9.4E+001  | 05/17/2002 16:39:57 | 5.3768709999999999E+001 | -1.6707259999999999E+002 | 2.174E+004   | walleye pollock | Gadus chalcogrammus | High             | 6.3990000000000002E-003 | 6.3989099999999999E-001 | 6.3989137200000005E+002 | 3.9993200000000001E-001 | 3.9993211000000002E+001 | 3.9993210752999999E+004 | 1.6E-002                | 1.0E+000  | 4.4000000000000004E+000 | 5.0999999999999996E+000 | 6.5E+001  | 1.6759999999999999E+000 | 1.4919E+001             | 7.9009999999999998E+000 | 2.5004244E+000          | 3.1E-001                | 934083 |       878884 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878884> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 6.0E+000 | 7.22E+002 | 307-63  | Vesteraalen | 9.4E+001  | 05/17/2002 18:56:58 | 5.3737209999999997E+001 | -1.6701570000000001E+002 | 2.174E+004   | walleye pollock | Gadus chalcogrammus | High             | 7.7532230000000002E+000 | 7.7532226400000002E+002 | 7.7532226369299996E+005 | 1.1530434E+001          | 1.153043367E+003        | 1.1530433665179999E+006 | 1.95E+001               | 2.9E+001  | 4.0999999999999996E+000 | 5.2999999999999998E+000 | 1.87E+002 | 1.5609999999999999E+000 | 1.6111999999999998E+001 | 7.25E+000               | 2.5150831999999994E+000 | 2.8000000000000003E-001 | 934083 |       878838 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878838> |
| 2002 | AI   | Aleutian Islands Bottom Trawl Survey | 5.2E+001  | 2.00201E+005 | 2.0E+000 | 7.22E+002 | 303-64  | Vesteraalen | 9.4E+001  | 05/17/2002 10:20:08 | 5.3790370000000003E+001 | -1.6725810000000001E+002 | 2.174E+004   | walleye pollock | Gadus chalcogrammus | High             | 1.06858064E+002         | 1.0685806397E+004       | 1.0685806397293E+007    | 1.2519113900000001E+002 | 1.2519113928999999E+004 | 1.251911392852E+007     | 2.5180000000000001E+002 | 2.95E+002 | 4.0999999999999996E+000 | 5.0E+000                | 1.64E+002 | 1.488E+000              | 1.5836E+001             | 7.1589999999999998E+000 | 2.3563968000000002E+000 | 2.7000000000000002E-001 | 934083 |       878858 | self , <https://apps-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/878858> |

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
If no username and password is entered in the function, pop-ups will
appear on the screen asking for the username and password.

``` r
#' Define RODBC connection to ORACLE
#'
#' @param schema default = 'AFSC'. 
#'
#' @return oracle channel connection
#' @export
#'
#' @examples
#' # Not run
#' # channel <- oracle_connect()
oracle_connect <- function(
    schema='AFSC', 
    username = NULL, 
    passowrd = NULL){(echo=FALSE)
  
  library("RODBC")
  library("getPass")
  if (is.null(username)) {
    username <- getPass(msg = "Enter your ORACLE Username: ")
  }
  if (is.null(password)) {
    password <- getPass(msg = "Enter your ORACLE Password: ")
  }
  channel  <- RODBC::odbcConnect(
    paste(schema),
    paste(username),
    paste(password), 
    believeNRows=FALSE)
  return(channel)
}

channel <- oracle_connect()
```

### Select all data

Once connected, pull and save (if needed) the table into the `R`
environment.

``` r
# Pull table from oracle into R environment
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

These datasets, JOIN_FOSS_CPUE_CATCH and JOIN_FOSS_CPUE_HAUL, when full
joined by the HAULJOIN variable, includes zero-filled (presence and
absence) observations and catch-per-unit-effort (CPUE) estimates for all
identified species at for index stations by the Resource Assessment and
Conservation Engineering Division (RACE) Groundfish Assessment Program
(GAP) of the Alaska Fisheries Science Center (AFSC). There are no legal
restrictions on access to the data. The data from this dataset are
shared on the Fisheries One Stop Stop (FOSS) platform
(<https://www.fisheries.noaa.gov/foss/>). The GitHub repository for the
scripts that created this code can be found at
<https://github.com/afsc-gap-products/gap_public_data>. For more
information about codes used in the tables, please refer to the survey
code books
(<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>).
These data were last updated April 10, 2023.

    ## RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH: 
    ##   rows: 36342299
    ##   cols: 13
    ##   2.785 GB

    ## RACEBASE_FOSS.JOIN_FOSS_CPUE_HAUL: 
    ##   rows: 31608
    ##   cols: 25
    ##   0.007 GB

To join these tables in Oracle, you may use a variant of the following
code:

``` sql
SELECT * FROM RACEBASE_FOSS.JOIN_FOSS_CPUE_HAUL
FULL JOIN RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH
ON RACEBASE_FOSS.JOIN_FOSS_CPUE_HAUL.HAULJOIN = RACEBASE_FOSS.JOIN_FOSS_CPUE_CATCH.HAULJOIN;
```

# Suggestions and comments

If the data or metadata can be improved, please create a pull request,
[submit an issue to the GitHub
organization](https://github.com/afsc-gap-products/data-requests/issues),
[submit an issue to the code’s
repository](https://github.com/afsc-gap-products/gap_public_data//issues),
reach out the the survey team leads (listed above), or to [Fisheries One
Stop Shop (FOSS)](https://www.fisheries.noaa.gov/foss) platform
managers.

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
    ##  [1] jsonlite_1.8.4    httr_1.4.5        akgfmaps_2.3.1    stars_0.6-0       abind_1.4-5       shadowtext_0.1.2  sf_1.0-9         
    ##  [8] raster_3.6-20     sp_1.6-0          rmapshaper_0.4.6  gstat_2.1-0       ggspatial_1.1.7   classInt_0.4-9    viridis_0.6.2    
    ## [15] viridisLite_0.4.1 ggplot2_3.4.1     purrr_1.0.1       gtExtras_0.4.5    gt_0.9.0          knitr_1.42        badger_0.2.3     
    ## [22] stringr_1.5.0     janitor_2.2.0     rmarkdown_2.20    readr_2.1.4       magrittr_2.0.3    dplyr_1.1.0       tidyr_1.3.0      
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] colorspace_2.1-0    ellipsis_0.3.2      class_7.3-20        gitcreds_0.1.2      readtext_0.81       rprojroot_2.0.3    
    ##  [7] snakecase_0.11.0    fs_1.6.1            rstudioapi_0.14     httpcode_0.3.0      proxy_0.4-27        farver_2.1.1       
    ## [13] gh_1.4.0            bit64_4.0.5         fansi_1.0.4         lubridate_1.9.2     xml2_1.3.3          codetools_0.2-18   
    ## [19] cachem_1.0.6        geojsonlint_0.4.0   BiocManager_1.30.20 compiler_4.2.2      rvcheck_0.2.1       fastmap_1.1.0      
    ## [25] cli_3.6.0           htmltools_0.5.4     tools_4.2.2         gtable_0.3.1        glue_1.6.2          rappdirs_0.3.3     
    ## [31] V8_4.2.2            Rcpp_1.0.10         jquerylib_0.1.4     vctrs_0.5.2         crul_1.3            lwgeom_0.2-11      
    ## [37] xfun_0.37           timechange_0.2.0    lifecycle_1.0.3     dlstats_0.1.6       sys_3.4.1           terra_1.7-18       
    ## [43] zoo_1.8-11          scales_1.2.1        vroom_1.6.1         hms_1.1.2           credentials_1.3.2   parallel_4.2.2     
    ## [49] rematch2_2.1.2      httr2_0.2.2         RColorBrewer_1.1-3  gert_1.9.2          yaml_2.3.7          curl_5.0.0         
    ## [55] gridExtra_2.3       yulab.utils_0.0.6   sass_0.4.5          stringi_1.7.12      jsonvalidate_1.3.2  highr_0.10         
    ## [61] paletteer_1.5.0     e1071_1.7-13        intervals_0.15.2    rlang_1.0.6         pkgconfig_2.0.3     evaluate_0.20      
    ## [67] lattice_0.20-45     fontawesome_0.5.0   bit_4.0.5           tidyselect_1.2.0    here_1.0.1          R6_2.5.1           
    ## [73] generics_0.1.3      DBI_1.1.3           pillar_1.8.1        withr_2.5.0         units_0.8-1         xts_0.13.0         
    ## [79] tibble_3.1.8        spacetime_1.2-8     crayon_1.5.2        KernSmooth_2.23-20  utf8_1.2.3          tzdb_0.3.0         
    ## [85] usethis_2.1.6       grid_4.2.2          data.table_1.14.6   FNN_1.1.3.1         digest_0.6.31       openssl_2.0.5      
    ## [91] munsell_0.5.0       bslib_0.4.2         askpass_1.1

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
