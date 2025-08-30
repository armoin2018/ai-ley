# Data Science Framework Instructions Template

## Overview
- **Domain**: Data Science and Machine Learning Framework
- **Purpose**: Guide AI agents in implementing data science solutions with modern frameworks and best practices
- **Applicable To**: Data analysis, machine learning, statistical modeling, and data visualization projects
- **Integration Level**: Core framework for data-driven applications and analytical workflows

## Core Principles

### Fundamental Concepts
1. **Reproducible Research**: Ensure all analyses and models can be consistently reproduced
2. **Data Quality First**: Prioritize data validation, cleaning, and preprocessing
3. **Scalable Solutions**: Design for data growth and computational efficiency
4. **Interpretable Models**: Balance model complexity with interpretability requirements

### Key Benefits
- Accelerated data analysis and model development workflows
- Improved model performance through standardized preprocessing and validation
- Enhanced collaboration through reproducible notebooks and version-controlled experiments
- Reduced time-to-deployment with optimized model serving patterns
- Better decision-making through comprehensive data visualization and interpretation

### Common Misconceptions
- **Myth**: More complex models always perform better
  **Reality**: Simple, well-tuned models often outperform complex ones with proper feature engineering
- **Myth**: Data science is only about machine learning algorithms
  **Reality**: Data engineering, cleaning, and domain expertise are equally important
- **Myth**: Correlation implies causation in predictive models
  **Reality**: Careful experimental design and domain knowledge are required for causal inference

## Implementation Framework

### Getting Started
#### Prerequisites
- Understanding of statistical concepts and machine learning fundamentals
- Familiarity with data manipulation and analysis techniques
- Knowledge of relevant programming languages (Python, R, SQL)
- Access to appropriate computing resources and data storage

#### Initial Setup
1. **Environment Configuration**: Set up reproducible development environment
2. **Data Infrastructure**: Establish data pipelines and storage solutions
3. **Experiment Tracking**: Implement model versioning and experiment logging
4. **Collaboration Tools**: Set up shared notebooks and code repositories

### Core Methodologies
#### Data Science Lifecycle
- **Purpose**: Systematic approach to data science projects from conception to deployment
- **When to Use**: All data science projects requiring structured methodology
- **Implementation Steps**:
  1. Problem definition and success metrics identification
  2. Data collection, exploration, and quality assessment
  3. Feature engineering and data preprocessing
  4. Model development, training, and validation
  5. Model evaluation and performance analysis
  6. Deployment and monitoring in production
- **Success Metrics**: Model performance, business impact, and deployment reliability

#### Experimental Design and Validation
- **Purpose**: Ensure robust and reliable model development and evaluation
- **When to Use**: Model development and hypothesis testing scenarios
- **Implementation Steps**:
  1. Define clear hypotheses and success criteria
  2. Implement proper train/validation/test splits
  3. Use cross-validation for robust performance estimates
  4. Apply statistical significance testing for model comparisons
- **Success Metrics**: Statistical significance, generalization performance, and business relevance

### Process Integration
#### Development Workflow Integration
```python
# Example data science workflow integration
import mlflow
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report

# MLflow experiment tracking
mlflow.set_experiment("customer_churn_prediction")

with mlflow.start_run():
    # Data loading and preprocessing
    data = pd.read_csv("customer_data.csv")
    X, y = preprocess_data(data)
    
    # Train/test split
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=0.2, random_state=42, stratify=y
    )
    
    # Model training
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    model.fit(X_train, y_train)
    
    # Model evaluation
    y_pred = model.predict(X_test)
    accuracy = accuracy_score(y_test, y_pred)
    
    # Log metrics and model
    mlflow.log_metric("accuracy", accuracy)
    mlflow.log_param("n_estimators", 100)
    mlflow.sklearn.log_model(model, "model")
    
    # Generate detailed classification report
    report = classification_report(y_test, y_pred)
    mlflow.log_text(report, "classification_report.txt")
```

