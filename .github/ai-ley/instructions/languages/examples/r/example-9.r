# RStudio configuration
rstudio_config <- list(
  # Global options
  global_options = list(
    save_workspace = "never",
    load_workspace = FALSE,
    always_save_history = FALSE,
    remove_history_duplicates = TRUE,
    show_line_numbers = TRUE,
    soft_wrap_R_files = TRUE,
    highlight_selected_word = TRUE,
    highlight_selected_line = TRUE
  ),
  
  # Code editing
  code_editing = list(
    auto_append_newline = TRUE,
    strip_trailing_whitespace = TRUE,
    ensure_newline_at_eof = TRUE,
    auto_detect_indentation = TRUE,
    smart_indent_r = TRUE
  ),
  
  # Appearance
  appearance = list(
    theme = "Modern",
    font_size = 11,
    editor_theme = "Textmate"
  )
)

# Set up development environment
setup_dev_environment <- function() {
  # Create project structure
  dirs <- c("R", "data", "output", "docs", "tests", "scripts")
  lapply(dirs, dir.create, showWarnings = FALSE)
  
  # Create .Rprofile
  rprofile_content <- '
# Load commonly used packages
if (interactive()) {
  suppressMessages({
    library(tidyverse)
    library(data.table)
  })
}

# Set options
options(
  repos = c(CRAN = "https://cran.rstudio.com/"),
  browserNLdisabled = TRUE,
  deparse.max.lines = 2,
  scipen = 999
)

# Custom functions
ll <- function() { .rs.listObjects() }
'
  
  writeLines(rprofile_content, ".Rprofile")
  
  # Create .Renviron
  renviron_content <- '
# R environment variables
R_HISTSIZE=10000
R_MAX_VSIZE=100Gb
'
  
  writeLines(renviron_content, ".Renviron")
  
  cat("Development environment set up successfully!\n")
}