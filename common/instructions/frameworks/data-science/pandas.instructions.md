# Pandas Data Science Framework Instructions

## Overview
- **Framework Name**: Pandas (Python Data Analysis Library)
- **Version**: 2.0+ (Latest stable)
- **Type**: Data manipulation and analysis library
- **Language**: Python
- **Use Cases**: Data cleaning, transformation, analysis, time series analysis, data I/O

## Installation & Setup
```bash
# Standard installation
pip install pandas

# With conda
conda install pandas

# Development version
pip install --pre --upgrade pandas

# With optional dependencies
pip install pandas[all]
```

## Project Structure
```
data-analysis-project/
├── data/
│   ├── raw/
│   │   ├── csv/
│   │   ├── json/
│   │   └── excel/
│   └── processed/
├── notebooks/
│   ├── exploratory/
│   └── analysis/
├── src/
│   ├── data_loader.py
│   ├── data_cleaner.py
│   ├── analyzer.py
│   └── utils.py
├── tests/
├── requirements.txt
└── README.md
```

## Core Concepts

### DataFrame and Series Operations
- **Purpose**: Primary data structures for labeled, structured data
- **Usage**: Foundation for all data manipulation and analysis
- **Example**: 
```python
import pandas as pd
import numpy as np

# DataFrame creation
df = pd.DataFrame({
    'name': ['Alice', 'Bob', 'Charlie'],
    'age': [25, 30, 35],
    'salary': [50000, 60000, 70000]
})

# Series operations
ages = df['age']
filtered_data = df[df['age'] > 28]
grouped_data = df.groupby('department').agg({'salary': 'mean'})
```

### Data Loading and I/O
- **Purpose**: Read and write data from various sources
- **Usage**: Interface with different data formats and databases
- **Example**:
```python
# Reading data
df_csv = pd.read_csv('data.csv', parse_dates=['date_column'])
df_excel = pd.read_excel('data.xlsx', sheet_name='Sheet1')
df_json = pd.read_json('data.json', orient='records')
df_sql = pd.read_sql('SELECT * FROM table', connection)

# Writing data
df.to_csv('output.csv', index=False)
df.to_excel('output.xlsx', sheet_name='Results')
df.to_parquet('output.parquet', compression='snappy')
```

## Development Workflow
1. **Setup**: Install pandas and configure data environment
2. **Development**: Load, clean, and transform data using pandas operations
3. **Testing**: Validate data quality and transformation logic
4. **Building**: Create reusable data processing pipelines
5. **Deployment**: Export processed data or integrate with ML pipelines

## Best Practices

### Performance Optimization
- Use vectorized operations instead of apply() when possible
- Leverage categorical data types for string columns with limited unique values
- Use chunk processing for large datasets that don't fit in memory
- Optimize memory usage with appropriate data types

### Data Quality and Validation
```python
def validate_dataframe(df, required_columns=None, date_columns=None):
    """Comprehensive data validation"""
    validation_report = {}
    
    # Check required columns
    if required_columns:
        missing_cols = set(required_columns) - set(df.columns)
        validation_report['missing_columns'] = list(missing_cols)
    
    # Check for null values
    null_counts = df.isnull().sum()
    validation_report['null_counts'] = null_counts[null_counts > 0].to_dict()
    
    # Check data types
    validation_report['data_types'] = df.dtypes.to_dict()
    
    # Check duplicates
    validation_report['duplicate_rows'] = df.duplicated().sum()
    
    # Validate date columns
    if date_columns:
        for col in date_columns:
            if col in df.columns:
                try:
                    pd.to_datetime(df[col])
                    validation_report[f'{col}_date_valid'] = True
                except:
                    validation_report[f'{col}_date_valid'] = False
    
    return validation_report
```

## Common Patterns

### Data Cleaning Pipeline
```python
class DataCleaner:
    def __init__(self):
        self.cleaning_steps = []
    
    def remove_duplicates(self, df, subset=None):
        """Remove duplicate rows"""
        before_count = len(df)
        df_clean = df.drop_duplicates(subset=subset)
        after_count = len(df_clean)
        self.cleaning_steps.append(f"Removed {before_count - after_count} duplicates")
        return df_clean
    
    def handle_missing_values(self, df, strategy='drop', fill_values=None):
        """Handle missing values with various strategies"""
        if strategy == 'drop':
            df_clean = df.dropna()
            self.cleaning_steps.append("Dropped rows with missing values")
        elif strategy == 'fill':
            if fill_values:
                df_clean = df.fillna(fill_values)
            else:
                # Fill numeric columns with median, categorical with mode
                numeric_cols = df.select_dtypes(include=[np.number]).columns
                categorical_cols = df.select_dtypes(include=['object']).columns
                
                fill_dict = {}
                for col in numeric_cols:
                    fill_dict[col] = df[col].median()
                for col in categorical_cols:
                    fill_dict[col] = df[col].mode()[0] if not df[col].mode().empty else 'Unknown'
                
                df_clean = df.fillna(fill_dict)
            
            self.cleaning_steps.append(f"Filled missing values with strategy: {strategy}")
        
        return df_clean
    
    def standardize_columns(self, df):
        """Standardize column names"""
        df_clean = df.copy()
        df_clean.columns = df_clean.columns.str.lower().str.replace(' ', '_')
        self.cleaning_steps.append("Standardized column names")
        return df_clean
    
    def convert_data_types(self, df, type_mapping):
        """Convert data types according to mapping"""
        df_clean = df.copy()
        for col, dtype in type_mapping.items():
            if col in df_clean.columns:
                if dtype == 'category':
                    df_clean[col] = df_clean[col].astype('category')
                elif dtype == 'datetime':
                    df_clean[col] = pd.to_datetime(df_clean[col], errors='coerce')
                else:
                    df_clean[col] = df_clean[col].astype(dtype)
        
        self.cleaning_steps.append(f"Converted data types: {type_mapping}")
        return df_clean
```

