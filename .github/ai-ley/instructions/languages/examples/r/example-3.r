# Package development workflow
# File: package_development.R

library(devtools)
library(roxygen2)
library(testthat)
library(pkgdown)
library(usethis)

# Package initialization
create_package_structure <- function(package_name, path = ".") {
  # Create package skeleton
  create_package(file.path(path, package_name))
  
  # Set up development environment
  use_git()
  use_mit_license()
  use_readme_rmd()
  use_news_md()
  use_testthat()
  use_roxygen_md()
  use_pkgdown()
  
  # Set up CI/CD
  use_github_actions()
  use_coverage()
  
  # Create example function
  use_r("hello")
  
  cat("Package structure created successfully!\n")
  cat("Next steps:\n")
  cat("1. Edit DESCRIPTION file\n")
  cat("2. Add functions to R/ directory\n")
  cat("3. Document functions with roxygen2\n")
  cat("4. Add tests to tests/testthat/\n")
  cat("5. Build and check package\n")
}

# Function documentation template
#' Function Title
#'
#' @description
#' Brief description of what the function does.
#'
#' @param param1 Description of parameter 1
#' @param param2 Description of parameter 2
#'
#' @return Description of return value
#'
#' @examples
#' \dontrun{
#' example_function(param1 = "value1", param2 = "value2")
#' }
#'
#' @export
#' @importFrom package function
example_function <- function(param1, param2) {
  # Function implementation
  result <- paste(param1, param2)
  return(result)
}

# Package development workflow
develop_package <- function() {
  # Generate documentation
  document()
  
  # Run tests
  test()
  
  # Check package
  check()
  
  # Build package
  build()
  
  # Install package
  install()
}

# Continuous integration setup
setup_ci_cd <- function() {
  # GitHub Actions for R CMD check
  use_github_action("check-release")
  use_github_action("test-coverage")
  use_github_action("pkgdown")
  
  # Add badges to README
  use_lifecycle_badge("experimental")
  use_cran_badge()
  use_github_actions_badge()
  use_codecov_badge()
}