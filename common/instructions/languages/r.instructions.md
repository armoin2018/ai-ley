`
---
applyTo: "r, rstudio, cran, tidyverse, shiny, **/*.r, **/*.R, **/*.Rmd"
---

# R Programming Language Instructions

## Overview
- **Domain**: Statistical Computing and Data Science Programming Language
- **Purpose**: Data analysis, statistical modeling, visualization, and scientific computing
- **Applicable To**: Data science projects, statistical analysis, bioinformatics, machine learning
- **Integration Level**: Data pipelines, research workflows, and business intelligence systems

## Core Principles

### Fundamental Concepts
1. **Vectorized Operations**: Operations applied element-wise to vectors and matrices
2. **Functional Programming**: Functions as first-class objects with emphasis on immutability
3. **Data Frames**: Primary data structure for tabular data manipulation
4. **Statistical Computing**: Built-in statistical functions and packages
5. **Package Ecosystem**: Extensive CRAN repository with specialized packages
6. **Reproducible Research**: Integration with R Markdown for literate programming

### Key Benefits
- Comprehensive statistical and analytical capabilities
- Rich ecosystem of specialized packages (20,000+ on CRAN)
- Excellent data visualization with ggplot2 and base plotting
- Strong support for reproducible research and reporting
- Active community and extensive documentation
- Seamless integration with databases and big data tools

### Common Misconceptions
- **Myth**: R is slow and not suitable for production systems
  **Reality**: Modern R with optimized packages and parallel processing is highly performant
- **Myth**: R is only for statisticians and academics
  **Reality**: R is widely used in industry for data science, finance, and business analytics

## Implementation Framework

### Getting Started
#### Prerequisites
- R installation (latest version from CRAN)
- RStudio IDE or alternative R development environment
- Understanding of basic statistical concepts
- Package management with CRAN or devtools

#### Initial Setup
```r
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
```

### Core Methodologies
#### Data Science Pipeline Implementation
- **Purpose**: Implement end-to-end data science workflows from raw data to insights
- **When to Use**: Data analysis projects, research studies, business intelligence
- **Implementation Steps**:
  1. Data acquisition and cleaning with tidyverse
  2. Exploratory data analysis with ggplot2 and summary statistics
  3. Statistical modeling and machine learning
  4. Results visualization and interpretation
  5. Report generation with R Markdown
  6. Model deployment with Shiny or plumber APIs
- **Success Metrics**: Reproducible analysis with clear insights and actionable recommendations

#### Production R System Architecture
- **Purpose**: Deploy R applications and models in production environments
- **When to Use**: Scaling R solutions for enterprise use and real-time analytics
- **Implementation Steps**:
  1. Containerize R applications with Docker
  2. Implement API endpoints with plumber or OpenCPU
  3. Set up monitoring and logging systems
  4. Establish CI/CD pipelines for R packages
  5. Configure load balancing and scaling
  6. Implement security and authentication
- **Success Metrics**: Scalable R systems with reliable performance and maintainability

### Process Integration
#### Enterprise Data Science Workflow
```r
# Data Science Project Template
# File: analysis_template.R

# Project setup and configuration
library(here)          # Project-relative paths
library(config)        # Configuration management
library(logger)        # Logging
library(tidyverse)     # Core data science packages
library(data.table)    # High-performance data manipulation

# Configure logging
log_threshold(INFO)
log_appender(appender_file("analysis.log"))

# Load configuration
config <- config::get()

# Data acquisition module
acquire_data <- function(source_config) {
  log_info("Starting data acquisition from {source_config$type}")
  
  switch(source_config$type,
    "database" = {
      con <- DBI::dbConnect(
        RPostgres::Postgres(),
        host = source_config$host,
        port = source_config$port,
        dbname = source_config$database,
        user = source_config$user,
        password = source_config$password
      )
      
      data <- DBI::dbGetQuery(con, source_config$query)
      DBI::dbDisconnect(con)
      
      as.data.table(data)
    },
    "file" = {
      switch(tools::file_ext(source_config$path),
        "csv" = fread(source_config$path),
        "parquet" = arrow::read_parquet(source_config$path),
        "json" = jsonlite::fromJSON(source_config$path),
        stop("Unsupported file format")
      )
    },
    "api" = {
      response <- httr::GET(
        source_config$url,
        httr::add_headers(.headers = source_config$headers),
        query = source_config$params
      )
      
      httr::stop_for_status(response)
      content <- httr::content(response, "text", encoding = "UTF-8")
      jsonlite::fromJSON(content)
    },
    stop("Unsupported data source type")
  )
}

