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