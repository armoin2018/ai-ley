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