#### Documentation Requirements
- Comprehensive notebooks with clear markdown explanations
- Data dictionary and schema documentation
- Model architecture and hyperparameter documentation
- Performance evaluation and validation procedures
- Deployment and monitoring guidelines

## Best Practices

### Data Management and Preprocessing
#### Data Quality Framework
```python
# Example data quality validation
import pandas as pd
import numpy as np
from typing import Dict, List, Tuple

class DataQualityValidator:
    def __init__(self, data: pd.DataFrame):
        self.data = data
        self.quality_report = {}
    
    def validate_completeness(self) -> Dict:
        """Check for missing values and data completeness"""
        missing_stats = {}
        for column in self.data.columns:
            missing_count = self.data[column].isnull().sum()
            missing_percent = (missing_count / len(self.data)) * 100
            missing_stats[column] = {
                'missing_count': missing_count,
                'missing_percent': round(missing_percent, 2)
            }
        
        self.quality_report['completeness'] = missing_stats
        return missing_stats
    
    def validate_consistency(self) -> Dict:
        """Check for data type consistency and format validation"""
        consistency_issues = {}
        
        for column in self.data.columns:
            if self.data[column].dtype == 'object':
                # Check for inconsistent string formats
                unique_patterns = self.data[column].str.extract(
                    r'([A-Za-z]+|\d+|[^\w\s])'
                ).dropna().nunique()
                consistency_issues[column] = {
                    'unique_patterns': unique_patterns,
                    'data_type': str(self.data[column].dtype)
                }
        
        self.quality_report['consistency'] = consistency_issues
        return consistency_issues
    
    def validate_ranges(self, expected_ranges: Dict) -> Dict:
        """Validate numerical columns against expected ranges"""
        range_violations = {}
        
        for column, (min_val, max_val) in expected_ranges.items():
            if column in self.data.columns:
                out_of_range = self.data[
                    (self.data[column] < min_val) | 
                    (self.data[column] > max_val)
                ]
                range_violations[column] = {
                    'violations_count': len(out_of_range),
                    'expected_range': (min_val, max_val),
                    'actual_range': (
                        self.data[column].min(), 
                        self.data[column].max()
                    )
                }
        
        self.quality_report['ranges'] = range_violations
        return range_violations
    
    def generate_quality_report(self) -> Dict:
        """Generate comprehensive data quality report"""
        self.validate_completeness()
        self.validate_consistency()
        
        # Overall quality score
        total_missing = sum(
            stats['missing_count'] 
            for stats in self.quality_report['completeness'].values()
        )
        total_cells = len(self.data) * len(self.data.columns)
        quality_score = (1 - total_missing / total_cells) * 100
        
        self.quality_report['overall_quality_score'] = round(quality_score, 2)
        return self.quality_report
```

#### Feature Engineering Best Practices
```python
# Example feature engineering pipeline
from sklearn.base import BaseEstimator, TransformerMixin
from sklearn.preprocessing import StandardScaler, LabelEncoder
from sklearn.pipeline import Pipeline

class FeatureEngineeringPipeline(BaseEstimator, TransformerMixin):
    def __init__(self, categorical_features=None, numerical_features=None):
        self.categorical_features = categorical_features or []
        self.numerical_features = numerical_features or []
        self.label_encoders = {}
        self.scaler = StandardScaler()
    
    def fit(self, X, y=None):
        # Fit label encoders for categorical features
        for feature in self.categorical_features:
            le = LabelEncoder()
            le.fit(X[feature].astype(str))
            self.label_encoders[feature] = le
        
        # Fit scaler for numerical features
        if self.numerical_features:
            self.scaler.fit(X[self.numerical_features])
        
        return self
    
    def transform(self, X):
        X_transformed = X.copy()
        
        # Encode categorical features
        for feature in self.categorical_features:
            if feature in self.label_encoders:
                X_transformed[feature] = self.label_encoders[feature].transform(
                    X_transformed[feature].astype(str)
                )
        
        # Scale numerical features
        if self.numerical_features:
            X_transformed[self.numerical_features] = self.scaler.transform(
                X_transformed[self.numerical_features]
            )
        
        # Create interaction features
        X_transformed = self._create_interaction_features(X_transformed)
        
        return X_transformed
    
    def _create_interaction_features(self, X):
        """Create meaningful interaction features"""
        # Example: create polynomial features for important numerical columns
        for i, feature1 in enumerate(self.numerical_features):
            for feature2 in self.numerical_features[i+1:]:
                interaction_name = f"{feature1}_{feature2}_interaction"
                X[interaction_name] = X[feature1] * X[feature2]
        
        return X
```