# Data cleaning and validation
clean_data <- function(raw_data, cleaning_config) {
  log_info("Starting data cleaning and validation")
  
  cleaned_data <- raw_data %>%
    # Remove duplicates
    distinct() %>%
    # Handle missing values
    {
      if (cleaning_config$remove_na) {
        drop_na(.)
      } else {
        .
      }
    } %>%
    # Data type conversions
    mutate(across(all_of(cleaning_config$date_columns), as.Date)) %>%
    mutate(across(all_of(cleaning_config$numeric_columns), as.numeric)) %>%
    mutate(across(all_of(cleaning_config$factor_columns), as.factor)) %>%
    # Outlier detection and handling
    {
      if (cleaning_config$handle_outliers) {
        handle_outliers(., cleaning_config$outlier_method)
      } else {
        .
      }
    } %>%
    # Data validation
    validate_data_quality(cleaning_config$validation_rules)
  
  log_info("Data cleaning completed. Rows: {nrow(cleaned_data)}, Columns: {ncol(cleaned_data)}")
  cleaned_data
}

# Outlier detection and handling
handle_outliers <- function(data, method = "iqr") {
  numeric_cols <- data %>% select(where(is.numeric)) %>% names()
  
  for (col in numeric_cols) {
    if (method == "iqr") {
      Q1 <- quantile(data[[col]], 0.25, na.rm = TRUE)
      Q3 <- quantile(data[[col]], 0.75, na.rm = TRUE)
      IQR <- Q3 - Q1
      lower_bound <- Q1 - 1.5 * IQR
      upper_bound <- Q3 + 1.5 * IQR
      
      data[[col]] <- ifelse(
        data[[col]] < lower_bound | data[[col]] > upper_bound,
        NA,
        data[[col]]
      )
    }
  }
  
  data
}

# Data validation
validate_data_quality <- function(data, rules) {
  validation_results <- list()
  
  for (rule in rules) {
    result <- switch(rule$type,
      "completeness" = {
        missing_rate <- sum(is.na(data[[rule$column]])) / nrow(data)
        missing_rate <= rule$threshold
      },
      "uniqueness" = {
        duplicate_rate <- 1 - (length(unique(data[[rule$column]])) / nrow(data))
        duplicate_rate <= rule$threshold
      },
      "range" = {
        values <- data[[rule$column]]
        all(values >= rule$min & values <= rule$max, na.rm = TRUE)
      },
      "pattern" = {
        all(str_detect(data[[rule$column]], rule$regex), na.rm = TRUE)
      }
    )
    
    validation_results[[rule$name]] <- result
    
    if (!result) {
      log_warn("Data quality rule failed: {rule$name}")
    }
  }
  
  # Stop if critical validations fail
  critical_failures <- validation_results[names(validation_results) %in% rules[rules$critical == TRUE, "name"]]
  if (any(!unlist(critical_failures))) {
    stop("Critical data quality validations failed")
  }
  
  data
}