### Advanced Data Analysis
```python
def comprehensive_data_analysis(df):
    """Perform comprehensive data analysis"""
    analysis_report = {}
    
    # Basic statistics
    analysis_report['basic_stats'] = df.describe(include='all')
    
    # Missing value analysis
    missing_analysis = df.isnull().sum().sort_values(ascending=False)
    analysis_report['missing_values'] = missing_analysis[missing_analysis > 0]
    
    # Correlation analysis (numeric columns only)
    numeric_df = df.select_dtypes(include=[np.number])
    if len(numeric_df.columns) > 1:
        analysis_report['correlations'] = numeric_df.corr()
    
    # Value counts for categorical columns
    categorical_cols = df.select_dtypes(include=['object', 'category']).columns
    analysis_report['value_counts'] = {}
    for col in categorical_cols:
        analysis_report['value_counts'][col] = df[col].value_counts().head(10)
    
    # Data types summary
    analysis_report['data_types'] = df.dtypes.value_counts()
    
    # Memory usage
    analysis_report['memory_usage'] = df.memory_usage(deep=True).sum() / 1024**2  # MB
    
    return analysis_report
```

## Configuration
### Performance Settings
```python
# Display options
pd.set_option('display.max_rows', 100)
pd.set_option('display.max_columns', 20)
pd.set_option('display.width', 1000)
pd.set_option('display.precision', 3)

# Performance options
pd.set_option('mode.copy_on_write', True)  # Enable copy-on-write
pd.set_option('compute.use_numba', True)   # Use numba for performance

# Memory optimization
pd.set_option('mode.string_storage', 'pyarrow')  # Use PyArrow for strings
```

## Essential Commands
```python
# Data loading
pd.read_csv(file)                      # Read CSV file
pd.read_excel(file, sheet_name)        # Read Excel file
pd.read_json(file)                     # Read JSON file
pd.read_parquet(file)                  # Read Parquet file

# Data inspection
df.head(n=5)                           # First n rows
df.tail(n=5)                           # Last n rows
df.info()                              # DataFrame info
df.describe()                          # Statistical summary
df.shape                               # Dimensions

# Data selection
df['column']                           # Select column
df[['col1', 'col2']]                  # Select multiple columns
df.loc[rows, columns]                  # Label-based selection
df.iloc[rows, columns]                 # Position-based selection

# Data manipulation
df.drop(columns=['col'])               # Drop columns
df.drop_duplicates()                   # Remove duplicates
df.fillna(value)                       # Fill missing values
df.groupby('column').agg({'col': 'mean'})  # Group and aggregate
```

## Common Issues & Solutions

### Issue 1: Memory Usage with Large Datasets
**Problem**: DataFrame consuming too much memory
**Solution**: Optimize data types and use chunking
```python
def optimize_memory_usage(df):
    """Optimize DataFrame memory usage"""
    for col in df.columns:
        col_type = df[col].dtype
        
        if col_type != 'object':
            c_min = df[col].min()
            c_max = df[col].max()
            
            if str(col_type)[:3] == 'int':
                if c_min > np.iinfo(np.int8).min and c_max < np.iinfo(np.int8).max:
                    df[col] = df[col].astype(np.int8)
                elif c_min > np.iinfo(np.int16).min and c_max < np.iinfo(np.int16).max:
                    df[col] = df[col].astype(np.int16)
                elif c_min > np.iinfo(np.int32).min and c_max < np.iinfo(np.int32).max:
                    df[col] = df[col].astype(np.int32)
            
            elif str(col_type)[:5] == 'float':
                if c_min > np.finfo(np.float32).min and c_max < np.finfo(np.float32).max:
                    df[col] = df[col].astype(np.float32)
        
        # Convert object columns to category if beneficial
        elif col_type == 'object':
            if df[col].nunique() / len(df) < 0.5:  # Less than 50% unique values
                df[col] = df[col].astype('category')
    
    return df

# Chunk processing for large files
def process_large_csv(file_path, chunk_size=10000):
    """Process large CSV files in chunks"""
    results = []
    for chunk in pd.read_csv(file_path, chunksize=chunk_size):
        # Process each chunk
        processed_chunk = process_chunk(chunk)
        results.append(processed_chunk)
    
    return pd.concat(results, ignore_index=True)
```

