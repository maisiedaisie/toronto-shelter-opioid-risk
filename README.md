# Ecological Risk of Opioid Poisonings Proximal to Toronto Shelters for People Experiencing Homelessness
In 2025, Toronto Paramedic Services responded to 2,747 non-fatal and 126 fatal suspected opioid poisoning events (not mutually exclusive). Of these events, 1,991 have been reported with geographic data by Toronto Public Health through the [Toronto Overdose Information System](https://public.tableau.com/app/profile/tphseu/viz/TOISDashboard_Final/ParamedicResponse) (TOIS). Many of these events are clustered around areas with shelters for people experiencing homelessness (PEH). This repository contains code for analysis in R to quantify the relative ecological risk of shelters administered by Toronto Shelter & Support Services (TSSS). 

Data notes for this analysis can be found in the [Data Notes](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/DATANOTES.md) markdown file in the main branch of this repository. 

## Contents
This repository contains files that can be loaded as a single repository in R. In addition, the folder ["tex-report"](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/tex-report) contains code to produce a detailed report containing analysis for this project, including a detailed methodology and theoretical framework. 

### R Code Files
* [1-data-environment.R](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/1-data-environment.R): Installs and loads packages, loads dataframes from raw data files.
* [2-raw-analysis.R](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/2-raw-analysis.R): Geospatial analysis of raw event counts within 200 metres of a shelter.
* [3-population-risk-adjustments.R](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/3-population-risk-adjustments.R): Risk stratification of shelter sites with population adjustments from census data.
* [4-figures.R](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/4-figures)

### Data Files
* [toronto-ems-calls-suspected-overdose-2025-by-intersection.csv](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/toront0-ems-calls-suspected-overdose-2025-by-intersection.csv): Responses by Toronto Paramedic Services for suspected opioid poisoning events by intersection. 
* [toronto-shelter-sites-apr26.csv](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/toronto-shelter-sites-apr26.csv): Geospatial data and bed counts for shelter sites administered by TSSS operating in April 2026.
* [toronto-census-tract-populations-2021.csv](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/toronto-census-tract-populations-2021.csv): Population data for each census tract in the Toronto Census Metropolitan Area from the 2021 Census of Population.

In addition to the custom data files contained in this folder, users will need to download several publicly available data files provided by Statistics Canada and the City of Toronto. Information for downloading and loading these data files can be found in the "Setup Instructions" section of this README. 

### LaTeX Files
* [ecological-risk-of-opioid-toxicity-for-toronto-shelters-2025.tex](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/tex-report/ecological-risk-of-opioid-toxicity-for-toronto-shelters-2025.tex): Code to reproduce the report proper.
* [references.bib](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/tex-report/references.bib): A BibTeX file for references contained in the main report.

## Setup Instructions
### Step 1: Download External Files
To standardize the data used in this analysis, several files from government agencies are used in the geospatial analysis. All are available under open government licenses, and can be found at the links below. Some files require specific selections to download the file in the proper format. When necessary, instructions for downloading the correct file are included below. Before loading the file into the repository, ensure that the filename matches the one provided below. For .zip files, please ensure that you have loaded the full .zip archive into the repository, or else shapefiles will not work properly with the Simple Features package in R. 

Once all files have been downloaded, load their contents into the repository. Files should not be left in their folders as this can cause R to be unable to find them when calling shapefiles to be loaded into a dataframe. 

#### Toronto Intersection File
Author: City of Toronto  
Available from: [Intersection File - City of Toronto](https://open.toronto.ca/dataset/intersection-file-city-of-toronto/)  
License: [Open Government License - Toronto](https://open.toronto.ca/open-data-licence/)  
Selections: "CSV", "WGS84"  
Filename: "centreline_intersection_4326.csv"

#### Toronto Municipal Boundary
Author:  City of Toronto
Available from: [Regional Municipal Boundary](https://open.toronto.ca/dataset/regional-municipal-boundary/)  
License: [Open Government License - Toronto](https://open.toronto.ca/open-data-licence/)  
Selections: N/A  
Filename: citygcs_regional_mun_wgs84.zip

#### Toronto Neighbourhoods
Author: Social Development, Finance & Administration (City of Toronto)  
Available from: [Neighbourhoods](https://open.toronto.ca/dataset/neighbourhoods/)  
License: [Open Government License - Toronto](https://open.toronto.ca/open-data-licence/)  
Selections: "Shapefile", "WGS84"
Filename: "Neighbourhoods - 4326.zip"  
Additional notes: donwload only the "Neighbourhoods" file, not the "Neighbourhoods - historical 140" file. 

#### Census Tract Boundary File
Author: Statistics Canada  
Available from: [2021 Census - Boundary Files](https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/index2021-eng.cfm?year=21)  
License: [Statistics Canada Open License](https://www.statcan.gc.ca/en/terms-conditions/open-licence)  
Selections: "English", "Cartographic Boundary Files (CBF)", "Census tracts", "Shapefile (.shp)"  
Filename: "lct_000a21a_e.zip"  
Additional notes: Leave the "Administrative boundaries" and "Non-standard boundaries" sections blank.

### Step 2: R Setup
This project was written in R version 4.5.3 ("Reassured Reassurer"). RStudio is also recommended for this project. 

#### Packages
The following packages are used in this code:
* [ggspatial](https://cran.r-project.org/web/packages/ggspatial/index.html) (version 1.1.10)
* [jsonlite](https://cran.r-project.org/web/packages/jsonlite/index.html) (version 2.0.0)
* [MASS](https://cran.r-project.org/web/packages/MASS/index.html) (version 7.3-65)
* [sf](https://cran.r-project.org/web/packages/sf/index.html) (version 1.1-0)
* [terra](https://cran.r-project.org/web/packages/terra/index.html) (version 1.9-11)
* [tidyverse](https://cran.r-project.org/web/packages/tidyverse/index.html) (version 2.0.0)
* [tmap](https://cran.r-project.org/web/packages/tmap/index.html) (version 4.2)
* [viridis](https://cran.r-project.org/web/packages/viridis/index.html) (version 0.6.5)

### Step 3: Run R Files
Load, in order by the prefix number of the file, each of the .R files. This will produce the analysis sequentially. After running each file, ensure that you have saved any dataframes that you would like to keep as they may change when running the next file. 

All of the files are annotated with additional information and instructions for users who wish to customize their analytical output. Additionally, some commands have been made optional by commenting out the code.  
For example:  
```
#Optional plot 
#ggplot() +
  #geom_sf(data = tracts_toronto, fill = "white", color = "black") +
  #geom_sf(data = intersections_sf, aes(size = OD_COUNT), color = "pink1", alpha = 0.7) +  
  #geom_sf(data = shelters_sf, color = "palegreen2", shape = 4, size  = 3) +
  #theme_minimal() +
  #labs(title = "Suspected Opioid Toxicity Events and Shelter Locations in Toronto, 2025",
  #size = "Toxicity Events")
```

#### Note About Figures
The figures file ("[4-figures.R](www.github.com/maisiedaisie/toronto-shelter-opioid-risk/4-figures)") provides only sample figures. While I personally found these to be effective visualizations of the data, please feel free to modify them or create additional visualizations as needed for your purposes. You may modify the plots either aesthetically or substantively. 

Users can add these commands back in by simply removing the '#' at the beginning of each row. 

## Questions and Issues
For questions or issues related to this repository (including the analysis or findings), please feel free create a discussion post or issue in the repository as appropriate on GitHub. I'll do my best to get back to you quickly! 

## Acknowledgements
Much of the data in my files was drawn from Toronto Public Health and Toronto Paramedic Services through the TOIS, or from TSSS. Thank you to those who have worked to make those data available. 