# Exploratory data analysis
explore_data <- function(data, target_variable = NULL) {
  log_info("Starting exploratory data analysis")
  
  # Basic summary statistics
  summary_stats <- data %>%
    select(where(is.numeric)) %>%
    summarise(across(everything(), list(
      mean = ~ mean(.x, na.rm = TRUE),
      median = ~ median(.x, na.rm = TRUE),
      sd = ~ sd(.x, na.rm = TRUE),
      min = ~ min(.x, na.rm = TRUE),
      max = ~ max(.x, na.rm = TRUE),
      q25 = ~ quantile(.x, 0.25, na.rm = TRUE),
      q75 = ~ quantile(.x, 0.75, na.rm = TRUE)
    ))) %>%
    pivot_longer(everything(), names_to = c("variable", "statistic"), names_sep = "_") %>%
    pivot_wider(names_from = statistic, values_from = value)
  
  # Correlation analysis
  correlation_matrix <- data %>%
    select(where(is.numeric)) %>%
    cor(use = "complete.obs")
  
  # Categorical variable analysis
  categorical_summary <- data %>%
    select(where(is.factor)) %>%
    map_dfr(~ tibble(
      unique_values = length(unique(.x)),
      most_frequent = names(sort(table(.x), decreasing = TRUE))[1],
      frequency = max(table(.x))
    ), .id = "variable")
  
  # Missing value analysis
  missing_analysis <- data %>%
    summarise(across(everything(), ~ sum(is.na(.x)))) %>%
    pivot_longer(everything(), names_to = "variable", values_to = "missing_count") %>%
    mutate(missing_percentage = missing_count / nrow(data) * 100) %>%
    arrange(desc(missing_percentage))
  
  # Generate visualizations
  plots <- list()
  
  # Distribution plots for numeric variables
  numeric_vars <- data %>% select(where(is.numeric)) %>% names()
  for (var in numeric_vars[1:min(6, length(numeric_vars))]) {
    plots[[paste0("dist_", var)]] <- ggplot(data, aes_string(x = var)) +
      geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7) +
      theme_minimal() +
      labs(title = paste("Distribution of", var))
  }
  
  # Correlation heatmap
  if (length(numeric_vars) > 1) {
    plots$correlation_heatmap <- correlation_matrix %>%
      as.data.frame() %>%
      rownames_to_column("var1") %>%
      pivot_longer(-var1, names_to = "var2", values_to = "correlation") %>%
      ggplot(aes(var1, var2, fill = correlation)) +
      geom_tile() +
      scale_fill_gradient2(low = "blue", mid = "white", high = "red") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = "Correlation Matrix")
  }
  
  # Target variable analysis if provided
  if (!is.null(target_variable) && target_variable %in% names(data)) {
    if (is.numeric(data[[target_variable]])) {
      # Regression analysis plots
      for (var in numeric_vars[numeric_vars != target_variable][1:min(4, length(numeric_vars) - 1)]) {
        plots[[paste0("scatter_", var)]] <- ggplot(data, aes_string(x = var, y = target_variable)) +
          geom_point(alpha = 0.6) +
          geom_smooth(method = "lm", se = TRUE) +
          theme_minimal() +
          labs(title = paste(target_variable, "vs", var))
      }
    } else {
      # Classification analysis plots
      factor_vars <- data %>% select(where(is.factor)) %>% names()
      for (var in factor_vars[factor_vars != target_variable][1:min(4, length(factor_vars) - 1)]) {
        plots[[paste0("box_", var)]] <- ggplot(data, aes_string(x = var, y = target_variable)) +
          geom_boxplot() +
          theme_minimal() +
          theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
          labs(title = paste(target_variable, "by", var))
      }
    }
  }
  
  list(
    summary_stats = summary_stats,
    correlation_matrix = correlation_matrix,
    categorical_summary = categorical_summary,
    missing_analysis = missing_analysis,
    plots = plots
  )
}

# Statistical modeling
build_model <- function(data, model_config) {
  log_info("Building statistical model: {model_config$type}")
  
  # Prepare data
  if (!is.null(model_config$train_test_split)) {
    set.seed(model_config$seed %||% 42)
    train_indices <- sample(nrow(data), nrow(data) * model_config$train_test_split)
    train_data <- data[train_indices, ]
    test_data <- data[-train_indices, ]
  } else {
    train_data <- data
    test_data <- NULL
  }
  
  # Build model based on type
  model <- switch(model_config$type,
    "linear_regression" = {
      formula_str <- paste(model_config$target, "~", paste(model_config$features, collapse = " + "))
      lm(as.formula(formula_str), data = train_data)
    },
    "logistic_regression" = {
      formula_str <- paste(model_config$target, "~", paste(model_config$features, collapse = " + "))
      glm(as.formula(formula_str), data = train_data, family = binomial())
    },
    "random_forest" = {
      library(randomForest)
      formula_str <- paste(model_config$target, "~", paste(model_config$features, collapse = " + "))
      randomForest(as.formula(formula_str), data = train_data, 
                   ntree = model_config$ntree %||% 500)
    },
    "xgboost" = {
      library(xgboost)
      
      # Prepare data for xgboost
      train_matrix <- model.matrix(
        as.formula(paste("~", paste(model_config$features, collapse = " + "))), 
        data = train_data
      )[, -1]  # Remove intercept
      
      train_label <- train_data[[model_config$target]]
      
      xgb.train(
        data = xgb.DMatrix(data = train_matrix, label = train_label),
        params = model_config$params %||% list(
          objective = "reg:squarederror",
          max_depth = 6,
          eta = 0.3
        ),
        nrounds = model_config$nrounds %||% 100
      )
    },
    stop("Unsupported model type")
  )
  
  # Model evaluation
  evaluation <- NULL
  if (!is.null(test_data)) {
    evaluation <- evaluate_model(model, test_data, model_config)
  }
  
  list(
    model = model,
    train_data = train_data,
    test_data = test_data,
    evaluation = evaluation,
    config = model_config
  )
}

