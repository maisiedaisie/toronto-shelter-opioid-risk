# Data Notes

## Data Sources
1. Toronto Public Health (Surveillance & Epidemiology Unit). Toronto Overdose Information System [Internet]. Toronto, ON: City of Toronto; 2020 Feb 6 [updated 2026 Mar 30, cited 2026 Apr 13]. Available from: [https://public.tableau.com/app/profile/tphseu/viz/TOISDashboard_Final/ParamedicResponse](https://public.tableau.com/app/profile/tphseu/viz/TOISDashboard_Final/ParamedicResponse)

2. Toronto Public Health (Epidemiology & Data Analytics Unit). Calls to paramedic services for suspected opioid overdoses: Geographic information [Internet]. Toronto, ON: City of Toronto; 2026 Jan 9. 9 p. Available from: [https://www.toronto.ca/wp-content/uploads/2020/12/859b-CallsforSuspectedOpioidOverdoses_GeographicInformation.pdf](https://www.toronto.ca/wp-content/uploads/2020/12/859b-CallsforSuspectedOpioidOverdoses_GeographicInformation.pdf)

3. City of Toronto. Intersection File - City of Toronto [Data file]. Toronto, ON: City of Toronto; c2026 [extracted 2026 Apr 8]. Available from: [https://open.toronto.ca/dataset/intersection-file-city-of-toronto/](https://open.toronto.ca/dataset/intersection-file-city-of-toronto/)

4. City of Toronto (Toronto Shelter & Support Services). Daily shelter & overnight service occupancy & capacity [Data file]. Toronto, ON: City of Toronto; 2021 Jun 28 [updated 2026 Apr 8, extracted 2026 Apr 8]. Available from: [https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/](https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/)

5. City of Toronto. Neighbourhoods [Data file]. Toronto, ON: City of Toronto; 2020 Nov 5 [updated 2026 Feb 20, extracted 2026 Apr 10]. Available from: [https://open.toronto.ca/dataset/neighbourhoods/](https://open.toronto.ca/dataset/neighbourhoods/)

6. City of Toronto. Regional municipal boundary [Data file]. Toronto, ON: City of Toronto; 2012 Sep 13 [updated 2019 Jul 23, cited 2026 Apr 8]. Available from[https://open.toronto.ca/dataset/regional-municipal-boundary/](https://open.toronto.ca/dataset/regional-municipal-boundary/)

7. Statistics Canada. 2021 Census of population. Ottawa, ON: Statistics Canada. 

## Technical Notes
* Opioid poisonings were quantified from Toronto Paramedic Services (TPaS) data from January 1, 2025 to December 31, 2025. Data were obtained from aggregated counts by nearest main intersection produced by Toronto Public Health (TPH) through the [Toronto Overdose Information System]((https://public.tableau.com/app/profile/tphseu/viz/TOISDashboard_Final/ParamedicResponse)) (TOIS).

    - "Main intersections" are defined by the City of Toronto.*

    - The nearest main intersection is determined by the location of patient contact by TPaS, rather than the location where the 9-1-1 call originated.*

    - Because only events attended by TPaS are used as a proxy for total poisoning events, these data are likely a significant underestimate of the true number of opioid poisonings in Toronto during this period. 

- In 2025, TPaS responded to 2,747 non-fatal suspected opioid poisonings and 126 fatal opioid poisonings that are reported in TOIS. 

    - A "suspected opioid overdose call" is an event for which 9-1-1 was called with a TPaS response in which the treating paramedic suspected an opioid poisoning.*

    - Fatal opioid poisonings included in this dataset are cases in which the patient was pronounced dead on scene. It may differ from the final cause of death as reported by the Office of the Chief Coroner.*

    - Locations with four or fewer events were suppressed for privacy reasons.*

    - Only 1,991 events had intersection data available, representing data coverage of 69.3%. A further 729 events were linked to the official Toronto neighbourhood in which they occurred (n = 2,720), representing data coverage of 94.7%. While absolute counts are lower, the geographic distribution of poisonings with intersection data was not significantly different than the distribution at the neighbourhood level. 

- Geospatial coordinates of intersections were obtained from the City of Toronto's [Intersection File](https://open.toronto.ca/dataset/intersection-file-city-of-toronto/). 

    - All City of Toronto geospatial files use the World Geodetic System 1984 projection (WGS84, EPSG: 4326).

- A list of Toronto shelters was obtained from the Toronto Shelter & Support Services (TSSS) [shelter occupancy dataset](https://open.toronto.ca/dataset/daily-shelter-overnight-service-occupancy-capacity/). Only shelters administered or overseen by TSSS are included in the dataset. Sites were extracted on April 8, 2026, meaning that only sites operating on the night of April 7, 2026 were included. 

    - Only overnight shelters are incuded in this dataset. Drop-in prograns and day services are not included. 

    - Shelter sites were defined for this project as program sites for a single operating agency at a single address. Addresses with multiple programs operated by the same agency were combined into a single shelter site. These data are consistent with the unique ```LOCATION_ID``` and ```LOCATION_NAME``` items assigned by TSSS as rported in the occupancy dataset. 

    - Some shelter sites (n = 3) had their street addresses suppressed due to safety concerns (e.g., violence against women shelters or shelters for LGBTQ+ youth). Shelters without a street address were excluded from the project dataset. 

    - Geospatial coordinates for shelter sites were obtained from a publicly available geocoding tool. Geocoding was performed from street addresses, and sites were coded using the WGS84 projection.

- Site locations in 2026 were selected to provide risk estimates for programs currently operating based on historical data. this study is therefore not retrospective in nature, and it is not able to assess the effect of the shelter sites themselves on opioid poisoning risk. 

- Geospatial data for 2021 census tracts were obtained from Statistics Canada. Census polygons used the North American Datum of 1983 (NAD83) / Statistics Canada Lambert map projection (EPSG: 3347). 

    - Population data were obtained from the 2021 Census of Population at the census tract level. 

    - The census tract shapefil was restricted to only the "Toronto, City" census subdivision using the City of Toronto [municipal boundary file](https://open.toronto.ca/dataset/regional-municipal-boundary/). 

 - All coordinate reference systems (CRS) were aligned using the NAD83/ UTM zone 17 CRS (EPSG: 26917) to ensure consistency of projection. This CRS was selected because of it's specific distance accuracy for Ontario. 

 - Suspected opioid poisonings were measured at proximities to shelters at both 200 and 500 metres. 

    - Buffers were defined as a. circule with a radius of 200 r 500 metres from the centre of the shelter site. total areas were 0.126 sq. km and 0.785 sq. km for the 200 and 500 metre buffer radii, respectively.   

---
 
Notes marked with an asterisk (*) are adapted from the TOIS technical notes developed by TPH. 