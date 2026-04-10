# Data Notes
## Data Sources
1. Toronto Public Health. Toronto Overdose Information System [dataset]. Toronto, ON: City of Toronto; 2020 Feb 8 [updated 2026 Mar 30; cited 2026 Apr 8]. Available from: https://www.toronto.ca/community-people/health-wellness-care/health-inspections-monitoring/toronto-overdose-information-system/ 
2. City of Toronto. Intersection File - City of Toronto [data file]. Toronto; ON: City of Toronto; c2026 [updated 2026 Apr 8; cited 2026 Apr 8]. Available from: https://open.toronto.ca/dataset/intersection-file-city-of-toronto/ 
3. Toronto Shelter & Support Services. Toronto Shelter System Flow [data file]. Toronto, ON: City of Toronto; 2021 Nov 15 [updated 2026 Mar 17; cited 2026 Apr 8]. Available from: https://open.toronto.ca/dataset/toronto-shelter-system-flow/ 
4. City of Toronto. Regional Municipal Boundary [data file]. Toronto, ON: City of Toronto; 2012 Sep 13 [updated 2019 Jul 23; cited 2026 Apr 8]. Available from: https://open.toronto.ca/dataset/regional-municipal-boundary/ 
5. Statistics Canada. 2021 Census of Population. Ottawa, ON: Statistics Canada; c2021. 

## Notes
* Intersection-linked data for Toronto Paramedic Services calls are available from January 1, 2025 to December 31, 2025. 
* Data for intersections with fewer than 5 calls for suspected opioid toxicity events are not included. 
  * In 2025, Toronto Paramedic Services responded to 2,747 non-fatal suspected opioid toxicity events and 126 fatal suspected opioid toxicity events. Only 1,991 events have geographic information available. This represents an underreporting of 30.7%, assuming perfect discrimination between fatal and non-fatal events. 2,720 events have information associated with their Neighbourhood, representing an underreporting of 5.3%, assuming perfect discrimination between fatal and non-fatal events. 
* Only shelters that were operating on the night of April 9, 2026 were included in the dataset. 
* Shelters were geocoded into WGS84 (ESPG: 4326) using Geocodio. The NAD83 / UTM Zone 17 projection (ESPG: 26917) was used for analysis. 
* Suspected opioid toxicity events were considered “near a shelter” if they were within a radius of 200 metres from the shelter. 