# Model evaluation
evaluate_model <- function(model, test_data, model_config) {
  predictions <- predict(model, test_data)
  actual <- test_data[[model_config$target]]
  
  if (model_config$type %in% c("linear_regression")) {
    # Regression metrics
    list(
      rmse = sqrt(mean((predictions - actual)^2)),
      mae = mean(abs(predictions - actual)),
      r_squared = cor(predictions, actual)^2,
      mape = mean(abs((actual - predictions) / actual)) * 100
    )
  } else if (model_config$type %in% c("logistic_regression", "random_forest")) {
    # Classification metrics
    if (model_config$type == "logistic_regression") {
      predictions <- ifelse(predictions > 0.5, 1, 0)
    }
    
    confusion_matrix <- table(Actual = actual, Predicted = predictions)
    accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
    
    list(
      accuracy = accuracy,
      confusion_matrix = confusion_matrix,
      precision = confusion_matrix[2, 2] / sum(confusion_matrix[, 2]),
      recall = confusion_matrix[2, 2] / sum(confusion_matrix[2, ]),
      f1_score = 2 * (precision * recall) / (precision + recall)
    )
  }
}

# Main analysis pipeline
run_analysis <- function(config_file = "config.yml") {
  log_info("Starting analysis pipeline")
  
  # Load configuration
  config <- yaml::read_yaml(config_file)
  
  # Execute pipeline stages
  tryCatch({
    # Data acquisition
    raw_data <- acquire_data(config$data_source)
    log_info("Data acquired: {nrow(raw_data)} rows, {ncol(raw_data)} columns")
    
    # Data cleaning
    clean_data_result <- clean_data(raw_data, config$cleaning)
    
    # Exploratory data analysis
    eda_results <- explore_data(clean_data_result, config$target_variable)
    
    # Model building
    if (!is.null(config$model)) {
      model_results <- build_model(clean_data_result, config$model)
      log_info("Model training completed")
    }
    
    # Generate report
    generate_report(
      data = clean_data_result,
      eda = eda_results,
      model = if (exists("model_results")) model_results else NULL,
      config = config
    )
    
    log_info("Analysis pipeline completed successfully")
    
  }, error = function(e) {
    log_error("Analysis pipeline failed: {e$message}")
    stop(e)
  })
}

# Report generation
generate_report <- function(data, eda, model = NULL, config) {
  log_info("Generating analysis report")
  
  # Create report directory
  dir.create("reports", showWarnings = FALSE)
  
  # Save results
  saveRDS(data, "reports/cleaned_data.rds")
  saveRDS(eda, "reports/eda_results.rds")
  if (!is.null(model)) {
    saveRDS(model, "reports/model_results.rds")
  }
  
  # Generate R Markdown report
  rmarkdown::render(
    "report_template.Rmd",
    output_file = paste0("reports/analysis_report_", Sys.Date(), ".html"),
    params = list(
      data = data,
      eda = eda,
      model = model,
      config = config
    )
  )
  
  log_info("Report generated successfully")
}
```

#### R Package Development Framework
```r
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
```

## Best Practices

### High-Performance R Programming
```r
# Performance optimization techniques

# 1. Vectorization over loops
# Bad
result <- numeric(length(x))
for (i in seq_along(x)) {
  result[i] <- x[i] * 2
}

# Good
result <- x * 2

# 2. Pre-allocate memory
# Bad
result <- c()
for (i in 1:10000) {
  result <- c(result, i^2)
}

# Good
result <- numeric(10000)
for (i in 1:10000) {
  result[i] <- i^2
}

# 3. Use data.table for large datasets
library(data.table)

# Fast aggregation
dt <- as.data.table(data)
result <- dt[, .(mean_value = mean(value)), by = group]

# 4. Parallel processing
library(future.apply)
plan(multisession)

# Parallel apply
result <- future_lapply(data_list, expensive_function)

# 5. Memory profiling
library(profvis)

profvis({
  # Your code here
  expensive_computation()
})

# 6. Efficient string operations
library(stringi)

# Use stringi for Unicode-aware string operations
stri_replace_all_regex(text, pattern, replacement)

# 7. Database integration
library(DBI)
library(dbplyr)

# Use database backends for large data
con <- dbConnect(RSQLite::SQLite(), ":memory:")
data_db <- copy_to(con, large_dataset)

