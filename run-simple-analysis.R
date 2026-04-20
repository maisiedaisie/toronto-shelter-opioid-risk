# toronto-shelter-opioid-risk v0.1.0 (St. Andrew)
# For issues, please create an issue on GitHub 
# (https://github.com/maisiedaisie/toronto-shelter-opioid-risk)

# Install the "renv" package
install.packages("renv")

# Re-load the R environmment
renv::restore()

# Load and run the other R source files
source("/R-code/01-data-environment.R")
source("/R-code/02-data-validation.R")
source("/R-code/03-simple-analysis.R")