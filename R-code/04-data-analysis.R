# toronto-shelter-opioid-risk
# Version 0.1.0 (St. Andrew)
# Release: 2026-04-20

# File 4: "04-statistical-analysis.R"

################################################################################

# PREAMBLE =====================================================================
# This code reproduces the analysis found in the paper "Ecological Risk of Opioid
# Poisonings Proximal to Toronto Shelters for People Experiencing Homelessness" 
# and its resulting shorter reports. 

# Code was developed by Maisie Davis (E-mail: maisie.davis@alumni.utoronto.ca, 
# GitHub: /maisiedaisie). 

# The repository for this project is: 
# https://github.com/maisiedaisie/toronto-shelter-opioid-risk
# You can report issues on GitHub or by e-mailing Maisie. 

# This code is broken up into 5 files. This is file 4 of 5. 

# Notes ========================================================================
# For clarity and ease of analysis, code for analyzing sites at 200m and 500m 
# have been divided into two separate sections, divided by hashmarks (#).


################################################################################

# Setup ========================================================================
# Load packages ----------------------------------------------------------------
library(MASS)
library(sf)
library(tidyverse)
# library(terra)


# Set the seed for random number generation ------------------------------------
set.seed(16) # I picked this number because I liked it-it doesn't really matter.

################################################################################

# Statistical analysis: 200 metre buffer threshold =============================
# Find the intersection of census tracts and shelter buffer zones --------------
# Create a minimalist file with shelter names, counts, and buffer geometries
shelters_joined_200m <- st_drop_geometry(shelters_joined_200m)
buffer_join_200m_sf  <- left_join(buffer_200m_sf, shelters_joined_200m, 
  by = c("OPERATING_AGENCY", "PROGRAM_SITE", "STREET_ADDRESS", "POSTAL_CODE",
  "POPULATION", "CAPACITY_TYPE", "CAPACITY_BEDS", "CAPACITY_ROOMS",
  "PROGRAMS_ON_SITE", "LON", "LAT")
  )

# Create the intersected shapefile
buffer_join_200m_sf <- st_intersection(buffer_join_200m_sf, toronto_tracts_sf)

# Calculate population estimates for buffer zones from census data -------------
# Find the areas of (1) buffer regions 
buffer_join_200m_sf$AREA_INTERSECTION <- st_area(buffer_join_200m_sf)
toronto_tracts_sf$AREA_TRACT          <- st_area(toronto_tracts_sf)
# The census tract data frame already has an area column, but it is in km^2.
# Using this function with the assigned CRS puts it in m^2.
# Tract areas may not align with the "LAND_AREA" column as only part of the 
# tract may fall within the municipal boundary of the City of Toronto.

# Join areas for calculation 
buffer_join_200m_sf <- buffer_join_200m_sf %>%
                         left_join(
                           toronto_tracts_sf %>%
                              st_drop_geometry() %>%
                           dplyr::select(CTNAME, AREA_TRACT), # Need dplyr spec.
                           by = "CTNAME"
                         )

# Calculate estimated populations as: 2021 population x (buffer area/tract area) 
# Note that this assumes an even population distribution within a tract which is
# a common assumption in spatial epidemiology for cities, though it may not be 
# true in actual fact. 
buffer_join_200m_sf <- buffer_join_200m_sf %>%
    mutate(
        BUFFER_POP = POPULATION_2021 * 
            (AREA_INTERSECTION / AREA_TRACT)
    )

# Note that "buffer_pop" is the dataframe containing values from 
# "buffer_join_200m_sf$BUFFER_POP" aggregated by shelter
buffer_pop_200m <- buffer_join_200m_sf %>% 
                     group_by(PROGRAM_SITE) %>%
                     summarize(BUFFER_POP = sum(BUFFER_POP, na.rm = TRUE))
# This will output a "buffer_pop" shapefile with geometry, estimated population,
# and the shelter site to which the buffer belongs.

# This will be the population set used to estimate the background/expected
# rate of opioid poisonings in an area. 

# Estimate the background rate of opioid poisonings in each buffer area --------
background_risk_200m <- sum(buffer_join_200m_sf$total_overdoses, na.rm = TRUE) / 
                        sum(buffer_join_200m_sf$BUFFER_POP, na.rm = TRUE)

