resource "snowflake_database" "analytics" {
  name    = "ANALYTICS"
  comment = "Analytics database"
}

resource "snowflake_schema" "sales" {
  database = snowflake_database.analytics.name
  name     = "SALES"
  comment  = "Sales data schema"
}

resource "snowflake_warehouse" "analytics_wh" {
  name           = "ANALYTICS_WH"
  warehouse_size = "LARGE"
  auto_suspend   = 300
  auto_resume    = true
  
  min_cluster_count = 1
  max_cluster_count = 10
  scaling_policy    = "STANDARD"
}