################

# Load all packages
library(ggspatial)
library(jsonlite)   # Contained in some distributions of the tidyverse.
library(MASS)
library(sf)
library(terra)
library(tidyverse)
library(tmap)
library(viridis)

# Load dataframes from external files
overdoses           <- read.csv("toronto-ems-calls-suspected-overdose-2025-by-intersection.csv")
intersections       <- read.csv("centreline_intersection_4326.csv")
shelters            <- read.csv("toronto-shelter-sites-apr26.csv")
tract_populations   <- read.csv("toronto-census-tract-populations-2021.csv", colClasses = c(CTNAME = "character")) # Preserves string formatting for the census tract names


toronto_boundary    <- st_read("citygcs_regional_mun_wgs84.shp")    # Current CRS: WGS84 (ESPG: 4326)
neighbourhoods      <- st_read("Neighbourhoods - 4326.shp")         # Current CRS: WGS84 (ESPG: 4326)
tracts              <- st_read("lct_000a21a_e.shp")                 # Current CRS: NAD83 / Statistics Canada Lambert (ESPG: 3347)

# Create shapefiles and align CRS
## Create coordinates from the JSON geometry of "intersections"
intersections <- intersections %>%
                    rowwise() %>%
                    mutate(
                        coords = list(fromJSON(geometry)$coordinates),
                        lon = coords[[1]],
                        lat = coords[[2]]
                    ) %>%
                    select(-coords)

## Join the "intersections" and "overdoses" shapefiles for geocoding
overdoses_joined <- left_join(overdoses, intersections, by = "OBJECTID")

rm(intersections)
rm(overdoses)
gc()

## Create the "overdoses_sf" shapefile
overdoses_sf <- st_as_sf(overdoses_joined, 
                            coords = c("lon", "lat"),
                            remove = FALSE,
                            crs = 4326) # Coordinates in the intersection file were in the WGS84 projection


## Create the "shelters_sf" shapefile
shelters_sf <- st_as_sf(shelters, 
                        coords = c("LON", "LAT"),
                        remove = FALSE,
                        crs = 4326)

rm(shelters)
gc()

## Convert all shapefiles to NAD83/ UTM zone 17 projection
overdoses_sf        <- st_transform(overdoses_sf, crs = 26917)
shelters_sf         <- st_transform(shelters_sf, crs = 26917)
toronto_boundary    <- st_transform(toronto_boundary, crs = 26917)
neighbourhoods      <- st_transform(neighbourhoods, crs = 26917)
tracts              <- st_transform(tracts, crs = 26917)

## Prepare the census tracts dataframe
### Reduce the geography of "tracts" to the Toronto census subdivision
toronto_tracts <- st_intersection(tracts, toronto_boundary)

rm(tracts)
gc()

### Attach population counts to the "toronto_tracts" dataframe
tracts_joined <- left_join(toronto_tracts, tract_populations, by = "CTNAME")                        lat = coords[[2]]
                    ) %>%
                    select(-coords)

# Join the overdose data frame with coordinates from the intersections dataframe
overdoses_joined <- left_join(overdoses, intersections, by = "OBJECTID")
rm(intersections)   # Removes the intersections dataframe. Optional, but will save space and make processing easier.

# Create the shapefile of the overdoses
overdoses_sf <- st_as_sf(overdoses_joined, 
                            coords = c("lon", "lat"),
                            remove = FALSE,
                            crs = 4326) # Coordinates in the intersection file were in the WGS84 projection

# - 2.2.2 Shelters - #
shelters_sf <- st_as_sf(shelters, 
                        coords = c("LON", "LAT"),
                        remove = FALSE,
                        crs = 4326)

## -- 2.3 Convert all shapefiles to NAD83 / UTM zone 17N projection -- ##
overdoses_sf        <- st_transform(overdoses_sf, crs = 26917)
shelters_sf         <- st_transform(shelters_sf, crs = 26917)
toronto_boundary    <- st_transform(toronto_boundary, crs = 26917)
neighbourhoods      <- st_transform(neighbourhoods, crs = 26917)
tracts              <- st_transform(tracts, crs = 26917)

## -- 2.4 Prepare the census tracts dataframe -- ##
# - 2.4.1 Crop the tracts shapefile to the City of Toronto only - #
toronto_tracts <- st_intersection(tracts, toronto_boundary)
rm(tracts)  # Removes the tracts dataframe. Optional, but will save space and make processing easier. I recommend it since the tracts file is huge.
gc()        # Frees up memory. Optional, but will save space and make processing easier.

# - 2.4.2 Attach population counts to the toronto_tracts shapefile - #
toronto_tracts <- left_join(toronto_tracts, tract_populations, by = "CTNAME")
################
