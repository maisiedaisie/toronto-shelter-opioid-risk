# Figure 1: Shelter Sites and Scaled Overdose Locations
ggplot() +
    geom_sf(data = neighbourhoods, fill = "white", color = "black") +
    geom_sf(data = overdoses_sf, aes(size = OD_COUNT), color = "pink1", alpha = 0.7) +
    geom_sf(data = shelters_sf, color = "palegreen2", shape = 4, size = 3) +
    theme_minimal() +
    labs(title = "Opioid Toxicity Events and Shelter Locations in Toronto, 2025",
    size = "Number of Suspected Opioid Poisonings")

# Figure 2: Proximal toxicity events for shelter sites
ggplot() +
  geom_sf(data = neighbourhoods, fill = NA, color = "gray", size = 0.25) +
  geom_sf(data = shelter_total, aes(size = total_overdoses, color = total_overdoses),
          shape = 21, fill = "white", stroke = 0.5, alpha = 0.7) +
  scale_size_continuous(range = c(2, 10)) +  
  scale_color_viridis() +
  theme_minimal() +
  labs(title = "Toronto Shelter Sites Proximal to Opioid Poisonings, 2025",
       color = "Poisoning Event Count",
       size = "Poisoning Event Count") + # There's something really weird going on with this legend. It should be circles.
  theme(legend.position = "bottom",
        axis.title.x = element_text(size = 12),
        axis.title.y = element_text(size = 12)) +
  xlab("Longitude") +
  ylab("Latitude")
