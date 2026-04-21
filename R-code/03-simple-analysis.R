# toronto-shelter-opioid-risk
# Version 0.1.0 (St. Andrew)
# Release: 2026-04-20

# File 3: "03-simple-analysis.R"

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

# This code is broken up into 5 files. This is file 3 of 5. 

# Notes ========================================================================


#################################################################################

# Define buffer regions at 200m and 500m ========================================
buffer_200m_sf <- st_buffer(shelter_sites_sf, dist = 200)
buffer_500m_sf <- st_buffer(shelter_sites_sf, dist = 500)

# Count the number of poisonings within each buffer radius ======================
# Check whether events occur within a buffer zone -------------------------------
buffer_count_200m <- st_intersection(buffer_200m_sf, opioid_poisonings_sf)
buffer_count_500m <- st_intersection(buffer_500m_sf, opioid_poisonings_sf)

# Attach events within a buffer to the corresponding shelter site ---------------
shelter_count_200m <- buffer_count_200m %>%
                        group_by(PROGRAM_SITE) %>%
                        summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) 
                        # Aggregates all overdoses that intersect to the shelter in one row. 

shelter_count_500m <- buffer_count_500m %>%
                        group_by(PROGRAM_SITE) %>%
                        summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) 
                        # Aggregates all overdoses that intersect to the shelter in one row. 


# Rank shelter sites by the number of proximal poisoning events ================
# Define buffer regions at 200m and 500m ========================================
buffer_200m_sf <- st_buffer(shelter_sites_sf, dist = 200)
buffer_500m_sf <- st_buffer(shelter_sites_sf, dist = 500)

# Count the number of poisonings within each buffer radius ======================
# Check whether events occur within a buffer zone -------------------------------
buffer_count_200m <- st_intersection(buffer_200m_sf, opioid_poisonings_sf)
buffer_count_500m <- st_intersection(buffer_500m_sf, opioid_poisonings_sf)

# Attach events within a buffer to the corresponding shelter site ---------------
shelter_count_200m <- buffer_count_200m %>%
                        group_by(PROGRAM_SITE) %>%
                        summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) 
                        # Aggregates all overdoses that intersect to the shelter in one row. 

shelter_count_500m <- buffer_count_500m %>%
                        group_by(PROGRAM_SITE) %>%
                        summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) 
                        # Aggregates all overdoses that intersect to the shelter in one row. 


# Rank shelter sites by the number of proximal poisoning events ================
# Create rankings for both buffer radii ----------------------------------------
shelter_count_200m <- shelter_count_200m %>%
                        mutate(rank = min_rank(desc(total_overdoses)))

shelter_count_500m <- shelter_count_500m %>%
                        mutate(rank = min_rank(desc(total_overdoses)))

# These functions only rank sites that have proximal overdoses. Other sites are 
# excluded from the dataframes. 

# Attach ranks back to the full shelter dataframe -------------------------------
shelters_joined_200m <- shelter_sites_sf %>%
                          st_drop_geometry() %>%              
                          left_join(shelter_count_200m, by = "PROGRAM_SITE") %>%
                          mutate(
                            total_overdoses = coalesce(total_overdoses, 0),
                            # Replaces "NA" with values of 0
                            rank = min_rank(desc(total_overdoses))
                          ) %>%
                          st_as_sf() # Returns the object to a shapefile

shelters_joined_500m <- shelter_sites_sf %>%
                          st_drop_geometry() %>%              
                          left_join(shelter_count_500m, by = "PROGRAM_SITE") %>%
                          mutate(
                            total_overdoses = coalesce(total_overdoses, 0),
                            rank = min_rank(desc(total_overdoses))
                          ) %>%
                          st_as_sf()

# Create the output file with ranks and counts for each site ====================
# Temporarily remove the geometry column ----------------------------------------
temporary_200m <- shelter_count_200m %>%
                    st_drop_geometry() %>%
                    rename(
                      overdose_count_200m = total_overdoses,
                      rank_200m = rank
                    )

temporary_500m <- shelter_count_500m %>%
                    st_drop_geometry() %>%
                    rename(
                      overdose_count_500m = total_overdoses,
                      rank_500m = rank
                    )

# Join both dataframes to produce combined list ---------------------------------
joined_list <- full_join(temporary_500m, temporary_200m, by = "PROGRAM_SITE")

# Remove temporary objects ------------------------------------------------------
rm(temporary_200m, temporary_500m)
gc()

# Create the output CSV file ----------------------------------------------------
# Only sites with events within either radius
write.csv(joined_list, "shelter_poisoning_count_ranked.csv")

#################################################################################

# Outputs =======================================================================
# buffer_200m_sf: shapefile with a 200m buffer around each shelter site
# buffer_500m_sf: shapefile with a 500m buffer around each shelter site
# buffer_count_200m: the number of poisoning events within 200m of each shelter
# buffer_count_500m: the number of poisoning events within 500m of each shelter
# shelters_joined_200m: full shelter file with ranks and counts at 200m attached
# shelters_joined-500m: full shelter file with ranks and counts at 500m attached

# shelter_poisoning_count_ranked.csv: printout of the findings of this analysis

# End of file 3 =================================================================

#################################################################################