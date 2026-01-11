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