### Model Development and Validation
#### Model Selection and Hyperparameter Tuning
```python
# Example model selection and tuning pipeline
from sklearn.model_selection import GridSearchCV, RandomizedSearchCV
from sklearn.ensemble import RandomForestClassifier
from sklearn.linear_model import LogisticRegression
from sklearn.svm import SVC
from sklearn.metrics import make_scorer, f1_score

class ModelSelectionPipeline:
    def __init__(self, scoring_metric='f1_weighted'):
        self.scoring_metric = scoring_metric
        self.models = {
            'random_forest': RandomForestClassifier(random_state=42),
            'logistic_regression': LogisticRegression(random_state=42),
            'svm': SVC(random_state=42)
        }
        self.param_grids = {
            'random_forest': {
                'n_estimators': [50, 100, 200],
                'max_depth': [5, 10, None],
                'min_samples_split': [2, 5, 10]
            },
            'logistic_regression': {
                'C': [0.1, 1, 10],
                'penalty': ['l1', 'l2'],
                'solver': ['liblinear', 'saga']
            },
            'svm': {
                'C': [0.1, 1, 10],
                'kernel': ['linear', 'rbf'],
                'gamma': ['scale', 'auto']
            }
        }
        self.best_models = {}
        self.results = {}
    
    def train_and_evaluate_models(self, X_train, y_train, cv_folds=5):
        """Train and evaluate multiple models with hyperparameter tuning"""
        for model_name, model in self.models.items():
            print(f"Training {model_name}...")
            
            # Hyperparameter tuning with cross-validation
            grid_search = GridSearchCV(
                model,
                self.param_grids[model_name],
                scoring=self.scoring_metric,
                cv=cv_folds,
                n_jobs=-1,
                verbose=1
            )
            
            grid_search.fit(X_train, y_train)
            
            # Store best model and results
            self.best_models[model_name] = grid_search.best_estimator_
            self.results[model_name] = {
                'best_score': grid_search.best_score_,
                'best_params': grid_search.best_params_,
                'cv_results': grid_search.cv_results_
            }
        
        return self.results
    
    def get_best_model(self):
        """Return the best performing model across all trained models"""
        best_model_name = max(
            self.results.keys(),
            key=lambda x: self.results[x]['best_score']
        )
        return best_model_name, self.best_models[best_model_name]
```

## Common Patterns and Examples

