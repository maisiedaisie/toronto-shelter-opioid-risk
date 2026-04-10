################
## 2-raw-analysis.R ##
################
#### ---- 3. Ranking shelters by raw overdose count ---- ####
## -- 3.1 Define a buffer zone for each shelter site -- ##
shelter_buffer   <- st_buffer(shelters_sf, dist = 200) # Change the value '200' to define another buffer radius. The buffer radius is measured in metres.

## -- 3.2 Count the number of overdoses within each buffer zone -- ##
ods_in_buffer <- st_intersection(x = shelter_buffer, y = overdoses_sf) # Finds all intersections within a shelter's buffer zone.
shelter_total <- ods_in_buffer %>%
    group_by(PROGRAM_SITE) %>%
    summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) # Aggregates all overdoses that intersect to the shelter in one row. 

## -- 3.3 Rank shelters by number of proximal overdoses -- ##
shelter_total <- shelter_total %>%
    mutate(rank = dense_rank(desc(total_overdoses))) # Allows ties without skips, may need to fix.

shelter_rank <- shelters_sf %>%
    st_join(shelter_total, by = "PROGRAM_SITE")

shelter_rank # Prints the ranked list of shelters.
