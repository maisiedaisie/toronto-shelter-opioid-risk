# Figure 1: Shelter Sites and Scaled Overdose Locations
ggplot() +
    geom_sf(data = neighbourhoods, fill = "white", color = "black") +
    geom_sf(data = overdoses_sf, aes(size = OD_COUNT), color = "pink1", alpha = 0.7) +
    geom_sf(data = shelters_sf, color = "palegreen2", shape = 4, size = 3) +
    theme_minimal() +
    labs(title = "Opioid Toxicity Events and Shelter Locations in Toronto, 2025",
    size = "Number of Suspected Opioid Poisonings")
