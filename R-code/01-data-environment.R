# toronto-shelter-opioid-risk
# Version 0.1.0 (St. Andrew)
# Release: 2026-04-20

# File 1: "01-data-environment.R"

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

# This code is broken up into 5 files. This is file 1 of 5. 

# DATA FILES AND SOURCES =======================================================
# A list of files and data sources (including external datasources not included 
# in the repository by default) can be found in the README and setup guides 
# in the repository (README.md, QUICKSTART.md, FULLSETUP.md)

# Notes ========================================================================
# This code assumes that you have already set the working directory to the 
# project folder. Filepaths are relative to the main working directory. 

################################################################################

# Load packages and dataframes from raw files ==================================
library(jsonlite)
library(sf)
library(tidyverse)

opioid_poisonings    <- read.csv("data-files/toronto-ems-calls-suspected-overdose-2025-by-intersection.csv")
opioid_neighbourhood <- read.csv("data-files/tpas-suspected-overdose-2025-by-neighbourhood.csv")
street_junctions     <- read.csv("Centreline Intersection - 4326.csv") # EPSG: 4326
shelter_sites        <- read.csv("data-files/toronto-shelter-sites-apr26.csv")
ct_populations       <- read.csv("data-files/toronto-census-tract-populations-2021.csv", 
                                 colClasses = c(CTNAME = "character")) 
# The "colClasses" argument ensures that census tract names are read as character 
# strings, rather than numbers (e.g., CT 0001.00 is read as "0001.00" instead of "1")

city_boundary_sf  <- st_read("toronto-boundary-wgs84/citygcs_regional_mun_wgs84.shp") # EPSG: 4326
neighbourhoods_sf <- st_read("Neighbourhoods - 4326/Neighbourhoods - 4326.shp")      # EPSG: 4326
census_tracts_sf  <- st_read("lct_000a21a_e/lct_000a21a_e.shp")              # EPSG: 3347

# Create shapefiles =============================================================
# Create the shapefile for geocoded opioid poisoning events ---------------------
# Extract coordinates from JSON geometry in "street_junctions$geometry"
# "geometry" is a JSON-format string containing [longitude, latitude]
CoordsList <- lapply(street_junctions$geometry, function(g) {
  jsonlite::fromJSON(g)$coordinates
})

CoordsMatrix <- do.call(rbind, CoordsList)

street_junctions$lon <- CoordsMatrix[,1]
street_junctions$lat <- CoordsMatrix[,2]

# Join the "opioid_poisonings" and "street_junctions" dataframes for geocoding
# "OBJECTID" is a unique code assigned to each intersection in both dataframes
opioid_poisonings_joined <- left_join(opioid_poisonings, street_junctions, by = "OBJECTID")

# Create "opioid_poisonings_sf"
opioid_poisonings_sf <- st_as_sf(opioid_poisonings_joined, 
                                 coords = c("lon", "lat"),
                                 remove = FALSE,
                                 crs = 4326) # Matches street_junctions CRS (WGS84)


# Create the shapefile for shelter sites
shelter_sites_sf <- st_as_sf(shelter_sites,
                             coords = c("LON", "LAT"),
                             remove = FALSE, 
                             crs = 4326) # Matches shelter_sites CRS (WGS84)

# Align the CRS of all shapefiles -----------------------------------------------

# Set CRS to EPSG: 26917 (NAD83 / UTM Zone 17N, designed for Ontario)
# The NAD83 / UTM zone 17 projection is used for accuracy of distance measurement
# All distances are measured in metres

opioid_poisonings_sf <- st_transform(opioid_poisonings_sf, crs = 26917)
shelter_sites_sf     <- st_transform(shelter_sites_sf, crs = 26917)
city_boundary_sf     <- st_transform(city_boundary_sf, crs = 26917)
neighbourhoods_sf    <- st_transform(neighbourhoods_sf, crs = 26917)
census_tracts_sf     <- st_transform(census_tracts_sf, crs = 26917)

# Clip the census tracts shapefile using Toronto information --------------------
toronto_tracts_sf <- st_intersection(census_tracts_sf, city_boundary_sf)
toronto_tracts_sf <- st_simplify(toronto_tracts_sf, dTolerance = 5)

# Please note:
# All census tracts belong to the "Toronto, City" CSD, as defined by StatCan's
# administrative boundaries. Minor mismatches in geometry may occur for CTs bordering
# other municipalities/CSDs or Lake Ontario. This results in differences between strict
# spatial containment ("st_within") and more inclusive spatial relationships
# ("st_intersects"). This analysis uses "st_intersects()" as it better reflects the
# intended spatial relationships in the study design.

rm(census_tracts_sf) # Removing the large object improves performance
gc()

toronto_tracts_sf <- left_join(toronto_tracts_sf, ct_populations, by = "CTNAME")

# Join opioid toxicity events to neighbourhoods shapefile -----------------------
# "AREA_NA7" and "NAME" both represent the neighbourhood name in their dataframes.
# Names are aligned across datasets by official City of Toronto names.
neighbourhoods_sf <- left_join(neighbourhoods_sf, opioid_neighbourhood, 
                               by = c("AREA_NA7" = "NAME"))

sum(is.na(neighbourhoods_sf$some_overdose_column))

#################################################################################

# Outputs =======================================================================
# opioid_poisonings_sf: point data for poisoning locations
# shelter_sites_sf: point data for shelter site locations
# toronto_tracts_sf: polygons for census tracts with linked population data
# neighbourhoods_sf: polygon data for Toronto neighbourhoods with linked poisoning counts

# End of file 1 =================================================================

#################################################################################