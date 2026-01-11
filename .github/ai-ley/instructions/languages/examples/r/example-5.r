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