result <- data_db %>%
  filter(condition) %>%
  summarise(metric = mean(value)) %>%
  collect()

# 8. Efficient data I/O
library(arrow)
library(fst)

# Fast binary formats
write_parquet(data, "data.parquet")
write_fst(data, "data.fst")
```

### Production R Deployment
```r
# Production deployment framework

# 1. API development with plumber
library(plumber)

#* @apiTitle Data Analysis API
#* @apiDescription API for data analysis and prediction services

#* Predict values
#* @param input Input data as JSON
#* @post /predict
function(req, input) {
  tryCatch({
    # Parse input
    data <- jsonlite::fromJSON(input)
    
    # Validate input
    if (!validate_input(data)) {
      stop("Invalid input data")
    }
    
    # Make prediction
    model <- readRDS("model.rds")
    prediction <- predict(model, data)
    
    # Return result
    list(
      prediction = prediction,
      timestamp = Sys.time(),
      status = "success"
    )
  }, error = function(e) {
    list(
      error = e$message,
      timestamp = Sys.time(),
      status = "error"
    )
  })
}

#* Health check
#* @get /health
function() {
  list(
    status = "healthy",
    timestamp = Sys.time(),
    version = packageVersion("mypackage")
  )
}

# 2. Docker deployment
# Dockerfile
dockerfile_content <- '
FROM rocker/r-ver:4.3.0

RUN apt-get update && apt-get install -y \\
    libcurl4-openssl-dev \\
    libssl-dev \\
    libxml2-dev

RUN R -e "install.packages(c(\'plumber\', \'jsonlite\', \'logger\'))"

COPY . /app
WORKDIR /app

RUN R -e "source(\'setup.R\')"

EXPOSE 8000

CMD ["R", "-e", "plumber::plumb(\'api.R\')$run(host=\'0.0.0.0\', port=8000)"]
'

writeLines(dockerfile_content, "Dockerfile")

# 3. Configuration management
library(config)

# config.yml
config_content <- '
default:
  database:
    host: localhost
    port: 5432
    dbname: mydb
  
  model:
    path: models/production_model.rds
  
  logging:
    level: INFO
    file: app.log

production:
  database:
    host: !expr Sys.getenv("DB_HOST")
    port: !expr as.numeric(Sys.getenv("DB_PORT"))
    dbname: !expr Sys.getenv("DB_NAME")
  
  logging:
    level: WARN
'

writeLines(config_content, "config.yml")

# 4. Monitoring and logging
library(logger)

setup_logging <- function() {
  log_formatter(formatter_json)
  log_appender(appender_file("app.log"))
  log_threshold(INFO)
}

monitor_performance <- function() {
  # Custom metrics collection
  start_time <- Sys.time()
  
  # Your function logic here
  
  execution_time <- as.numeric(Sys.time() - start_time)
  
  log_info("Function executed", 
           execution_time = execution_time,
           memory_usage = pryr::mem_used())
}

# 5. Error handling and recovery
safe_execute <- function(func, ..., max_retries = 3) {
  for (attempt in 1:max_retries) {
    tryCatch({
      return(func(...))
    }, error = function(e) {
      log_warn("Attempt {attempt} failed: {e$message}")
      if (attempt == max_retries) {
        log_error("All attempts failed")
        stop(e)
      }
      Sys.sleep(2^attempt)  # Exponential backoff
    })
  }
}
```

## Common Patterns and Examples

### Pattern 1: Advanced Data Manipulation
**Scenario**: Complex data transformation and analysis workflows
**Implementation**:
```r
# Advanced data manipulation with tidyverse and data.table

library(tidyverse)
library(data.table)
library(lubridate)