### Pattern 1: End-to-End ML Pipeline
**Scenario**: Building a complete machine learning pipeline for customer churn prediction
**Implementation**:
```python
# Complete ML pipeline example
import pandas as pd
import numpy as np
from sklearn.pipeline import Pipeline
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import StandardScaler, OneHotEncoder
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import classification_report, confusion_matrix
import joblib

class ChurnPredictionPipeline:
    def __init__(self):
        self.pipeline = None
        self.feature_names = None
        self.target_name = 'churn'
    
    def create_preprocessing_pipeline(self, numerical_features, categorical_features):
        """Create preprocessing pipeline for different feature types"""
        # Numerical pipeline
        numerical_pipeline = Pipeline([
            ('scaler', StandardScaler())
        ])
        
        # Categorical pipeline
        categorical_pipeline = Pipeline([
            ('onehot', OneHotEncoder(drop='first', sparse=False))
        ])
        
        # Combine preprocessing steps
        preprocessor = ColumnTransformer([
            ('num', numerical_pipeline, numerical_features),
            ('cat', categorical_pipeline, categorical_features)
        ])
        
        return preprocessor
    
    def build_pipeline(self, X, y):
        """Build complete ML pipeline"""
        # Identify feature types
        numerical_features = X.select_dtypes(include=[np.number]).columns.tolist()
        categorical_features = X.select_dtypes(include=['object']).columns.tolist()
        
        # Create preprocessing pipeline
        preprocessor = self.create_preprocessing_pipeline(
            numerical_features, categorical_features
        )
        
        # Complete pipeline with model
        self.pipeline = Pipeline([
            ('preprocessor', preprocessor),
            ('classifier', RandomForestClassifier(
                n_estimators=100,
                max_depth=10,
                random_state=42
            ))
        ])
        
        return self.pipeline
    
    def train_and_evaluate(self, X, y, test_size=0.2):
        """Train model and evaluate performance"""
        # Split data
        X_train, X_test, y_train, y_test = train_test_split(
            X, y, test_size=test_size, random_state=42, stratify=y
        )
        
        # Build and train pipeline
        self.build_pipeline(X_train, y_train)
        self.pipeline.fit(X_train, y_train)
        
        # Cross-validation
        cv_scores = cross_val_score(
            self.pipeline, X_train, y_train, cv=5, scoring='f1'
        )
        
        # Test set evaluation
        y_pred = self.pipeline.predict(X_test)
        
        # Results
        results = {
            'cv_mean_score': cv_scores.mean(),
            'cv_std_score': cv_scores.std(),
            'test_classification_report': classification_report(y_test, y_pred),
            'test_confusion_matrix': confusion_matrix(y_test, y_pred)
        }
        
        return results
    
    def save_model(self, filepath):
        """Save trained pipeline to disk"""
        joblib.dump(self.pipeline, filepath)
    
    def load_model(self, filepath):
        """Load trained pipeline from disk"""
        self.pipeline = joblib.load(filepath)
        return self.pipeline
```

### Pattern 2: Experiment Tracking and Model Versioning
**Scenario**: Managing multiple experiments and model versions for A/B testing
**Implementation**:
```python
# Experiment tracking and model versioning
import mlflow
import mlflow.sklearn
from mlflow.tracking import MlflowClient
import pandas as pd
from datetime import datetime

class ExperimentManager:
    def __init__(self, experiment_name):
        self.experiment_name = experiment_name
        self.client = MlflowClient()
        self.experiment_id = self._get_or_create_experiment()
    
    def _get_or_create_experiment(self):
        """Get existing experiment or create new one"""
        try:
            experiment = mlflow.get_experiment_by_name(self.experiment_name)
            return experiment.experiment_id
        except:
            return mlflow.create_experiment(self.experiment_name)
    
    def run_experiment(self, model, X_train, y_train, X_test, y_test, 
                      model_params=None, tags=None):
        """Run a complete experiment with tracking"""
        with mlflow.start_run(experiment_id=self.experiment_id) as run:
            # Log parameters
            if model_params:
                mlflow.log_params(model_params)
            
            # Log tags
            if tags:
                mlflow.set_tags(tags)
            
            # Train model
            model.fit(X_train, y_train)
            
            # Predictions and metrics
            train_pred = model.predict(X_train)
            test_pred = model.predict(X_test)
            
            train_accuracy = accuracy_score(y_train, train_pred)
            test_accuracy = accuracy_score(y_test, test_pred)
            
            # Log metrics
            mlflow.log_metric("train_accuracy", train_accuracy)
            mlflow.log_metric("test_accuracy", test_accuracy)
            mlflow.log_metric("overfitting_ratio", train_accuracy - test_accuracy)
            
            # Log model
            mlflow.sklearn.log_model(
                model, 
                "model",
                registered_model_name=f"{self.experiment_name}_model"
            )
            
            # Log artifacts
            self._log_model_artifacts(model, X_test, y_test, test_pred)
            
            return run.info.run_id
    
    def _log_model_artifacts(self, model, X_test, y_test, y_pred):
        """Log model artifacts and visualizations"""
        # Feature importance (if available)
        if hasattr(model, 'feature_importances_'):
            importance_df = pd.DataFrame({
                'feature': X_test.columns,
                'importance': model.feature_importances_
            }).sort_values('importance', ascending=False)
            
            importance_df.to_csv("feature_importance.csv", index=False)
            mlflow.log_artifact("feature_importance.csv")
        
        # Classification report
        report = classification_report(y_test, y_pred)
        with open("classification_report.txt", "w") as f:
            f.write(report)
        mlflow.log_artifact("classification_report.txt")
    
    def compare_experiments(self, metric="test_accuracy"):
        """Compare all experiments by specified metric"""
        runs = mlflow.search_runs(
            experiment_ids=[self.experiment_id],
            order_by=[f"metrics.{metric} DESC"]
        )
        
        return runs[['run_id', f'metrics.{metric}', 'status', 'start_time']]
    
    def promote_model_to_production(self, run_id, stage="Production"):
        """Promote a model version to production"""
        model_name = f"{self.experiment_name}_model"
        
        # Get model version from run
        model_version = self.client.get_latest_versions(
            model_name, stages=["None"]
        )[0].version
        
        # Transition to production
        self.client.transition_model_version_stage(
            name=model_name,
            version=model_version,
            stage=stage
        )
        
        return model_version
```

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Data Leakage
- **Description**: Using future information or target-related features for prediction
- **Why It's Problematic**: Leads to overly optimistic performance estimates that don't generalize
- **Better Approach**: Strict temporal splits and careful feature engineering to avoid target leakage

