# Full Setup Guide
Welcome to FULLSETUP!

This document provides you with instructions to reproduce the project in full, including the full statistical analysis and figures. For instructions that are more suited to users unfamiliar with **R**, please refer to the [QUICKSTART.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/QUICKSTART.md) file. 

This guide assumes that you have a strong background in statistics and epidemiology, and familiarity with R and GIS. As a result, there are fewer detailed explanations of many of the steps as it is assumed that you already know how to do most of them. 

## Overview
This project is structured in a stepwise fashion to produce statistical analysis in R. The workflow has been designed to be reproducible using ```renv``` functions and a series of ordered scripts found in the [R-code](github.com/maisiedaisie/toronto-shelter-opioid-risk/R-code) folder. 

## Prerequisites
- R version ≥ 4.0.0 - "Arbor Day" (the project was created in version 4.5.3 - "Reassured Reassurer") - Required

- R Studio - Highly recommended

## 1. Clone the Repository
You will need to make a clone of this repository as the resulting folder (```/toronto-shelter-opioid-risk```) will serve as your working directory in R. 

You can find instructions on how to clone a GitHub repository on GitHub Docs' [Clone a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) page. 

## 2. Setup the R Environment
This project `renv` package to manage dependencies and package versions to ensure reproducibility of the code. 

1. Open this project in R Studio. If you are not using R Studio, you will need to open this project as the project root in a base R session. 

2. Restore the environment by installing and loading the `renv` package.

    ```
    install.packages("renv") # If you do not already have renv downloaded
        
    renv::restore()
    ```
This will re-install the correct version of all packages from the `renv.lock` file.

## 3. Download External Files
This project relies on several external datasets produced by the City of Toronto and Statistics Canada. You will need to download these files from their respective authors' websites. 

- [City of Toronto Intersection File](https://open.toronto.ca/dataset/intersection-file-city-of-toronto/) - Selections: "CSV", "WGS84"

- [City of Toronto Regional Municipal Boundary](https://open.toronto.ca/dataset/regional-municipal-boundary/) - Selections: N/A

- [City of Toronto Neighbourhoods](https://open.toronto.ca/dataset/neighbourhoods/) - Selections: "Shapefile", "WGS84"
    - Ensure that you only download the file under "Neighbourhoods", and not "Neighbourhoods - historical 140" as this will produce misaligned maps.

- [Statistics Canada 2021 Census Boundary Files](https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/index2021-eng.cfm?year=21) - Selections: "English","Digital Boundary Files (DBF)", "Census tracts", "Shapefile"
    - Alternatively, you can download the file directly with the correct selections directly from the following link [https://www12.statcan.gc.ca/census-recensement/alternative_alternatif.cfm?l=eng&dispext=zip&teng=lct_000a21a_e.zip&k=%20%20%20%20%209416&loc=//www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lct_000a21a_e.zip](https://www12.statcan.gc.ca/census-recensement/alternative_alternatif.cfm?l=eng&dispext=zip&teng=lct_000a21a_e.zip&k=%20%20%20%20%209416&loc=//www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lct_000a21a_e.zip)

Once all the files have been downloaded, please move them into the working directory. Shapefiles will be downloaded as a ZIP archive. You must first unzip and then move the full archive for the ```sf``` package to extract the shapefiles properly. You should now see the following files/folders in your root directory: 

 - `centreline_intersection_4326.csv`

- `citygcs_regional_mun_wgs84`

- `Neighbourhoods - 4326`

- `lct_000a21a_e`

## 4. Run the Analysis
Run the code files in the `/R-code` folder in order (i.e., 01, then 02, etc.)

## Notes
- Ensure that this repository is your working directory when before running any code. Either use the `setwd()` function or set this folder as the project as using "File &rarr; Open Project" in R Studio. 

- R code files are dependent on objects created in the previous steps. Please do not run the scripts out of order. 

- Scripts contain frequent comments. We have highlighted places to change variables if you would like to modify/adapt the analysis (e.g., examining another buffer radius). In this case, simply copy, change, and paste the code into the console rather than simply running the code as-is. 

## 7. Troubleshooting
### Issues During Package Installation
- Try restarting R and running renv::restore() again.

- On some systems, system libraries may be required (e.g., compilers)

### Issues with Files
- Confirm that all files have been properly downloaded and moved into the working directory

- Check for mismatched filenames or extensions (please see filenames above). 

### Issues with Code Execution
- Ensure that all files have been run in order. 

- All R code files have a comment outlining the objects that should be output by the code in that file. Ensure that all objects have been properly created. 

## Contact
If you're still having issues, please feel free to reach out to us. You can either: 

- Open an issue on GitHub

- Contact the maintainer directly by e-mail at maisie.davis@alumni.utoronto.ca

We'll do our best to help you out!

---
Thank you for your interest in our work! We hope that this guide was useful for you. 