# Complex data transformation pipeline
advanced_data_pipeline <- function(raw_data) {
  
  # Data.table approach for performance
  dt <- as.data.table(raw_data)
  
  # Complex aggregations with multiple grouping variables
  summary_stats <- dt[,
    .(
      total_sales = sum(sales, na.rm = TRUE),
      avg_price = mean(price, na.rm = TRUE),
      median_quantity = median(quantity, na.rm = TRUE),
      unique_customers = uniqueN(customer_id),
      sales_variance = var(sales, na.rm = TRUE),
      price_cv = sd(price, na.rm = TRUE) / mean(price, na.rm = TRUE)
    ),
    by = .(region, product_category, quarter = quarter(date))
  ]
  
  # Window functions and rolling calculations
  dt[order(date), 
     `:=`(
       sales_ma_7 = frollmean(sales, 7),
       sales_growth = (sales - shift(sales, 1)) / shift(sales, 1),
       cumulative_sales = cumsum(sales),
       rank_in_region = frank(-sales)
     ),
     by = region]
  
  # Complex filtering with multiple conditions
  high_value_customers <- dt[
    sales > quantile(sales, 0.8, na.rm = TRUE) &
    date >= as.Date("2023-01-01") &
    !is.na(customer_id),
    .(
      customer_id,
      total_spent = sum(sales),
      avg_order_value = mean(sales),
      order_frequency = .N,
      last_purchase = max(date)
    ),
    by = customer_id
  ][order(-total_spent)]
  
  # Reshaping data for analysis
  monthly_pivot <- dt[,
    .(monthly_sales = sum(sales)),
    by = .(product = product_category, month = floor_date(date, "month"))
  ] %>%
    pivot_wider(
      names_from = month,
      values_from = monthly_sales,
      values_fill = 0
    )
  
  # Text analysis integration
  library(tidytext)
  
  text_analysis <- dt[!is.na(customer_feedback),
    .(customer_id, feedback = customer_feedback)
  ] %>%
    unnest_tokens(word, feedback) %>%
    anti_join(stop_words, by = "word") %>%
    count(customer_id, word, sort = TRUE) %>%
    bind_tf_idf(word, customer_id, n)
  
  list(
    summary_stats = summary_stats,
    enriched_data = dt,
    high_value_customers = high_value_customers,
    monthly_pivot = monthly_pivot,
    text_analysis = text_analysis
  )
}