#### Anti-Pattern 2: Ignoring Data Distribution Shifts
- **Description**: Assuming training and production data have the same distribution
- **Why It's Problematic**: Models may fail when deployed if data patterns change
- **Better Approach**: Implement data drift monitoring and model retraining pipelines

## Tools and Resources

### Essential Tools
#### Data Manipulation and Analysis
- **pandas**: Comprehensive data manipulation and analysis library
- **NumPy**: Fundamental package for numerical computing
- **Dask**: Parallel computing for larger-than-memory datasets
- **Polars**: Fast DataFrame library with lazy evaluation

#### Machine Learning Frameworks
- **scikit-learn**: General-purpose machine learning library
- **XGBoost**: Gradient boosting framework for structured data
- **TensorFlow/Keras**: Deep learning framework for neural networks
- **PyTorch**: Dynamic neural network framework

#### Experiment Tracking and MLOps
- **MLflow**: Open-source platform for ML lifecycle management
- **Weights & Biases**: Experiment tracking and visualization
- **DVC**: Data Version Control for ML projects
- **Kubeflow**: ML workflows on Kubernetes

### Templates and Checklists
#### Data Science Project Checklist
- [ ] **Problem Definition**: Clear business problem and success metrics defined
- [ ] **Data Assessment**: Data quality, availability, and limitations evaluated
- [ ] **Exploratory Analysis**: Comprehensive EDA completed with insights documented
- [ ] **Feature Engineering**: Relevant features created and validated
- [ ] **Model Development**: Multiple algorithms tested with proper validation
- [ ] **Performance Evaluation**: Models evaluated on holdout test set
- [ ] **Deployment Planning**: Production deployment strategy defined
- [ ] **Monitoring Setup**: Model performance monitoring implemented

### Learning Resources
- **Hands-On Machine Learning** by Aurélien Géron: Practical ML implementation guide
- **The Elements of Statistical Learning**: Comprehensive statistical learning theory
- **Python for Data Analysis** by Wes McKinney: pandas and data manipulation guide
- **MLOps Engineering at Scale**: Production ML system design and implementation

## Quality and Compliance

### Quality Standards
- All experiments tracked with reproducible code and environment specifications
- Model performance validated on independent test sets with statistical significance testing
- Data quality checks implemented and documented for all data sources
- Code quality maintained with linting, testing, and peer review processes

