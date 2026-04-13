################
# FIGURES

# Shelters and overdose locations
ggplot() +
  geom_sf(data = neighbourhoods, fill = "white", color = "black") +
  geom_sf(data = overdoses_sf, aes(size = OD_COUNT), color = "chartreuse2", alpha = 0.5) +
  geom_sf(data = shelters_sf, color = "purple4", size = 0.5) +
  scale_size_continuous(name = "Opioid Poisonings") +
  theme_minimal()

# Shelter buffers and overdose locations (shows which intersections are within which buffers)
ggplot() +
  geom_sf(data = neighbourhoods, fill = "white", color = "black") +
  geom_sf(data = overdoses_sf, color = "chartreuse2", size = 0.2) +
  geom_sf(data = shelter_buffer, color = "purple4", alpha = 0.75) +
  theme_minimal()

# Overdoses by census tract
ods_by_tract <- st_join(overdoses_sf, tracts_joined) %>%
  group_by(CTNAME) %>%
  summarize(total_od = sum(OD_COUNT, na.rm = TRUE))

toronto_tracts_map <- st_join(tracts_joined, ods_by_tract, by = "CTNAME") %>%
  mutate(
    total_od = ifelse(is.na(total_od), 0, total_od),
    od_rate_per_100k = (total_od / POPULATION_2021) * 100000
  )

ggplot(toronto_tracts_map) +
  geom_sf(aes(fill = od_rate_per_100k)) +
  scale_fill_viridis_c(option = "viridis", na.value = "grey90") +
  theme_minimal() +
  labs(fill = "Overdoses per 100,000")

# Shelter risk
ggplot() +
  geom_sf(
    data = neighbourhoods,
    fill = "black",
    color = "white",
    size = 0.08
  ) +
  
  geom_sf(
    data = shelters_joined %>% filter(total_overdoses >= 1),
    aes(fill = total_overdoses),
    shape = 21,       
    color = "white",  
    size = 2,        
    stroke = 0.4,      
    alpha = 0.95
  ) +
  
  scale_fill_viridis_c(option = "viridis", trans = "sqrt") +
  
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  ) +
  
  labs(
    title = "Proximity of Opioid Poisonings to Shelter Sites in Toronto",
    subtitle = "Counts within 200m buffer",
    fill = "Overdoses"
  )