# Estimate the actual per-shelter risk (SIR) of opioid poisoning events --------
shelter_risk_200m <- shelters_joined_200m %>% # Regular data.frame class object
                       full_join(buffer_pop_200m, by = "PROGRAM_SITE") %>%
                       mutate(
                         expected_overdoses = BUFFER_POP * background_risk_200m,
                         SIR = total_overdoses / expected_overdoses
                        )

################################################################################

# Statistical analysis: 500 metre buffer threshold =============================
# Find the intersection of census tracts and shelter buffer zones --------------
# Create a minimalist file with shelter names, counts, and buffer geometries
shelters_joined_500m <- st_drop_geometry(shelters_joined_500m)
buffer_join_500m_sf  <- left_join(buffer_500m_sf, shelters_joined_500m, 
  by = c("OPERATING_AGENCY", "PROGRAM_SITE", "STREET_ADDRESS", "POSTAL_CODE",
  "POPULATION", "CAPACITY_TYPE", "CAPACITY_BEDS", "CAPACITY_ROOMS",
  "PROGRAMS_ON_SITE", "LON", "LAT")
  )

# Create the intersected shapefile
buffer_join_500m_sf <- st_intersection(buffer_join_500m_sf, toronto_tracts_sf)

# Calculate population estimates for buffer zones from census data -------------
# Find the areas of (1) buffer regions 
buffer_join_500m_sf$AREA_INTERSECTION <- st_area(buffer_join_500m_sf)
toronto_tracts_sf$AREA_TRACT          <- st_area(toronto_tracts_sf)
# The census tract data frame already has an area column, but it is in km^2.
# Using this function with the assigned CRS puts it in m^2.
# Tract areas may not align with the "LAND_AREA" column as only part of the 
# tract may fall within the municipal boundary of the City of Toronto.

# Join areas for calculation 
buffer_join_500m_sf <- buffer_join_500m_sf %>%
                         left_join(
                           toronto_tracts_sf %>%
                              st_drop_geometry() %>%
                           dplyr::select(CTNAME, AREA_TRACT), # Need dplyr spec.
                           by = "CTNAME"
                         )

# Calculate estimated populations as: 2021 population x (buffer area/tract area) 
# Note that this assumes an even population distribution within a tract which is
# a common assumption in spatial epidemiology for cities, though it may not be 
# true in actual fact. 
buffer_join_500m_sf <- buffer_join_500m_sf %>%
    mutate(
        BUFFER_POP = POPULATION_2021 * 
            (AREA_INTERSECTION / AREA_TRACT)
    )

# Note that "buffer_pop" is the dataframe containing values from 
# "buffer_join_500m_sf$BUFFER_POP" aggregated by shelter
buffer_pop_500m <- buffer_join_500m_sf %>% 
                     group_by(PROGRAM_SITE) %>%
                     summarize(BUFFER_POP = sum(BUFFER_POP, na.rm = TRUE))
# This will output a "buffer_pop_500m" shapefile with geometry, estimated population,
# and the shelter site to which the buffer belongs.

# This will be the population set used to estimate the background/expected
# rate of opioid poisonings in an area. 

# Estimate the background rate of opioid poisonings in each buffer area --------
background_risk_500m <- sum(buffer_join_500m_sf$total_overdoses, na.rm = TRUE) / 
                        sum(buffer_join_500m_sf$BUFFER_POP, na.rm = TRUE)

# Estimate the actual per-shelter risk (SIR) of opioid poisoning events --------
shelter_risk_500m <- shelters_joined_500m %>% # Regular data.frame class object
                       full_join(buffer_pop_500m, by = "PROGRAM_SITE") %>%
                       mutate(
                         expected_overdoses = BUFFER_POP * background_risk_500m,
                         SIR = total_overdoses / expected_overdoses
                        )

# Create a Poisson distribution to model risk ----------------------------------
# Clean the data by removing units for analysis
shelter_model_500m <- shelter_risk_500m

shelter_model_500m <- shelter_risk_500m %>%
                        st_drop_geometry() %>%
                          mutate(
                            total_overdoses = as.numeric(total_overdoses),
                            pop_buffer = as.numeric(BUFFER_POP)
                          )
# Fit the Poisson model
