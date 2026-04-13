################
# Define the 200 metre buffer region for each shelter site

# Count the number of overdoses in each buffer
buffer_count <- st_intersection(shelter_buffer, overdoses_sf)

shelter_count <- buffer_count %>%
    group_by(PROGRAM_SITE) %>%
    summarize(total_overdoses = sum(OD_COUNT, na.rm = TRUE)) # Aggregates all overdoses that intersect to the shelter in one row. 

# Rank shelter sites by the number of proximal overdose events
shelter_count <- shelter_count %>%
    mutate(rank = min_rank(desc(total_overdoses))) # Contains only sites with overdoses within the buffer

## Attach ranks back to the full shelter dataframe, assign 0 values to the count for sites with no events instead of NA
shelters_joined <- shelters_sf %>%
  st_drop_geometry() %>%              
  left_join(shelter_count, by = "PROGRAM_SITE") %>%
  mutate(
    total_overdoses = coalesce(total_overdoses, 0),
    rank = min_rank(desc(total_overdoses))
  ) %>%
  st_as_sf()

# Print output of this step to CSV (optional)
# write.csv(shelter_count, "shelter_opioid_event_ranks.csv") # Only sites with overdoses within 200 metres
# write.csv(
#  st_drop_geometry(shelters_joined),
#  "shelters_joined.csv",
#  row.names = FALSE
# ) # All shelter sites

################
