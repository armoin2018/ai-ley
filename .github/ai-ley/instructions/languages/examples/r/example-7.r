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