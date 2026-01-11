# Check R version
R.version.string

# Install essential packages
install.packages(c(
  "tidyverse",    # Data manipulation and visualization
  "data.table",   # High-performance data manipulation
  "ggplot2",      # Grammar of graphics plotting
  "dplyr",        # Data manipulation
  "readr",        # Data reading
  "stringr",      # String manipulation
  "lubridate",    # Date/time handling
  "rmarkdown",    # Dynamic documents
  "shiny",        # Web applications
  "devtools",     # Package development
  "testthat",     # Unit testing
  "roxygen2",     # Documentation
  "profvis",      # Performance profiling
  "future",       # Parallel processing
  "DBI",          # Database interface
  "httr",         # HTTP requests
  "jsonlite"      # JSON handling
))

# Load core packages
library(tidyverse)
library(data.table)

# Set global options
options(
  repos = c(CRAN = "https://cran.rstudio.com/"),
  stringsAsFactors = FALSE,
  digits = 4,
  scipen = 999,
  warn = 1
)

# Configure parallel processing
library(future)
plan(multisession, workers = parallel::detectCores() - 1)