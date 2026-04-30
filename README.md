# Ecological Risk of Opioid Poisonings Proximal to Toronto Shelters for People Experiencing Homelessness
### Version 0.1.0 (St. Andrew)
In 2025, Toronto Paramedic Services (TPaS) responded to 2,909 9-1-1 activations for suspected opioid poisoning events. Of these events, 1,991 have associated geographic data in the form of linkage to the nearest main intersection as reported in the [Toronto Overdose Information System](https://public.tableau.com/app/profile/tphseu/viz/TOISDashboard_Final/ParamedicResponse) (TOIS). Many of these events are clustered around areas with a high density of shelters for people experiencing homelessness. While no public data exist (of which the authors are aware) to conclusively determine the nature of this relationship, there is still benefit to identifying shelters in Toronto with high area-level risk.

This repository contains the code required to reproduce an analysis of the relative ecological risk of opioid poisonings experienced by shelters in Toronto administered by Toronto Shelter & Support Services (TSSS). It is primarily maintained by Maisie Davis ([/maisiedaisie](https://github.com/maisiedaisie) on GitHub). Others' contributions are acknowledged as appropriate throughout. 

## Overview for New Users
This analysis uses R to produce an analysis of the spatial relationship between the location of opioid poisoning events and shelters for people experiencing homelessness. This project: 
1. Maps the geography of suspected opioid poisoning events in Toronto from 2025 and shelter sites; 

2. Counts the number of opioid poisoning events within a defined buffer radius of each shelter at two levels (200 metre and 500 metre radius): 

3. Ranks shelter sites by the absolute number of events within their proximity during calendar year 2025; 

4. Calculates a population-adjusted standardized incidence ratio (SIR) and risk ratio (RR) using 2021 census data; and

5. Uses spatial statistics to characterize these relationships and uncertainty. These include spatial autocorrelation (Moran's _I_), kernel density, and a 95% confidence interval for each RR.

The primary outputs include ranked shelter-level counts of nearby events, and population-adjusted risk estimates with associated uncertainty measures.

To assist you, detailed instructions for use can be found in three files. 
- DATANOTES.md includes detailed technical information about variable definitions, data sources, and important limitations that would affect the interpretation of the final analysis. 

- QUICKSTART.md provides a step-by-step guide to loading the R data environment to produce counts of proximal events for each shelter site (steps 1-3 above). We recommend that users who are not yet familiar with R start here. 

- FULLSETUP.md provides guidance for experienced users on how to load data sources, dataframes, and reproduce the analysis in full. We recommend this for users already familiar with R, epidemiologic analysis, and geospatial theory start here. 

### Additional Notes
- We recommend that users use either QUICKSTART.md or FULLSETUP.md for their analysis, but not both at the same time. This can duplicate steps which can create issues with the R workflow. 

- R code files are named sequentially (01-04), and depend on steps in preceding files. Files should always be run in order to prevent errors. 

## Contents
In addition to this README file, this repository contains 4 folders:
- [information-and-notes](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes)

- [data-files](github.com/maisiedaisie/toronto-shelter-opioid-risk/data-files)

- [R-code](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code)

- [TeX-code](github.com/maisiedaisie/toronto-shelter-opioid-risk/TeX-code)

The contents of each of these folders are detailed in the subsections below. 

This repository also has a [CHANGELOG](github.com/maisiedaisie/toronto-shelter-opioid-risk/CHANGELOG.md) file that describes changes made to the code in subsequent versions of this code. There are also two files to facilitate the R analysis: [simple-analysis.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/simple-analysis.R) file for inexperienced users to reproduce part of the analysis in an accessible format, and [renv.lock](github.com/maisiedaisie/toronto-shelter-opioid-risk/renv.lock) which re-installs the R packages used in the analysis. 

### Information and Notes
This folder contains a series of markdown (.md) files that describe technical aspects of this project and its data structures, as well as files that provide guidance to users of this repository at different levels. These include:
- [DATANOTES.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes): provides technical notes for data elements included in the analysis for all data sources. This file also includes detailed information for all external data sources not included in this repository.

- [QUICKSTART.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/QUICKSTART.md): setup instructions for the R environment for users with little to no prior experience with R or spatial epidemiology. This file provides copiable instructions to produce a simple ranking of shelter sites by number of proximal overdoses at 200 and 500 metre buffer thresholds. This workflow is fully reproducible. 

- [FULLSETUP.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/FULLSETUP.md): setup instructions for reproducing the full statistical analysis in R, including all dataframes and dependencies. This workflow is fully reproducible. This file is intended for users who are already familiar with R and/or epidemiological theory and practice. Users should also have some understanding of geospatial analysis/geographic information systems (GIS). 

### Data Files
This folder contains raw data files used in the statistical analysis in R. These include:
- [tpas-suspected-overdose-2025-by-intersection.csv](github.com/maisiedaisie/toronto-shelter-opioid-risk/data-files/tpas-suspected-overdose-2025-by-intersection.csv): contains intersection-linked data on suspected opioid poisoning events in Toronto that were attended by TPaS from January 1 to December 31, 2025. 

- [tpas-suspected-overdose-2025-by-neighbourhood.csv](github.com/maisiedaisie/toronto-shelter-opioid-risk/data-files/tpas-suspected-overdose-2025-by-neighbourhood.csv): contains the number of suspected opioid poisonings attended by TPaS from January 1 to December 31, 2025 by official neighbourhood. 

- [toronto-shelter-sites-apr26.csv](github.com/maisiedaisie/toronto-shelter-opioid-risk/data-files/toronto-shelter-sites-apr26): contains a geocoded list of all shelter sites overseen by TSSS that were operating on the night of April 8, 2026. 

- [toronto-census-tract-populations-2021.csv](github.com/maisiedaisie/toronto-shelter-opioid-risk/data-files/toronto-census-tract-populations-2021.csv): contains a list of census tracts within the "Toronto, City" census subdivision and their reported populations from the 2021 Census of Population (Statistics Canada). 

This is not a comprehensive list of all files used in the analysis. Some files produced by other organizations and agencies must be downloaded and added to the working directory separately. Instructions for downloading and including these files can be found in either the [QUICKSTART.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/QUICKSTART.md) file or the [FULLSETUP.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/FULLSETUP.md) file, depending on which you are using. 

### R Code Files
This folder contains the raw R code files to reproduce the analysis. These files are run automatically using the code snippet in the [QUICKSTART.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/QUICKSTART.md) file. These files are designed to be run in sequence. They include: 
- [01-data-environment.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code/01-data-environment.R): contains code to set up the R environment, load the required packages, and load and transform dataframes from the raw datafiles into shapefiles for analysis. 

- [02-data-validation.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code/02-data-validation.R): contains code that is designed to ensure that all dataframes from the previous file are properly created. This code is designed to fail and return a descriptive error (i.e., "fail loudly") in the event of an improperly loaded or transformed dataframe that would affect the final analysis. 

- [03-simple-analysis.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code/03-simple-analysis.R): contains code to produce a list of TSSS sites with the number of proximal suspected poisoning events within two buffer radii: 200 metres and 500 metres. This code will print this information into a .csv file in the user's working directory. This code produces only a raw count without population-adjusted risk quantification. 

- [04-statistical-analysis.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code/04-statistical-analysis.R): contains code to produce a SIR and RR for each shelter site. We will be updating this code in the near future to produce statistical models to estimate the uncertainty of the analysis, including the use of Poisson distributions and Moran's _I_ statistic. This file is not run by the code snippet included in [QUICKSTART.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/QUICKSTART.md). 

- [05-figures.R](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code/05-figures.R): contains code to produce useful visualizations of the analysis, including geospatial mapping. 

### TeX Code Files
This folder is currently under development. In the upcoming release v1.0.0 (Union), it will be updated to include the following files: 

- A .tex file to produce a manuscript for a working paper for the findings of this project in LaTeX. 

- A .bib file to supplement the LaTeX files with references in BibTeX format. 

- A PDF version of the working paper. 

## Dependencies
This project requires access to R (version 3.5.4 - "Reassured Reassurer"). R can be downloaded from the the R Project for Statistical Computing's website: [https://www.r-project.org](https://r-project.org). R Studio is also recommended for convenience of use. 

Packages with functions other than those in "base R" can be downloaded from CRAN through the R console. 

## License and Collaborations
This project is explicitly unlicensed. Users should feel free copy and use the code and data files for their own work. Please also feel free to fork this repository for your own use on GitHub. While citing or otherwise acknowledging this project is always appreciated when you use data, files, or code, it is not required. If you do use this work in your own, please also feel free to share it with us. We would love to see it!

All external files are available under an "open government" license (either the [Open Government License - Toronto](https://open.toronto.ca/open-data-licence/) for the City of Toronto [Statistics Canada Open License](https://www.statcan.gc.ca/en/terms-conditions/open-licence) for census data from Statistics Canada). Users should ensure that their use is consistent with the terms of those licenses. 

This project is not open to formal collaborations. However, if you would like to explore the possibility of a future collaboration, please feel free to contact the maintainer of this repository directly. If you would like to contribute code to this repository or have suggestions for improvements of the existing code, please feel free to open a new discussion or issue, as appropriate. 

### Reporting Issues and Questions
If you encounter an issue or bug when running the code or downloading files from this repository, please create a detailed issue. Please make sure to include at least the file name, the code snipped (if applicable), and a description of the issue when making a report. 

If you have a technical question about the analysis, please feel free to create a new issue post. We will respond to all issues/questions as soon as we can!

For questions or issues relating to an external data source or file, please contact the author of that file directly. Many external files have their own technical documentation that may also be helpful for users. A list of sources and authors can be found in the [DATANOTES.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/DATANOTES.md) file. 

## Contact Information
For questions or concerns related to this repository, please leave a comment or issue post on GitHub in the appropriate section. 

This repository is maintained by Maisie Davis. You can contact her directly by e-mail at [maisie.davis@icha-toronto.ca](mailto:maisie.davis@icha-toronto.ca). 

## Acknowledgements
This project has adapted public data from Toronto Public Health, Toronto Paramedic Services, Toronto Shelter & Support Services, and Statistics Canada. Thank you to all the staff of those organizations who make those data public. 

Thanks also to our colleagues who provided invaluable early feedback on this work. 

### Opioid Harm Statement
We wish to acknowledge the significant impact that substance use, toxicity, and resulting harms can have on individuals, families, and communities. Our data presented here represents real people experiencing significant suffering, and it should be interpreted with care and a respect for the dignity, autonomy, and lived experience. We emphasize the importance of reducing stigma and barriers to care, and supporting evidence-based public health solutions. 
