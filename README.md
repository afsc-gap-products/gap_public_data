<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data/) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

## ❗ <span style="color:red">This repository is NO LONGER BEING MAINTAINED AND HAS BEEN ARCHIVED. This code and effort has been moved to https://github.com/afsc-gap-products/gap_products. For New FOSS documentation, see https://afsc-gap-products.github.io/gap_products/content/foss-intro.html. </span>.

The gap_products repository supports code used to create tables in the GAP_PRODUCTS Oracle schema. These tables include the master production tables, tables shared with AKFIN, and tables publicly shared on FOSS. 

## This code was previously maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
*Bering Sea Groundfish Survey Team*

Alaska Fisheries Science Center (AFSC) National Oceanic and Atmospheric
Administration (NOAA)  
Resource Assessment and Conservation Engineering Division (RACE)  
Groundfish Assessment Program (GAP) 7600 Sand Point Way, N.E. bldg. 4  
Seattle, WA 98115 USA

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> The code in this repository is regularly being updated and improved.
> Please refer to
> [releases](https://github.com/afsc-gap-products/gap_public_data//releases)
> for finalized products and project milestones. *The FOSS dataset is
> only updated once a year and may be slightly behind the GitHub
> repository.* This metadata is regarding scripts and data last ran and
> pushed to the AFSC oracle on **June 01, 2023**.

## Table of contents

> - [*Cite this data*](#cite-this-data)
> - [*Access the data*](#access-the-data)
> - [*Collabrators and data users*](#collabrators-and-data-users)
>   - [*Bottom trawl surveys and
>     regions*](#bottom-trawl-surveys-and-regions)
>   - [*Relevant technical
>     memorandums*](#relevant-technical-memorandums)
>   - [*User resources*](#user-resources)
>   - [*Access constraints*](#access-constraints)

# Cite this data

Use the below bibtext
[citation](https://github.com/afsc-gap-products/gap_public_data//blob/main/CITATION.bib),
as cited in our group’s [citation
repository](https://github.com/afsc-gap-products/citations/blob/main/cite/bibliography.bib)
for citing the data from this data portal (NOAA Fisheries Alaska
Fisheries Science Center, 2023). Add “note = {Accessed: mm/dd/yyyy}” to
append the day this data was accessed.

    ## @misc{FOSSAFSCData,
    ##   author = {{NOAA Fisheries Alaska Fisheries Science Center}},
    ##   year = {2023}, 
    ##   title = {Fisheries One Stop Shop Public Data: RACE Division Bottom Trawl Survey Data Query},
    ##   howpublished = {https://www.fisheries.noaa.gov/foss},
    ##   publisher = {{U.S. Dep. Commer.}},
    ##   copyright = {Public Domain} 
    ## }

# Access the data

Learn about the different ways to access our data by visiting this
[repository’s
website](https://afsc-gap-products.github.io/gap_public_data/).

# Collabrators and data users

Below are a few packages and products currently using this data. If you
have developed a product, performed an analysis, or exhibited this data
in any way, reach out so we can showcase your hard work.

- **[NOAA Fisheries Distribution Mapping and Analysis
  Portal](https://apps-st.fisheries.noaa.gov/dismap)**; *[NOAA Fisheries
  Office of Science and
  Technology](https://www.fisheries.noaa.gov/contact/office-science-and-technology)*

- **[Pull data with python](https://pyafscgap.org/) and explore the
  [in-browser visualization tool](https://app.pyafscgap.org/').
  Reference their [example Python
  notebook](https://mybinder.org/v2/gh/SchmidtDSE/afscgap/main?urlpath=/tree/index.ipynb)**;
  *[The Eric and Wendy Schmidt Center for Data Science and the
  Environment at UC Berkeley](https://dse.berkeley.edu/), including
  <sam.pottinger@berkeley.edu>, <ccmartinez@berkeley.edu>,
  <gzarpellon@berkeley.edu>, and <kkoy@berkeley.edu>.*

## Bottom trawl surveys and regions

<img src="survey_plot.png" width="2100" />

- **Aleutian Islands (AI)** (Von Szalay and Raring, 2020)
  - Triennial (1990s)/Biennial since 2000 in even years
  - Modified Index-Stratified Random of Successful Stations Survey
    Design
- **Eastern Bering Sea Slope (BSS)** (Hoff, 2016)
  - Intermittent (funding dependent)
  - Modified Index-Stratified Random of Successful Stations Survey
    Design
- **Eastern Bering Sea Shelf (EBS)** (Markowitz et al., 2023)
  - Annual
  - Fixed stations at center of 20 x 20 nm grid
- **Gulf of Alaska (GOA)** (Von Szalay and Raring, 2018)
  - Triennial (1990s)/Biennial since 2001 in odd years
  - Stratified Random Survey Design
- **Northern Bering Sea (NBS)** (Markowitz et al., 2023)
  - Biennial/Annual
  - Fixed stations at center of 20 x 20 nm grid

## Relevant technical memorandums

<div id="refs" class="references csl-bib-body hanging-indent"
line-spacing="2">

<div id="ref-RN979" class="csl-entry">

Hoff, G. R. (2016). *Results of the 2016 eastern Bering Sea upper
continental slope survey of groundfishes and invertebrate resources*
(NOAA Tech. Memo. NOAA-AFSC-339). U.S. Dep. Commer.
<https://doi.org/10.7289/V5/TM-AFSC-339>

</div>

<div id="ref-2022NEBS2023" class="csl-entry">

Markowitz, E. H., Dawson, E. J., Anderson, A. B., Rohan, S. K.,
Charriere, N. E., Prohaska, B. K., and Stevenson, D. E. (2023). *Results
of the 2022 eastern and northern Bering Sea continental shelf bottom
trawl survey of groundfish and invertebrate fauna* (NOAA Tech. Memo.
NMFS-AFSC-469; p. 213). U.S. Dep. Commer.

</div>

<div id="ref-FOSSAFSCData" class="csl-entry">

NOAA Fisheries Alaska Fisheries Science Center. (2023). *Fisheries one
stop shop public data: RACE division bottom trawl survey data query*.
https://www.fisheries.noaa.gov/foss; U.S. Dep. Commer.

</div>

<div id="ref-GOA2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2018). *Data report: 2017 <span
class="nocase">Gulf of Alaska</span> bottom trawl survey* (NOAA Tech.
Memo. NMFS-AFSC-374). U.S. Dep. Commer.
<https://doi.org/10.7289/V5/TM-AFSC-374>

</div>

<div id="ref-AI2018" class="csl-entry">

Von Szalay, P. G., and Raring, N. W. (2020). *Data report: 2018 Aleutian
Islands bottom trawl survey* (NOAA Tech. Memo. NMFS-AFSC-409). U.S. Dep.
Commer. <https://doi.org/10.25923/qe5v-fz70>

</div>

</div>

## User resources

- [Groundfish Assessment Program Bottom Trawl
  Surveys](https://www.fisheries.noaa.gov/alaska/science-data/groundfish-assessment-program-bottom-trawl-surveys)
- [AFSC’s Resource Assessment and Conservation Engineering
  Division](https://www.fisheries.noaa.gov/about/resource-assessment-and-conservation-engineering-division).
- For more information about codes used in the tables, please refer to
  the [survey code
  books](https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual).
- Access public data via the [Interactive Fisheries One Stop Shop (FOSS)
  Platform](https://afsc-gap-products.github.io/gap_public_data/access-foss.html)
  and
  [documentation](https://afsc-gap-products.github.io/gap_public_data/)
- [Find past reports in the NOAA Institutional
  Repository](https://www.fisheries.noaa.gov/resource/publication-database/noaa-institutional-repository).
- Learn more about other [Research Surveys conducted at
  AFSC](https://www.fisheries.noaa.gov/alaska/ecosystems/alaska-fish-research-surveys).

## Access constraints

**There are no legal restrictions on access to the data. They reside in
the public domain and can be freely distributed.**

**User Constraints:** Users must read and fully comprehend the metadata
prior to use. Data should not be used beyond the limits of the source
scale. Acknowledgement of AFSC Groundfish Assessment Program, as the
source from which these data were obtained, in any publications and/or
other representations of these data, is suggested.

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
