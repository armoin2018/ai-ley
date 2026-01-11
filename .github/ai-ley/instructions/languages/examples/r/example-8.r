# Data manipulation and analysis
essential_packages <- list(
  data_manipulation = c("dplyr", "data.table", "tidyr", "purrr"),
  data_import = c("readr", "readxl", "haven", "DBI"),
  visualization = c("ggplot2", "plotly", "lattice", "corrplot"),
  statistical_modeling = c("stats", "MASS", "randomForest", "xgboost"),
  time_series = c("forecast", "prophet", "zoo", "xts"),
  text_analysis = c("tidytext", "tm", "quanteda", "stringr"),
  web_development = c("shiny", "plumber", "httr", "rvest"),
  reporting = c("rmarkdown", "knitr", "bookdown", "flexdashboard"),
  package_development = c("devtools", "roxygen2", "testthat", "usethis"),
  performance = c("profvis", "microbenchmark", "future", "parallel")
)

# Install all essential packages
install_essential_packages <- function() {
  all_packages <- unlist(essential_packages)
  new_packages <- all_packages[!(all_packages %in% installed.packages()[,"Package"])]
  
  if(length(new_packages)) {
    install.packages(new_packages)
  }
  
  cat("All essential packages installed!\n")
}