### Compliance Requirements
#### Model Governance
- **Requirements**: Model versioning, performance tracking, and approval workflows
- **Implementation**: MLflow model registry with stage transitions and approval processes
- **Verification**: Audit trail of model development and deployment decisions

#### Data Privacy and Security
- **Requirements**: Compliance with data protection regulations (GDPR, CCPA)
- **Implementation**: Data anonymization, access controls, and secure data handling
- **Verification**: Regular privacy audits and security assessments

### Audit and Review Processes
- Weekly model performance monitoring and drift detection
- Monthly data quality assessment and pipeline validation
- Quarterly model retraining and performance benchmark updates
- Annual methodology review and technology stack evaluation

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Model Performance Degradation
**Symptoms**: Decreasing accuracy or prediction quality over time
**Root Causes**: Data drift, feature evolution, or changing business conditions
**Solutions**:
1. Implement data drift monitoring and alerting
2. Set up automated model retraining pipelines
3. Regularly validate feature relevance and quality
4. Establish performance benchmarks and thresholds
**Prevention**: Continuous monitoring and proactive model maintenance

#### Issue 2: Reproducibility Problems
**Symptoms**: Different results when running the same code or experiments
**Root Causes**: Random seed variations, environment differences, or data changes
**Solutions**:
1. Set fixed random seeds for all random operations
2. Use containerized environments for consistent execution
3. Version control data and track data lineage
4. Document all dependencies and environment specifications
**Prevention**: Comprehensive experiment tracking and environment management

### Escalation Procedures
- Data quality issues: Escalate to data engineering team
- Model performance problems: Escalate to senior data scientists and domain experts
- Infrastructure issues: Escalate to MLOps and platform engineering teams
- Business impact concerns: Escalate to product management and stakeholder teams

### Continuous Improvement
- Regular review of model performance and business impact
- Technology evaluation and adoption for improved efficiency
- Knowledge sharing through team presentations and documentation
- Process optimization based on lessons learned and industry best practices

## AI Assistant Guidelines

When helping with Data Science Framework implementation:

1. **Reproducibility Focus**: Always emphasize reproducible research practices and experiment tracking
2. **Data Quality First**: Prioritize data validation and quality checks before model development
3. **Statistical Rigor**: Apply proper statistical methods for validation and significance testing
4. **Business Context**: Consider business requirements and constraints in all technical decisions
5. **Scalability Planning**: Design solutions that can handle data growth and production requirements
6. **Interpretability Balance**: Balance model complexity with interpretability needs
7. **Ethical Considerations**: Consider bias, fairness, and ethical implications of models
8. **Continuous Learning**: Stay updated with latest techniques while focusing on proven methods

### Decision Making Framework
When helping teams with data science implementation:

1. **Problem Understanding**: Clearly define the business problem and success metrics
2. **Data Assessment**: Evaluate data availability, quality, and suitability for the problem
3. **Methodology Selection**: Choose appropriate algorithms and validation strategies
4. **Resource Planning**: Consider computational resources and timeline constraints
5. **Risk Assessment**: Identify potential risks including bias, overfitting, and deployment challenges
6. **Success Measurement**: Define clear metrics for model performance and business impact

### Code Generation Rules
- Generate reproducible code with proper random seed setting and environment specification
- Include comprehensive data validation and quality checking procedures
- Implement proper train/validation/test splits with stratification when appropriate
- Create modular, reusable code with clear separation of concerns
- Include experiment tracking and model versioning capabilities
- Generate comprehensive documentation and visualization code

### Quality Enforcement
- ✅ Enforce reproducible research practices with proper experiment tracking
- ✅ Require comprehensive data quality validation before model development
- ✅ Block data leakage through proper feature engineering and validation splits
- ✅ Promote statistical significance testing for model comparisons
- ✅ Require proper cross-validation and holdout test set evaluation
- ✅ Enforce code quality standards with testing and documentation
- ✅ Promote ethical AI practices with bias detection and fairness evaluation
- ✅ Require production readiness considerations in all model development