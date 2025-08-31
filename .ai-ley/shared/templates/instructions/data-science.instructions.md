# Data Science Framework Instructions

## Overview

- **Domain**: Data Science and Machine Learning Development
- **Purpose**: Guide AI agents in implementing data science solutions with modern ML frameworks
- **Applicable To**: Data analysis, machine learning, statistical modeling, and data visualization projects
- **Complexity Level**: Intermediate to Advanced

## Core Concepts

### Essential Concepts

- **ML Lifecycle**: Data collection → EDA → Feature engineering → Model training → Validation → Deployment
- **Reproducible Research**: Version control for data, code, and models with experiment tracking
- **Data Quality Framework**: Validation, cleaning, and preprocessing with automated quality checks

### Key Benefits

- Accelerated model development through standardized workflows and automated experimentation
- Improved model reliability with systematic validation and reproducible research practices
- Enhanced deployment success with production-ready model serving and monitoring patterns

## Implementation Guidelines

### Getting Started

```python
# Essential ML project setup
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
import mlflow
import joblib

# Initialize experiment tracking
mlflow.set_experiment("project_name")
```

### Core Patterns

```python
# Pattern 1: Data Validation Pipeline
class DataValidator:
    def validate_schema(self, df: pd.DataFrame) -> bool:
        # Schema validation logic
        return schema_valid

    def check_quality(self, df: pd.DataFrame) -> dict:
        # Quality metrics calculation
        return quality_metrics

# Pattern 2: Model Training Pipeline
class ModelPipeline:
    def __init__(self, preprocessor, model):
        self.pipeline = Pipeline([
            ('preprocessor', preprocessor),
            ('model', model)
        ])

    def train_with_validation(self, X, y):
        # Cross-validation and training
        return trained_pipeline

# Pattern 3: Experiment Tracking
with mlflow.start_run():
    # Log parameters, metrics, and artifacts
    mlflow.log_params(model_params)
    mlflow.log_metrics(performance_metrics)
    mlflow.sklearn.log_model(model, "model")
```

### Best Practices

- **Feature Engineering**: Systematic feature creation with validation and importance analysis
- **Model Validation**: Robust train/validation/test splits with cross-validation and statistical testing
- **Experiment Management**: Comprehensive tracking of data versions, parameters, and results

## Common Use Cases

### Use Case 1: Predictive Modeling Pipeline

**When**: Building classification or regression models for business predictions
**Implementation**:

```python
# Complete ML pipeline with validation
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer

# Preprocessing for different feature types
preprocessor = ColumnTransformer([
    ('num', StandardScaler(), numerical_features),
    ('cat', OneHotEncoder(), categorical_features)
])

# Full pipeline with model
ml_pipeline = Pipeline([
    ('preprocessor', preprocessor),
    ('classifier', RandomForestClassifier())
])

# Training with cross-validation
cv_scores = cross_val_score(ml_pipeline, X_train, y_train, cv=5)
```

### Use Case 2: Feature Engineering Automation

**When**: Creating and validating features for model improvement
**Implementation**:

```python
# Automated feature engineering
class FeatureEngineer:
    def create_time_features(self, df, date_col):
        df['hour'] = df[date_col].dt.hour
        df['day_of_week'] = df[date_col].dt.dayofweek
        return df

    def create_interaction_features(self, df, feature_pairs):
        for feat1, feat2 in feature_pairs:
            df[f'{feat1}_{feat2}_interaction'] = df[feat1] * df[feat2]
        return df
```

### Use Case 3: Model Performance Monitoring

**When**: Tracking model performance in production with drift detection
**Implementation**:

```python
# Model monitoring and drift detection
class ModelMonitor:
    def detect_data_drift(self, reference_data, current_data):
        # Statistical tests for drift detection
        drift_results = {}
        for column in reference_data.columns:
            p_value = ks_2samp(reference_data[column], current_data[column]).pvalue
            drift_results[column] = p_value < 0.05
        return drift_results
```

## Anti-Patterns to Avoid

- **Data Leakage**: Using future information or target-related features in training data
- **Overfitting**: Creating overly complex models without proper validation and regularization
- **Ignoring Data Quality**: Building models on poor quality data without validation and cleaning
- **Manual Experimentation**: Not tracking experiments and model versions systematically

## Integration & Tools

### Essential Tools

- **Data Processing**: pandas, NumPy, Polars, Dask for large-scale data manipulation
- **ML Frameworks**: scikit-learn, XGBoost, TensorFlow/Keras, PyTorch for model development
- **Experiment Tracking**: MLflow, Weights & Biases, DVC for experiment management
- **Deployment**: Docker, Kubernetes, cloud ML services for model serving

### ML Pipeline Integration

```python
# Production ML pipeline structure
class ProductionMLPipeline:
    def __init__(self):
        self.data_validator = DataValidator()
        self.feature_engineer = FeatureEngineer()
        self.model_trainer = ModelTrainer()
        self.model_evaluator = ModelEvaluator()

    def run_pipeline(self, raw_data):
        # Validate data quality
        if not self.data_validator.validate(raw_data):
            raise ValueError("Data quality validation failed")

        # Engineer features
        features = self.feature_engineer.transform(raw_data)

        # Train and evaluate model
        model = self.model_trainer.train(features)
        metrics = self.model_evaluator.evaluate(model, features)

        return model, metrics
```

## AI Assistant Guidelines

When helping with Data Science development:

1. **Reproducibility First**: Always emphasize experiment tracking and version control
2. **Data Quality Focus**: Prioritize data validation and quality checks before modeling
3. **Statistical Rigor**: Apply proper validation methods and significance testing
4. **Production Readiness**: Consider deployment and monitoring requirements early
5. **Feature Engineering**: Systematic approach to feature creation and validation
6. **Model Interpretability**: Balance complexity with explainability requirements
7. **Scalability Planning**: Design for data growth and computational efficiency
8. **Ethical Considerations**: Address bias, fairness, and model transparency

### Code Generation Rules

- Generate reproducible code with proper random seed management
- Include comprehensive data validation and quality checking
- Implement proper train/validation/test splits with stratification
- Create modular, reusable ML pipeline components
- Include experiment tracking and model versioning
- Generate comprehensive evaluation and visualization code

### Quality Enforcement

- ✅ Enforce reproducible research practices with experiment tracking
- ✅ Require comprehensive data quality validation before modeling
- ✅ Block data leakage through proper feature engineering validation
- ✅ Promote statistical significance testing for model comparisons
- ✅ Require proper cross-validation and holdout evaluation
- 🚫 Block overfitting through excessive model complexity
- 🚫 Avoid manual experimentation without systematic tracking
- 🚫 Reject models without proper bias and fairness evaluation

## Resources

- **ML Engineering**: "Designing Machine Learning Systems" by Chip Huyen
- **Statistical Learning**: "The Elements of Statistical Learning" by Hastie, Tibshirani, Friedman
- **MLOps Practices**: "Machine Learning Engineering" by Andriy Burkov