# Time series analysis
time_series_analysis <- function(data, date_col, value_col) {
  library(forecast)
  library(prophet)
  
  # Prepare time series data
  ts_data <- data %>%
    arrange(!!sym(date_col)) %>%
    pull(!!sym(value_col)) %>%
    ts(frequency = 12)  # Monthly data
  
  # ARIMA forecasting
  arima_model <- auto.arima(ts_data)
  arima_forecast <- forecast(arima_model, h = 12)
  
  # Prophet forecasting
  prophet_data <- data %>%
    select(ds = !!sym(date_col), y = !!sym(value_col))
  
  prophet_model <- prophet(prophet_data)
  future_dates <- make_future_dataframe(prophet_model, periods = 12, freq = "month")
  prophet_forecast <- predict(prophet_model, future_dates)
  
  # Seasonal decomposition
  decomposition <- decompose(ts_data)
  
  # Change point detection
  library(changepoint)
  cpt_var <- cpt.var(ts_data)
  cpt_mean <- cpt.mean(ts_data)
  
  list(
    arima_model = arima_model,
    arima_forecast = arima_forecast,
    prophet_model = prophet_model,
    prophet_forecast = prophet_forecast,
    decomposition = decomposition,
    changepoints = list(variance = cpt_var, mean = cpt_mean)
  )
}
```
**Expected Outcomes**: Efficient data processing with comprehensive analysis capabilities

### Pattern 2: Interactive Dashboards with Shiny
**Scenario**: Create interactive web applications for data exploration
**Implementation**:
```r
# Advanced Shiny application
library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(leaflet)

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Advanced Analytics Dashboard"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
      menuItem("Data Exploration", tabName = "exploration", icon = icon("search")),
      menuItem("Model Performance", tabName = "models", icon = icon("chart-line")),
      menuItem("Geographic Analysis", tabName = "geo", icon = icon("map"))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Overview tab
      tabItem(tabName = "overview",
        fluidRow(
          valueBoxOutput("total_revenue"),
          valueBoxOutput("avg_order_value"),
          valueBoxOutput("customer_count")
        ),
        fluidRow(
          box(
            title = "Revenue Trend", status = "primary", solidHeader = TRUE,
            width = 8, height = 400,
            plotlyOutput("revenue_trend")
          ),
          box(
            title = "Top Products", status = "success", solidHeader = TRUE,
            width = 4, height = 400,
            DT::dataTableOutput("top_products")
          )
        )
      ),
      
      # Data exploration tab
      tabItem(tabName = "exploration",
        fluidRow(
          box(
            title = "Filters", status = "warning", solidHeader = TRUE,
            width = 3,
            dateRangeInput("date_range", "Date Range:",
                           start = Sys.Date() - 365,
                           end = Sys.Date()),
            selectInput("region", "Region:",
                        choices = c("All", unique(data$region))),
            selectInput("product", "Product Category:",
                        choices = c("All", unique(data$product_category))),
            actionButton("apply_filters", "Apply Filters", class = "btn-primary")
          ),
          box(
            title = "Data Table", status = "primary", solidHeader = TRUE,
            width = 9,
            DT::dataTableOutput("filtered_data")
          )
        ),
        fluidRow(
          box(
            title = "Distribution Analysis", status = "info", solidHeader = TRUE,
            width = 6,
            plotlyOutput("distribution_plot")
          ),
          box(
            title = "Correlation Matrix", status = "info", solidHeader = TRUE,
            width = 6,
            plotlyOutput("correlation_plot")
          )
        )
      ),
      
      # Models tab
      tabItem(tabName = "models",
        fluidRow(
          box(
            title = "Model Selection", status = "warning", solidHeader = TRUE,
            width = 3,
            selectInput("model_type", "Model Type:",
                        choices = c("Linear Regression", "Random Forest", "XGBoost")),
            numericInput("test_size", "Test Set Size:", value = 0.2, min = 0.1, max = 0.5),
            actionButton("train_model", "Train Model", class = "btn-success")
          ),
          box(
            title = "Model Performance", status = "primary", solidHeader = TRUE,
            width = 9,
            verbatimTextOutput("model_summary"),
            plotlyOutput("model_performance")
          )
        )
      ),
      
      # Geographic analysis tab
      tabItem(tabName = "geo",
        fluidRow(
          box(
            title = "Geographic Sales Distribution", status = "primary", solidHeader = TRUE,
            width = 12,
            leafletOutput("sales_map", height = 600)
          )
        )
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  
  # Reactive data
  filtered_data <- eventReactive(input$apply_filters, {
    data %>%
      filter(
        date >= input$date_range[1],
        date <= input$date_range[2],
        if (input$region != "All") region == input$region else TRUE,
        if (input$product != "All") product_category == input$product else TRUE
      )
  })
  
  # Value boxes
  output$total_revenue <- renderValueBox({
    valueBox(
      value = scales::dollar(sum(data$sales, na.rm = TRUE)),
      subtitle = "Total Revenue",
      icon = icon("dollar-sign"),
      color = "green"
    )
  })
  
  output$avg_order_value <- renderValueBox({
    valueBox(
      value = scales::dollar(mean(data$sales, na.rm = TRUE)),
      subtitle = "Average Order Value",
      icon = icon("shopping-cart"),
      color = "blue"
    )
  })
  
  output$customer_count <- renderValueBox({
    valueBox(
      value = length(unique(data$customer_id)),
      subtitle = "Unique Customers",
      icon = icon("users"),
      color = "orange"
    )
  })
  
  # Plots
  output$revenue_trend <- renderPlotly({
    monthly_revenue <- data %>%
      group_by(month = floor_date(date, "month")) %>%
      summarise(revenue = sum(sales, na.rm = TRUE))
    
    p <- ggplot(monthly_revenue, aes(x = month, y = revenue)) +
      geom_line(size = 1.2, color = "steelblue") +
      geom_point(size = 2, color = "darkblue") +
      scale_y_continuous(labels = scales::dollar_format()) +
      theme_minimal() +
      labs(title = "Monthly Revenue Trend", x = "Month", y = "Revenue")
    
    ggplotly(p)
  })
  
  output$filtered_data <- DT::renderDataTable({
    filtered_data()
  }, options = list(scrollX = TRUE, pageLength = 10))
  
  output$distribution_plot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = sales)) +
      geom_histogram(bins = 30, fill = "lightblue", alpha = 0.7) +
      theme_minimal() +
      labs(title = "Sales Distribution", x = "Sales", y = "Frequency")
    
    ggplotly(p)
  })
  
  output$correlation_plot <- renderPlotly({
    numeric_data <- filtered_data() %>% select(where(is.numeric))
    cor_matrix <- cor(numeric_data, use = "complete.obs")
    
    p <- cor_matrix %>%
      as.data.frame() %>%
      rownames_to_column("var1") %>%
      pivot_longer(-var1, names_to = "var2", values_to = "correlation") %>%
      ggplot(aes(var1, var2, fill = correlation, text = paste("Correlation:", round(correlation, 3)))) +
      geom_tile() +
      scale_fill_gradient2(low = "red", mid = "white", high = "blue") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(p, tooltip = "text")
  })
  
  # Model training
  model_results <- eventReactive(input$train_model, {
    # Implement model training logic here
    # Return model results
  })
  
  output$model_summary <- renderPrint({
    req(model_results())
    summary(model_results()$model)
  })
  
  # Geographic visualization
  output$sales_map <- renderLeaflet({
    geo_data <- data %>%
      group_by(region, latitude, longitude) %>%
      summarise(total_sales = sum(sales, na.rm = TRUE))
    
    leaflet(geo_data) %>%
      addTiles() %>%
      addCircleMarkers(
        lng = ~longitude,
        lat = ~latitude,
        radius = ~sqrt(total_sales) / 1000,
        popup = ~paste("Region:", region, "<br>Sales:", scales::dollar(total_sales)),
        fillOpacity = 0.6
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
```
**Expected Outcomes**: Interactive dashboard with real-time data exploration and model training capabilities

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Using Loops Instead of Vectorization
- **Description**: Writing explicit loops for operations that can be vectorized
- **Why It's Problematic**: Significantly slower performance and more verbose code
- **Better Approach**: Use vectorized operations and apply functions

#### Anti-Pattern 2: Not Managing Memory Properly
- **Description**: Creating large intermediate objects without cleaning up
- **Why It's Problematic**: Memory exhaustion and poor performance
- **Better Approach**: Use data.table, memory profiling, and proper garbage collection

## Tools and Resources

### Essential R Packages by Category
```r
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
```

### Development Environment Setup
```r
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
```

### Learning Resources
- **R for Data Science**: https://r4ds.had.co.nz/
- **Advanced R**: https://adv-r.hadley.nz/
- **R Packages**: https://r-pkgs.org/
- **The R Graph Gallery**: https://r-graph-gallery.com/
- **RStudio Cheatsheets**: https://rstudio.com/resources/cheatsheets/
- **CRAN Task Views**: https://cran.r-project.org/web/views/

## Quality and Compliance

### Quality Standards
- Follow tidyverse style guide for consistent code formatting
- Use roxygen2 for comprehensive function documentation
- Implement unit tests with testthat for all functions
- Use version control with meaningful commit messages
- Create reproducible analyses with R Markdown

### Security Standards
- Validate all user inputs in Shiny applications
- Use environment variables for sensitive configuration
- Implement proper authentication for production deployments
- Regular package updates for security patches
- Secure database connections with encrypted credentials

### Performance Standards
- Profile code performance with profvis
- Use vectorized operations over loops
- Implement parallel processing for computationally intensive tasks
- Monitor memory usage and optimize data structures
- Use efficient data formats (parquet, fst) for large datasets

## AI Assistant Guidelines

When helping with R programming:

1. **Statistical Accuracy**: Ensure statistical methods are appropriate for the data and research questions
2. **Performance Optimization**: Prioritize vectorized operations and efficient data structures
3. **Reproducibility**: Emphasize reproducible research practices with R Markdown and version control
4. **Package Ecosystem**: Leverage the rich R package ecosystem for specialized tasks
5. **Data Quality**: Implement robust data validation and cleaning procedures
6. **Visualization Standards**: Create clear, informative visualizations following best practices
7. **Documentation**: Ensure comprehensive documentation for analysis workflows
8. **Production Readiness**: Support deployment of R applications and models in production environments

### Decision Making Framework
When helping teams with R:

1. **Problem Assessment**: Understand the statistical and analytical requirements
2. **Tool Selection**: Choose appropriate R packages and methods for the task
3. **Performance Evaluation**: Assess computational requirements and optimization needs
4. **Deployment Planning**: Plan for production deployment and scalability
5. **Quality Assurance**: Implement testing and validation procedures

### Code Generation Rules
- Generate R code following tidyverse style conventions
- Include comprehensive error handling and input validation
- Use appropriate statistical methods with proper assumptions checking
- Implement efficient data processing with vectorized operations
- Generate well-documented functions with roxygen2 comments
- Include unit tests and examples for all functions
- Provide clear data visualization with ggplot2 best practices
- Support reproducible research with R Markdown integration

### Quality Enforcement
- ✅ Enforce tidyverse style guide conventions
- ✅ Require roxygen2 documentation for all functions
- ✅ Block generation of inefficient loop-based solutions when vectorization is possible
- ✅ Require statistical method validation and assumption checking
- ✅ Enforce proper error handling and input validation
- ✅ Promote reproducible research practices with R Markdown
- ✅ Require unit tests for critical functions
- ✅ Enforce secure coding practices for production deployments