### Issue 2: Performance with Complex Operations
**Problem**: Slow performance with large datasets
**Solution**: Use vectorized operations and query optimization
```python
# Use vectorized operations
# Bad
df['new_col'] = df.apply(lambda row: complex_function(row), axis=1)

# Good
df['new_col'] = np.where(
    df['condition_col'] > threshold,
    df['col1'] * df['col2'],
    df['col1'] + df['col2']
)

# Use query() for complex filtering
# Bad
filtered_df = df[(df['age'] > 25) & (df['salary'] > 50000) & (df['department'] == 'Engineering')]

# Good
filtered_df = df.query("age > 25 and salary > 50000 and department == 'Engineering'")
```

## Performance Optimization

### Vectorization and Broadcasting
```python
# Vectorized string operations
df['email_domain'] = df['email'].str.split('@').str[1]

# Vectorized datetime operations
df['year'] = df['date_column'].dt.year
df['month'] = df['date_column'].dt.month

# Broadcasting for calculations
df['normalized_score'] = (df['score'] - df['score'].mean()) / df['score'].std()
```

### Memory and Speed Optimization
- Use categorical data types for repetitive string data
- Prefer `loc` and `iloc` for data selection
- Use `query()` method for complex boolean indexing
- Consider using PyArrow backend for string operations

## Security Considerations
- Validate file paths before reading data
- Sanitize user inputs when using query() method
- Be cautious with eval() and query() with untrusted data
- Use secure connections for database operations

## Useful Resources
- **Official Documentation**: https://pandas.pydata.org/docs/
- **User Guide**: https://pandas.pydata.org/docs/user_guide/
- **Community Resources**: https://pandas.pydata.org/community/
- **Performance Tips**: https://pandas.pydata.org/docs/user_guide/enhancingperf.html
- **Cookbook**: https://pandas.pydata.org/docs/user_guide/cookbook.html

## Framework-Specific Guidelines

### Code Style
- Use descriptive column names and avoid spaces
- Prefer method chaining for readable data transformations
- Use meaningful variable names for DataFrames and Series
- Document data transformations and assumptions

### Architecture Patterns
- Separate data loading, cleaning, and analysis functions
- Create reusable data processing pipelines
- Use consistent naming conventions for similar operations
- Implement data validation at key pipeline stages

## Integration Points

### NumPy Integration
- **Purpose**: Underlying array operations and numerical computations
- **Setup**: Seamless conversion between pandas and NumPy
- **Usage**: 
```python
numpy_array = df.values
df_from_numpy = pd.DataFrame(numpy_array, columns=['col1', 'col2'])
```

### Matplotlib/Seaborn Integration
- **Purpose**: Direct plotting from pandas DataFrames
- **Setup**: Built-in plotting functionality
- **Usage**:
```python
df.plot(kind='scatter', x='col1', y='col2')
df['column'].hist(bins=30)
df.boxplot(column='value', by='category')
```

## Version Compatibility
- **Pandas Version**: 2.0+ recommended
- **Python**: 3.8+ required
- **NumPy**: 1.20+ required
- **OS Support**: Windows, macOS, Linux

## Troubleshooting

### Debug Mode
```python
# Display full DataFrame information
pd.set_option('display.max_rows', None)
pd.set_option('display.max_columns', None)

# Check for common issues
print(f"DataFrame shape: {df.shape}")
print(f"Memory usage: {df.memory_usage(deep=True).sum() / 1024**2:.2f} MB")
print(f"Null values: {df.isnull().sum().sum()}")
print(f"Duplicate rows: {df.duplicated().sum()}")

# Data type analysis
print(df.dtypes.value_counts())
```

### Performance Issues
- Use `df.info(memory_usage='deep')` to analyze memory usage
- Profile operations with `%timeit` in Jupyter notebooks
- Consider using Dask for out-of-core processing
- Use `pd.eval()` for complex numerical expressions

## AI Assistant Guidelines
When helping with Pandas implementation:

1. **Always suggest vectorized operations** over apply() when possible
2. **Recommend appropriate data types** for memory optimization
3. **Include data validation** in processing pipelines
4. **Suggest chunking strategies** for large datasets
5. **Provide error handling** for data loading and processing
6. **Emphasize data quality checks** throughout transformations
7. **Reference performance implications** of different approaches
8. **Include comprehensive examples** with real-world data scenarios

### Code Generation Rules
- Generate readable, method-chained operations when appropriate
- Include proper error handling for data operations
- Use descriptive variable names and column names
- Follow pandas naming conventions and best practices
- Include data validation and quality checks
- Provide memory-efficient solutions for large datasets
- Generate comprehensive documentation for data transformations