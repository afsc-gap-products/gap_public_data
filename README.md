<!-- README.md is generated from README.Rmd. Please edit that file -->

# [AFSC RACE Groundfish and Shellfish Survey Public Data](https://github.com/afsc-gap-products/gap_public_data) <img src="https://avatars.githubusercontent.com/u/91760178?s=96&amp;v=4" alt="Logo." align="right" width="139" height="139"/>

[![](https://img.shields.io/github/last-commit/afsc-gap-products/gap_public_data.svg)](https://github.com/afsc-gap-products/gap_public_data/commits/main)

> Code is always in development

## This code produces the public facing data so AFSC GAP can meet data sharing requirements.

**Basic Requirements**

-   Making data independently understandable (well documented with
    structured metadata)
-   Making data visible (discoverable)
-   Making data accessible.
-   Archiving appropriate data, in cooperation with NOAA, at existing
    Data Centers.

If you feel that the data or metadata can be improved, please create a
pull request, submit an issue, or reach out the the survey team leads or
to [Fisheries One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13496745795839:Mail:NO:::)
platform managers.

## This code is primarily maintained by:

**Emily Markowitz** (Emily.Markowitz AT noaa.gov;
[@EmilyMarkowitz-NOAA](https://github.com/EmilyMarkowitz-NOAA))  
Research Fisheries Biologist  
Alaska Fisheries Science Center,  
National Marine Fisheries Service,  
National Oceanic and Atmospheric Administration,  
Seattle, WA 98195

## Obtain data interactively through the [Fisheries One Stop Shop (FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13496745795839:Mail:NO:::) platform

Select, filter, and package this and other NOAA Fisheries data from the
[Fisheries One Stop Shop
(FOSS)](https://www.fisheries.noaa.gov/foss/f?p=215:200:13496745795839:Mail:NO:::)
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
res <- httr::GET(api_link)

base::rawToChar(res$content) # Test connection
```

    ## [1] "{\"items\":[{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"68560\",\"common_name\":\"Tanner crab\",\"scientific_name\":\"Chionoecetes bairdi\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.010185\",\"cpue_kgkm2\":\"1.018504\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"0.024\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":1,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/1\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"66031\",\"common_name\":\"Alaskan pink shrimp\",\"scientific_name\":\"Pandalus eous\",\"taxon_confidence\":\"Moderate\",\"cpue_kgha\":\"0.016975\",\"cpue_kgkm2\":\"1.697507\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"2.970637\",\"cpue_nokm2\":\"297.06372\",\"cpue_no1000km2\":\"297063.720338\",\"weight_kg\":\"0.04\",\"count\":\"7\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":2,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/2\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"72500\",\"common_name\":\"Oregon triton\",\"scientific_name\":\"Fusitriton oregonensis\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.018673\",\"cpue_kgkm2\":\"1.867258\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"0.044\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":3,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/3\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"91040\",\"common_name\":\"tree sponge\",\"scientific_name\":\"Mycale loveni\",\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.028009\",\"cpue_kgkm2\":\"2.800887\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.066\",\"count\":\"0\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":4,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/4\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"82510\",\"common_name\":\"green sea urchin\",\"scientific_name\":\"Strongylocentrotus droebachiensis\",\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.033101\",\"cpue_kgkm2\":\"3.310139\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"0.078\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":5,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/5\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"91000\",\"common_name\":\"sponge unid.\",\"scientific_name\":\"Porifera\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.044135\",\"cpue_kgkm2\":\"4.413518\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.104\",\"count\":\"0\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":6,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/6\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"91077\",\"common_name\":\"yellow bowl sponge\",\"scientific_name\":null,\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.044984\",\"cpue_kgkm2\":\"4.498393\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.106\",\"count\":\"0\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":7,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/7\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"10180\",\"common_name\":\"Dover sole\",\"scientific_name\":\"Microstomus pacificus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.073842\",\"cpue_kgkm2\":\"7.384155\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"0.174\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":8,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/8\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"43090\",\"common_name\":\"tentacle-shedding anemone\",\"scientific_name\":\"Liponema brevicorne\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.149381\",\"cpue_kgkm2\":\"14.938061\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"0.352\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":9,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/9\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"91057\",\"common_name\":\"scapula sponge\",\"scientific_name\":\"Stelodoryx oxeata\",\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.19776\",\"cpue_kgkm2\":\"19.775956\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.466\",\"count\":\"0\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":10,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/10\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"91068\",\"common_name\":\"yellow leafy sponge\",\"scientific_name\":\"Monanchora pulchra\",\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.20455\",\"cpue_kgkm2\":\"20.454959\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.482\",\"count\":\"0\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":11,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/11\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"85180\",\"common_name\":null,\"scientific_name\":\"Bathyplotes sp.\",\"taxon_confidence\":\"Low\",\"cpue_kgha\":\"0.343745\",\"cpue_kgkm2\":\"34.374516\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"5.941274\",\"cpue_nokm2\":\"594.127441\",\"cpue_no1000km2\":\"594127.440676\",\"weight_kg\":\"0.81\",\"count\":\"14\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":12,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/12\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"10130\",\"common_name\":\"flathead sole\",\"scientific_name\":\"Hippoglossoides elassodon\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.573757\",\"cpue_kgkm2\":\"57.375736\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"1.697507\",\"cpue_nokm2\":\"169.750697\",\"cpue_no1000km2\":\"169750.697336\",\"weight_kg\":\"1.352\",\"count\":\"4\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":13,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/13\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"30060\",\"common_name\":\"Pacific ocean perch\",\"scientific_name\":\"Sebastes alutus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.604312\",\"cpue_kgkm2\":\"60.431248\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.848753\",\"cpue_nokm2\":\"84.875349\",\"cpue_no1000km2\":\"84875.348668\",\"weight_kg\":\"1.424\",\"count\":\"2\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":14,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/14\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"10120\",\"common_name\":\"Pacific halibut\",\"scientific_name\":\"Hippoglossus stenolepis\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"1.820576\",\"cpue_kgkm2\":\"182.057623\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.424377\",\"cpue_nokm2\":\"42.437674\",\"cpue_no1000km2\":\"42437.674334\",\"weight_kg\":\"4.29\",\"count\":\"1\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":15,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/15\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"79210\",\"common_name\":\"magistrate armhook squid\",\"scientific_name\":\"Berryteuthis magister\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"3.09795\",\"cpue_kgkm2\":\"309.795023\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"8.063158\",\"cpue_nokm2\":\"806.315812\",\"cpue_no1000km2\":\"806315.812345\",\"weight_kg\":\"7.3\",\"count\":\"19\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":16,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/16\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"10200\",\"common_name\":\"rex sole\",\"scientific_name\":\"Glyptocephalus zachirus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"3.64964\",\"cpue_kgkm2\":\"364.963999\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"6.790028\",\"cpue_nokm2\":\"679.002789\",\"cpue_no1000km2\":\"679002.789343\",\"weight_kg\":\"8.6\",\"count\":\"16\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":17,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/17\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"21720\",\"common_name\":\"Pacific cod\",\"scientific_name\":\"Gadus macrocephalus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"8.105596\",\"cpue_kgkm2\":\"810.55958\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"5.941274\",\"cpue_nokm2\":\"594.127441\",\"cpue_no1000km2\":\"594127.440676\",\"weight_kg\":\"19.1\",\"count\":\"14\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":18,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/18\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"10110\",\"common_name\":\"arrowtooth flounder\",\"scientific_name\":\"Atheresthes stomias\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"16.041441\",\"cpue_kgkm2\":\"1604.14409\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"37.76953\",\"cpue_nokm2\":\"3776.953016\",\"cpue_no1000km2\":\"3776953.015723\",\"weight_kg\":\"37.8\",\"count\":\"89\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":19,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/19\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"2\",\"stratum\":\"722\",\"station\":\"303-64\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 10:20:08 AM\",\"latitude_dd\":\"53.79037\",\"longitude_dd\":\"-167.2581\",\"species_code\":\"21740\",\"common_name\":\"walleye pollock\",\"scientific_name\":\"Gadus chalcogrammus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"106.858064\",\"cpue_kgkm2\":\"10685.806397\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"125.191139\",\"cpue_nokm2\":\"12519.113929\",\"cpue_no1000km2\":\"12519113.92852\",\"weight_kg\":\"251.8\",\"count\":\"295\",\"bottom_temperature_c\":\"4.1\",\"surface_temperature_c\":\"5\",\"depth_m\":\"164\",\"distance_fished_km\":\"1.488\",\"net_width_m\":\"15.836\",\"net_height_m\":\"7.159\",\"area_swept_ha\":\"2.3563968\",\"duration_hr\":\"0.27\",\"tsn\":null,\"ak_survey_id\":20,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/20\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"3\",\"stratum\":\"721\",\"station\":\"305-65\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 12:36:49 PM\",\"latitude_dd\":\"53.81554\",\"longitude_dd\":\"-167.1349\",\"species_code\":\"69110\",\"common_name\":\"widehand hermit crab\",\"scientific_name\":\"Elassochirus tenuimanus\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.000796\",\"cpue_kgkm2\":\"0.079558\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.397791\",\"cpue_nokm2\":\"39.779143\",\"cpue_no1000km2\":\"39779.143016\",\"weight_kg\":\"0.002\",\"count\":\"1\",\"bottom_temperature_c\":\"5\",\"surface_temperature_c\":\"5.3\",\"depth_m\":\"41\",\"distance_fished_km\":\"1.742\",\"net_width_m\":\"14.431\",\"net_height_m\":\"8.422\",\"area_swept_ha\":\"2.51388019999999\",\"duration_hr\":\"0.33\",\"tsn\":null,\"ak_survey_id\":21,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/21\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"3\",\"stratum\":\"721\",\"station\":\"305-65\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 12:36:49 PM\",\"latitude_dd\":\"53.81554\",\"longitude_dd\":\"-167.1349\",\"species_code\":\"82740\",\"common_name\":\"parma sand dollar\",\"scientific_name\":\"Echinarachnius parma\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.003978\",\"cpue_kgkm2\":\"0.397791\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.397791\",\"cpue_nokm2\":\"39.779143\",\"cpue_no1000km2\":\"39779.143016\",\"weight_kg\":\"0.01\",\"count\":\"1\",\"bottom_temperature_c\":\"5\",\"surface_temperature_c\":\"5.3\",\"depth_m\":\"41\",\"distance_fished_km\":\"1.742\",\"net_width_m\":\"14.431\",\"net_height_m\":\"8.422\",\"area_swept_ha\":\"2.51388019999999\",\"duration_hr\":\"0.33\",\"tsn\":null,\"ak_survey_id\":22,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/22\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"3\",\"stratum\":\"721\",\"station\":\"305-65\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 12:36:49 PM\",\"latitude_dd\":\"53.81554\",\"longitude_dd\":\"-167.1349\",\"species_code\":\"20202\",\"common_name\":\"sand lance unid.\",\"scientific_name\":\"Ammodytes sp.\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.005569\",\"cpue_kgkm2\":\"0.556908\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.795583\",\"cpue_nokm2\":\"79.558286\",\"cpue_no1000km2\":\"79558.286031\",\"weight_kg\":\"0.014\",\"count\":\"2\",\"bottom_temperature_c\":\"5\",\"surface_temperature_c\":\"5.3\",\"depth_m\":\"41\",\"distance_fished_km\":\"1.742\",\"net_width_m\":\"14.431\",\"net_height_m\":\"8.422\",\"area_swept_ha\":\"2.51388019999999\",\"duration_hr\":\"0.33\",\"tsn\":null,\"ak_survey_id\":23,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/23\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"3\",\"stratum\":\"721\",\"station\":\"305-65\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 12:36:49 PM\",\"latitude_dd\":\"53.81554\",\"longitude_dd\":\"-167.1349\",\"species_code\":\"99994\",\"common_name\":\"empty gastropod shells\",\"scientific_name\":null,\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.007956\",\"cpue_kgkm2\":\"0.795583\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"NA\",\"cpue_nokm2\":\"NA\",\"cpue_no1000km2\":\"NA\",\"weight_kg\":\"0.02\",\"count\":\"0\",\"bottom_temperature_c\":\"5\",\"surface_temperature_c\":\"5.3\",\"depth_m\":\"41\",\"distance_fished_km\":\"1.742\",\"net_width_m\":\"14.431\",\"net_height_m\":\"8.422\",\"area_swept_ha\":\"2.51388019999999\",\"duration_hr\":\"0.33\",\"tsn\":null,\"ak_survey_id\":24,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/24\"}]},{\"year\":2002,\"srvy\":\"AI\",\"survey\":\"Aleutian Islands Bottom Trawl Survey\",\"survey_id\":\"52\",\"cruise\":\"200201\",\"haul\":\"3\",\"stratum\":\"721\",\"station\":\"305-65\",\"vessel_name\":\"Vesteraalen\",\"vessel_id\":\"94\",\"date_time\":\"5/17/2002 12:36:49 PM\",\"latitude_dd\":\"53.81554\",\"longitude_dd\":\"-167.1349\",\"species_code\":\"40500\",\"common_name\":\"jellyfish unid.\",\"scientific_name\":\"Scyphozoa\",\"taxon_confidence\":\"High\",\"cpue_kgha\":\"0.011138\",\"cpue_kgkm2\":\"1.113816\",\"cpue_kg1000km2\":null,\"cpue_noha\":\"0.397791\",\"cpue_nokm2\":\"39.779143\",\"cpue_no1000km2\":\"39779.143016\",\"weight_kg\":\"0.028\",\"count\":\"1\",\"bottom_temperature_c\":\"5\",\"surface_temperature_c\":\"5.3\",\"depth_m\":\"41\",\"distance_fished_km\":\"1.742\",\"net_width_m\":\"14.431\",\"net_height_m\":\"8.422\",\"area_swept_ha\":\"2.51388019999999\",\"duration_hr\":\"0.33\",\"tsn\":null,\"ak_survey_id\":25,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/25\"}]}],\"hasMore\":true,\"limit\":25,\"offset\":0,\"count\":25,\"links\":[{\"rel\":\"self\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/\"},{\"rel\":\"edit\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/\"},{\"rel\":\"describedby\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/metadata-catalog/afsc_groundfish_survey/\"},{\"rel\":\"first\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/\"},{\"rel\":\"next\",\"href\":\"https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/?offset=25\"}]}"

``` r
data <- jsonlite::fromJSON(base::rawToChar(res$content))
# names(data)
head(data$items, 3)
```

    ##   year srvy                               survey survey_id cruise haul stratum
    ## 1 2002   AI Aleutian Islands Bottom Trawl Survey        52 200201    2     722
    ## 2 2002   AI Aleutian Islands Bottom Trawl Survey        52 200201    2     722
    ## 3 2002   AI Aleutian Islands Bottom Trawl Survey        52 200201    2     722
    ##   station vessel_name vessel_id             date_time latitude_dd longitude_dd
    ## 1  303-64 Vesteraalen        94 5/17/2002 10:20:08 AM    53.79037    -167.2581
    ## 2  303-64 Vesteraalen        94 5/17/2002 10:20:08 AM    53.79037    -167.2581
    ## 3  303-64 Vesteraalen        94 5/17/2002 10:20:08 AM    53.79037    -167.2581
    ##   species_code         common_name        scientific_name taxon_confidence
    ## 1        68560         Tanner crab    Chionoecetes bairdi             High
    ## 2        66031 Alaskan pink shrimp          Pandalus eous         Moderate
    ## 3        72500       Oregon triton Fusitriton oregonensis             High
    ##   cpue_kgha cpue_kgkm2 cpue_kg1000km2 cpue_noha cpue_nokm2 cpue_no1000km2
    ## 1  0.010185   1.018504             NA  0.424377  42.437674   42437.674334
    ## 2  0.016975   1.697507             NA  2.970637  297.06372  297063.720338
    ## 3  0.018673   1.867258             NA  0.424377  42.437674   42437.674334
    ##   weight_kg count bottom_temperature_c surface_temperature_c depth_m
    ## 1     0.024     1                  4.1                     5     164
    ## 2      0.04     7                  4.1                     5     164
    ## 3     0.044     1                  4.1                     5     164
    ##   distance_fished_km net_width_m net_height_m area_swept_ha duration_hr tsn
    ## 1              1.488      15.836        7.159     2.3563968        0.27  NA
    ## 2              1.488      15.836        7.159     2.3563968        0.27  NA
    ## 3              1.488      15.836        7.159     2.3563968        0.27  NA
    ##   ak_survey_id
    ## 1            1
    ## 2            2
    ## 3            3
    ##                                                                                  links
    ## 1 self, https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/1
    ## 2 self, https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/2
    ## 3 self, https://origin-tst-ods-st.fisheries.noaa.gov/ods/foss/afsc_groundfish_survey/3

### Subset data

Here we subset the data for the 2018 Aleutian Islands Bottom Trawl
Survey

``` r
res <- httr::GET(api_link, query = list(srvy = "EBS", year = 2018))
data <- jsonlite::fromJSON(base::rawToChar(res$content))
x <- data$items
x <- x[,c("stratum", "station", "vessel_name", "latitude_dd", "longitude_dd", 
          "species_code", "common_name", "scientific_name", "taxon_confidence", 
          "cpue_kgha", "cpue_noha", "weight_kg", "count", 
          "bottom_temperature_c", "surface_temperature_c", "depth_m")]
head(x, 3)
```

    ##   stratum station vessel_name latitude_dd longitude_dd species_code
    ## 1     722  303-64 Vesteraalen    53.79037    -167.2581        68560
    ## 2     722  303-64 Vesteraalen    53.79037    -167.2581        66031
    ## 3     722  303-64 Vesteraalen    53.79037    -167.2581        72500
    ##           common_name        scientific_name taxon_confidence cpue_kgha
    ## 1         Tanner crab    Chionoecetes bairdi             High  0.010185
    ## 2 Alaskan pink shrimp          Pandalus eous         Moderate  0.016975
    ## 3       Oregon triton Fusitriton oregonensis             High  0.018673
    ##   cpue_noha weight_kg count bottom_temperature_c surface_temperature_c depth_m
    ## 1  0.424377     0.024     1                  4.1                     5     164
    ## 2  2.970637      0.04     7                  4.1                     5     164
    ## 3  0.424377     0.044     1                  4.1                     5     164

## Metadata

### Data Description:

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

### Bottom Trawl Surveys and Regions

**Eastern Bering Sea Shelf (EBS)**

-   Annual
-   Fixed stations at center of 20 x 20 nm grid

**Northern Bering Sea (NBS)**

-   Biennial/Annual
-   Fixed stations at center of 20 x 20 nm grid

**Eastern Bering Sea Slope (BSS)**

-   Intermittent (funding dependent)
-   Modified Index-Stratified Random of Successful Stations Survey
    Design

**Aleutian Islands (AI)**

-   Triennial (1990s)/Biennial since 2000 in even years
-   Modified Index-Stratified Random of Successful Stations Survey
    Design

**Gulf of Alaska (GOA)**

-   Triennial (1990s)/Biennial since 2001 in odd years
-   Stratified Random Survey Design

### User Resources:

About AFSC’s Resource Assessment and Conservation Engineering Division.
For more information about species codes, please refer to the Groundfish
Species Codebook. Learn more about the [Research Surveys conducted at
AFSC](https://www.fisheries.noaa.gov/alaska/ecosystems/alaska-fish-research-surveys),
these surveys from [past
reports](http://apps-afsc.fisheries.noaa.gov/RACE/surveys/cruise_results.htm),
and [GitHub
repository](https://github.com/afsc-gap-products/gap_public_data).

### Access Constraints:

There are no legal restrictions on access to the data. They reside in
public domain and can be freely distributed.

**User Constraints:** Users must read and fully comprehend the metadata
prior to use. Data should not be used beyond the limits of the source
scale. Acknowledgement of AFSC Groundfish Assessment Program, as the
source from which these data were obtained, in any publications and/or
other representations of these data, is suggested. Contact Us with

**Address:**

National Oceanic and Atmospheric Administration (NOAA)  
Alaska Fisheries Science Center (AFSC)  
Resource Assessment and Conservation Engineering Division (RACE)  
Groundfish Assessment Program (GAP) 7600 Sand Point Way, N.E. bldg. 4  
Seattle, WA 98115 USA

**General questions** **and more specific data requests** can be sent to
<afsc.gap.metadata@noaa.gov> or submitted as an [issue on our GitHub
Organization.](https://github.com/afsc-gap-products/data-requests) . The
version of this data used for stock assessments can be found through the
Alaska Fisheries Information Network (AKFIN). For questions about the
eastern Bering Sea surveys, contact Duane Stevenson
(<Duane.Stevenson@noaa.gov>). For questions about the Gulf of Alaska or
Aleutian Islands surveys, contact Ned Laman (<Ned.Laman@noaa.gov>). For
questions specifically about crab data in any region, contact Mike
Litzow (<mike.litzow@noaa.gov>), the Shellfish Assessment Program lead.

For questions, comments, and concerns specifically about the FOSS
platform, please contact us using the Comments page on the FOSS page.

### Column-level metadata

| Column name from data | Descriptive Column Name | Units            | Description                                                                                                                                                                                                                                                                                                                                                                                                 |
|:--|:--|:---|:--------------------------------------------------------------|
| year                  | Year                    | numeric          | Year the survey was conducted in.                                                                                                                                                                                                                                                                                                                                                                           |
| srvy                  | Survey                  | Abbreviated text | Abbreviated survey names. The column ‘srvy’ is associated with the ‘survey’ and ‘survey_id’ columns. Northern Bering Sea (NBS), Southeastern Bering Sea (EBS), Bering Sea Slope (BSS), Gulf of Alaska (GOA), Aleutian Islands (AI). survey Survey text Name and description of survey. The column ‘survey’ is associated with the ‘srvy’ and ‘survey_id’ columns.                                           |
| survey_id             | Survey ID               | ID code          | This number uniquely identifies a survey. Name and description of survey. The column ‘survey_id’ is associated with the ‘srvy’ and ‘survey’ columns. For a complete list of surveys go to <https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>                                                                                                    |
| cruise                | Cruise ID               | ID code          | This is a six-digit number identifying the cruise number of the form: YYYY99 (where YYYY = year of the cruise; 99 = 2-digit number and is sequential; 01 denotes the first cruise that vessel made in this year, 02 is the second, etc.) haul Haul Number ID code This number uniquely identifies a sampling event (haul) within a cruise. It is a sequential number, in chronological order of occurrence. |
| stratum               | Stratum ID              | ID Code          | RACE database statistical area for analyzing data. Strata were designed using bathymetry and other geographic and habitat-related elements. The strata are unique to each survey series. Stratum of value 0 indicates experimental tows. station Station ID ID code Alpha-numeric designation for the station established in the design of a survey.                                                        |
| vessel_id             | Vessel ID               | ID Code          | ID number of the vessel used to collect data for that haul. The column ‘vessel_id’ is associated with the ‘vessel_name’ column. Note that it is possible for a vessel to have a new name but the same vessel id number.                                                                                                                                                                                     |

For a complete list of vessel ID codes:
<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>
\| \|vessel_name \|Vessel Name \|text \|Name of the vessel used to
collect data for that haul. The column ‘vessel_name’ is associated with
the ‘vessel_id’ column. Note that it is possible for a vessel to have a
new name but the same vessel id number.

For a complete list of vessel ID codes:
<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>
\| \|date_time \|Date and Time of Haul \|MM/DD/YYYYHH::MM \|The date
(MM/DD/YYYY) and time (HH:MM) of the beginning of the haul. \|
\|longitude_dd \|Longitude (decimal degrees) \|decimal degrees, 1e-05
resolution \|Longitude (one hundred thousandth of a decimal degree) of
the start of the haul. \| \|latitude_dd \|Latitude (decimal degrees)
\|decimal degrees, 1e-05 resolution \|Latitude (one hundred thousandth
of a decimal degree) of the start of the haul. \| \|species_code \|Taxon
Code \|ID code \|The species code of the organism associated with the
‘common_name’ and ‘scientific_name’ columns. For a complete species list
go to
<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>
\| \|common_name \|Taxon Common Name \|text \|The common name of the
marine organism associated with the ‘scientific_name’ and ‘species_code’
columns. For a complete species list go to
<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>
\| \|scientific_name \|Taxon Scientific Name \|text \|The scientific
name of the organism associated with the ‘common_name’ and
‘species_code’ columns. For a complete taxon list go to
<https://www.fisheries.noaa.gov/resource/document/groundfish-survey-species-code-manual-and-data-codes-manual>
\| \|taxon_confidence \|Taxon Confidence Rating \|rating \|Confidence in
the ability of the survey team to correctly identify the taxon to the
specified level, based solely on identification skill (e.g., not
likelihood of a taxon being caught at that station on a
location-by-location basis). Quality codes follow:

‘High’: High confidence and consistency. Taxonomy is stable and reliable
at this level, and field identification characteristics are well known
and reliable.

‘Moderate’: Moderate confidence. Taxonomy may be questionable at this
level, or field identification characteristics may be variable and
difficult to assess consistently.

‘Low’: Low confidence. Taxonomy is incompletely known, or reliable field
identification characteristics are unknown.

Species identification confidence in the eastern Bering Sea shelf survey
(1982-2008):
<http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2009-04.pdf>

Species identification confidence in the eastern Bering Sea slope survey
(1976-2010):
<http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-05.pdf>

Species identification confidence in the Gulf of Alaska and Aleutian
Islands surveys (1980-2011):
<http://apps-afsc.fisheries.noaa.gov/Publications/ProcRpt/PR2014-01.pdf>
\| \|cpue_kgha \|Weight CPUE (kg/ha) \|kilograms/hectare \|Relative
Density. Catch weight (kilograms) divided by area (hectares) swept by
the net. \| \|cpue_kgkm2 \|Weight CPUE (kg/km^2)
\|kilograms/kilometers^2 \|Relative Density. Catch weight (kilograms)
divided by area (squared kilometers) swept by the net. \|
\|cpue_kg1000km2 \|Weight CPUE (kg/1,000 km^2) \|kilograms/1000
kilometers^2 \|Relative Density. Catch weight (kilograms) divided by
area (thousand square kilometers) swept by the net. \| \|cpue_noha
\|Number CPUE (no./ha) \|count/hectare \|Relative Abundance. Catch
number (in number of organisms) per area (hectares) swept by the net. \|
\|cpue_nokm2 \|Number CPUE (no./km^2) \|count/kilometers^2 \|Relative
Abundance. Catch number (in number of organisms) per area (squared
kilometers) swept by the net. \| \|cpue_no1000km2 \|Number CPUE
(no./1,000 km^2) \|count/1000 kilometers^2 \|Relative Abundance. Catch
weight (in number of organisms) divided by area (thousand square
kilometers) swept by the net. \| \|weight_kg \|Taxon Weight (kg)
\|kilograms, thousandth resolution \|Weight (thousandths of a kilogram)
of individuals in a haul by taxon. \| \|count \|Taxon Count \|count,
whole number resolution \|Total number of individuals caught in haul by
taxon, represented in whole numbers. \| \|bottom_temperature_c \|Bottom
Temperature (Degrees Celsius) \|degrees Celsius, tenths of a degree
resolution \|Bottom temperature (tenths of a degree Celsius); NA
indicates removed or missing values. \| \|surface_temperature_c
\|Surface Temperature (Degrees Celsius) \|degrees Celsius, tenths of a
degree resolution \|Surface temperature (tenths of a degree Celsius); NA
indicates removed or missing values. \| \|bottom_temperature_c \|Bottom
Temperature (Degrees Celsius) \|degrees Celsius, tenths of a degree
resolution \|Bottom temperature (tenths of a degree Celsius); NA
indicates removed or missing values. \| \|depth_m \|Depth (m) \|meters,
tenths of a meter resolution \|Bottom depth (tenths of a meter). \|
\|distance_fished_km \|Distance Fished (km) \|kilometers, thousandths of
kilometer resolution \|Distance the net fished (thousandths of
kilometers). \| \|net_width_m \|Net Width (m) \|meters \|Measured or
estimated distance (meters) between wingtips of the trawl. \|
\|net_height_m \|Net Height (m) \|meters \|Measured or estimated
distance (meters) between footrope and headrope of the trawl. \|
\|area_swept_ha \|Area Swept (ha) \|hectares \|The area the net covered
while the net was fishing (hectares), defined as the distance fished
times the net width. \| \|duration_hr \|Tow Duration (decimal hr)
\|decimal hours \|This is the elapsed time between start and end of a
haul (decimal hours). \|

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
