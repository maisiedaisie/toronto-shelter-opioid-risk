# Quick Start Guide: Simple Analysis
Welcome to QUICKSTART.

This guide will walk you through the steps to produce a list of shelters for people experiencing homelessness in Toronto by the number of suspected opioid poisoning events within 200 metre and 500 metre buffer radii. This guide is intended for users who are not familiar with **R** or **GIS**, but assumes that you have at least some familiarity with basic epidemiologic principles. This section is intended to be lightweight and user friendly. 

This workflow will help you reproduce steps 1-3 (i.e., mapping points, counting points within a buffer, and assigning ranks for each shelter) of the analysis in a consistent manner. It does not include the code required for more advanced statistical analysis of the data. 

## 1. Download the Required Software
For this analysis, you will need access to R. 

1. Download and install **R** on your device (Mac, Windows, or Linux): [https://www.r-project.org](www.r-project.org) (Required)

2. Download and install **R Studio** on your device: [https://posit.co/download/rstudio-desktop](https://posit.co/download/rstudio-desktop) (Recommended)

Downloading **R Studio** is not required, but it does provide you with a more user-friendly interface for working with R. It is strongly recommended, especially for beginners. The steps that follow assume that you have installed **R Studio**. **R** must be installed for **R Studio** to work properly. 

The code for this analysis was written in **R-4.5.3 ("Reassured Reassurer")**. This code uses a function that locks the **R environment** to certain settings that are unique to this version. Please ensure that you have the correct version of **R** installed. You can find the version of **R** that you are using in the first line of the console in **R/R Studio**. 

## 2. Download and Open this Repository
To run this code, you will need to save a copy of this repository locally on your device. Opening the repository in **R Studio** allows you to run code files without having to find them manually each time. 

1. Download or clone this repository from GitHub.

2. Locate the repository folder on your computer. It will be called **"toronto-shelter-opioid-risk"**. 

3. Load the repository in **R Studio**. You can do this by either opening the folder (File &rarr; Open Project and selecting this repository) or by setting the working directory in the console:  
```setwd("/filepath/toronto-shelter-opioid-risk")```  
(Make sure to change "filepath" to the location of the folder on your device.) 

You should see the all of the files in this repository appear in the **Files** tab of **R Studio**. 

## 3. Download External Files
Some of the data files used in this analysis are not included in this repository because they are owned by government agencies. This means that you will need to download them yourself and add them into your working directory separately. All of these files are available for free to the public online. 

A list of files that you will need to download is included below with links to the download page. Some files will require you to make selections to get the proper data format. When required these selections have been listed for you. 

- [City of Toronto Intersection File](https://open.toronto.ca/dataset/intersection-file-city-of-toronto/) - Selections: "CSV", "WGS84"

- [City of Toronto Regional Municipal Boundary](https://open.toronto.ca/dataset/regional-municipal-boundary/) - Selections: N/A

- [City of Toronto Neighbourhoods](https://open.toronto.ca/dataset/neighbourhoods/) - Selections: "Shapefile", "WGS84"
    - Ensure that you only download the file under "Neighbourhoods", and not "Neighbourhoods - historical 140" as this will produce misaligned maps.

- [Statistics Canada 2021 Census Boundary Files](https://www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/index2021-eng.cfm?year=21) - Selections: "English","Digital Boundary Files (DBF)", "Census tracts", "Shapefile"
    - Alternatively, you can download the file directly with the correct selections directly from the following link [https://www12.statcan.gc.ca/census-recensement/alternative_alternatif.cfm?l=eng&dispext=zip&teng=lct_000a21a_e.zip&k=%20%20%20%20%209416&loc=//www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lct_000a21a_e.zip](https://www12.statcan.gc.ca/census-recensement/alternative_alternatif.cfm?l=eng&dispext=zip&teng=lct_000a21a_e.zip&k=%20%20%20%20%209416&loc=//www12.statcan.gc.ca/census-recensement/2021/geo/sip-pis/boundary-limites/files-fichiers/lct_000a21a_e.zip)

Once you have downloaded these files, you will need to move them into the project folder under **"toronto-shelter-opioid-risk"**. The code that you will run assumes that the files are in the correct location. Please ensure that the datafiles are in the main folder, and not in a sub-folder. If you have done it correctly, the files should appear in the **Files** tab in **R Studio** when you open the project. 

Detailed information about these datafiles can be found in the [DATANOTES.md](https://github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/DATANOTES.md) file. 

## 4. Install Required Packages
Once all files have been added to the project folder, you are almost ready to run the analysis. The code files will download all required packages for you.

You may be asked to pick a **CRAN mirror** from which to download the packages. This is typical. CRAN stands for the "Comprehensive R Archive Network", and it is used to host packages and features developed by people to supplement **R**'s base functions. The standard CRAN mirror for the Toronto area is **ON-1**, hosted at the University of Waterloo. 

Depending on your system, this step may take anywhere from a few seconds to a few minutes. Using the correct CRAN mirror can make this process faster. 

## 5. Run the Simple Analysis
This step helps you run the code for the actual analysis. 

1. Open the file ```run-simple-analysis.R``` from the project folder.

2. Run the entire script (either use "**Code** &rarr; **Source File** in the menus or by choosing "**Source**" in the top left quadrant of the window). 

This will automatically run the code from the following files, in order: 

- ```01-data-environment.R```
- ```02-data-validation.R```
- ```03-simple-analysis.R```

If the code runs successfully fully, it will produce an output file called ```shelter-raw-counts.csv``` in your working directory. This file lists: 

- Each shelter site

- The number of proximal poisoning events at 200 metres 

- The number of proximal poisoning events at 500 metres

- Rankings based on these counts

You can download this file for your own use later. 

## 6. Producing Optional Figures
If you want to produce some figures to accompany your analytic output file, you can simply copy and paste the code for figures 1-4 (labelled using comments starting with #) from the file ```05-figures.R```. This will produce figures with relevant features mapped on top of Toronto neighbourhoods as reference geography. 

## Troubleshooting
If you run into an issue, please don't worry—it happens! The code in ```02-data-validation.R``` is designed to let you know if something went wrong and where. 

If something goes wrong while the code is running: 

- Read the error message carefully. The error messages are designed to tell you what specifically went wrong and which line of code is broken. 

- Confirm that your working directory is set properly. You can check this by running the ```getwd()``` function.

- Double check that all files have been downloaded, are present, and are named correctly (see [DATANOTES.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/DATANOTES.md) and [README.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/README.md) for a list of filenames). 

### Still Need Help?
If you're still having issues, please feel free to reach out to us. You can either: 

- Open an **issue** on GitHub

- Contact the maintainer directly by e-mail at maisie.davis@alumni.utoronto.ca

We'll do our best to help you out!

## Next Steps
These instructions only run part of the analysis. If you are interested in seeing the statistical analysis of the results you just produced, please refer to the [FULLSETUP.md](github.com/maisiedaisie/toronto-shelter-opioid-risk/information-and-notes/FULLSETUP.md) file. Please do note that this portion requires significantly more user intervention in **R** and the code process. 

---
Thank you for your interest in our work! We hope that this guide was useful for you. 