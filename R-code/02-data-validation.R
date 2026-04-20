# toronto-shelter-opioid-risk
# Version 0.1.0 (St. Andrew)
# Release: 2026-04-20

# File 2: "02-data-validation.R"

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

# This code is broken up into 5 files. This is file 2 of 5. 

# NOTES ========================================================================
# This file validates the creation of objects from "01-data-environment.R". It 
# is designed to throw an error that corresponds to the specific step if the 
# code fails at any point. The expected outcome of this validation is no outcome. 
# This code should not produce any output, and any failure will be loud. 

################################################################################

# Validate dataframe extraction from CSV files =================================
stopifnot(nrow(opioid_poisonings) > 0)
stopifnot(nrow(street_junctions) > 0)
stopifnot(nrow(shelter_sites) > 0)
stopifnot(nrow(ct_populations) > 0)

# Validate the presence of elements required for joins -------------------------
required_cols <- c("OBJECTID")
stopifnot(all(required_cols %in% names(opioid_poisonings)))
stopifnot(all(required_cols %in% names(street_junctions)))

stopifnot(all(c("LON", "LAT") %in% names(shelter_sites)))

stopifnot("CTNAME" %in% names(ct_populations))

# Validate extraction of coordinate data from "street_junctions" ===============
sum(is.na(street_junctions$lon)) # longitude should fall within ~(-80, -79)
sum(is.na(street_junctions$lat)) # latitude should fall within ~(43, 44)

stopifnot(all(!is.na(street_junctions$lon)))
stopifnot(all(!is.na(street_junctions$lat)))

# Validate the join of "opioid_poisonings" and "street_junctions" ==============
# Validate that all event sites have been included -----------------------------
n_before <- nrow(opioid_poisonings)
n_after  <- nrow(opioid_poisonings_joined)

stopifnot(n_before == n_after)

# Validate that coordinates have been properly attached to event sites ---------
sum(is.na(opioid_poisonings_joined$lon))
stopifnot(all(!is.na(opioid_poisonings_joined$lon)))

# Validate shapefile geometries ================================================
stopifnot(inherits(opioid_poisonings_sf, "sf"))
stopifnot(inherits(shelter_sites_sf, "sf"))

sum(!sf::st_is_valid(opioid_poisonings_sf))
sum(!sf::st_is_valid(shelter_sites_sf))

# Validate the assignment of the new CRS in NAD83 / UTM zone 17 format =========
target_crs <- 26917

stopifnot(st_crs(opioid_poisonings_sf)$epsg == target_crs)
stopifnot(st_crs(shelter_sites_sf)$epsg == target_crs)
stopifnot(st_crs(neighbourhoods_sf)$epsg == target_crs)

# Validate the final Toronto census tract dataframe ============================
# Validate that Toronto census tracts have not been removed --------------------
stopifnot(nrow(toronto_tracts_sf) > 0) # The clip should not remove everything

# Validate the attachment of population counts to the census tracts ------------
missing_pop <- sum(is.na(toronto_tracts_sf$POPULATION_2021))

# This code will print the names of any census tracts with missing population data
if (missing_pop > 0) {
  stop(paste("Missing population data for", missing_pop, "census tracts"))
}

# Validate the CRS of the final "toronto_tracts_sf" dataframe ------------------
stopifnot(st_crs(toronto_tracts_sf)$epsg == target_crs)

# Validate that all poisoning event fall within the Toronto boundary -----------
inside <- st_within(opioid_poisonings_sf, city_boundary_sf, sparse = FALSE)

if (any(!inside)) {
  stop("Some opioid poisoning points fall outside Toronto boundary")
}

# Remove temporary objects used for validation ==================================
rm(n_before, n_after, target_crs, missing_pop, inside)
gc()

#################################################################################

# End of file 2 =================================================================

#################################################################################