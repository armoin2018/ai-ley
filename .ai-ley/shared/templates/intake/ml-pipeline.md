---
templateType: intake
category: ml-pipeline
version: 1.0.0
author: AI-LEY
created: 2025-11-09T00:00:00.000000
description: Interactive intake template for machine learning pipeline and AI projects
---

# Machine Learning Pipeline Project Intake

## Project Overview

### Q1: Project Name

**Question**: What is the name of your ML/AI project or pipeline?
**Type**: text
**Required**: yes

### Q2: Project Description

**Question**: Provide a brief description of the ML project (1-2 paragraphs). What problem does it solve and what type of predictions/insights will it provide?
**Type**: textarea
**Required**: yes

### Q3: ML Problem Type

**Question**: What type of machine learning problem are you solving?
**Type**: single-select
**Required**: yes
**Suggestions**:

- Supervised Learning - Classification (binary)
- Supervised Learning - Classification (multi-class)
- Supervised Learning - Regression
- Unsupervised Learning - Clustering
- Unsupervised Learning - Dimensionality Reduction
- Unsupervised Learning - Anomaly Detection
- Semi-supervised Learning
- Reinforcement Learning
- Natural Language Processing (NLP)
- Computer Vision
- Time Series Forecasting
- Recommendation System
- Generative AI (LLM, Diffusion, etc.)
- Multi-modal Learning
- Transfer Learning
- Other (specify)

### Q4: Business Goals

**Question**: What are the primary business goals and success metrics for this ML project?
**Type**: list
**Required**: yes
**Examples**:

- Improve prediction accuracy by X%
- Reduce manual processing time by X%
- Increase revenue through better recommendations
- Reduce fraud/anomalies detection time
- Automate decision-making process
- Enhance customer experience
- Reduce operational costs
- Enable new product capabilities
- Gain competitive advantage

## Data & Features

### Q5: Data Sources

**Question**: What are the primary data sources for training and inference?
**Type**: list
**Required**: yes
**Suggestions**:

- Relational databases (PostgreSQL, MySQL, etc.)
- NoSQL databases (MongoDB, Cassandra, etc.)
- Data warehouse (Snowflake, Redshift, BigQuery)
- Data lake (S3, Azure Data Lake, GCS)
- Streaming data (Kafka, Kinesis, Pub/Sub)
- APIs (internal or external)
- File storage (CSV, JSON, Parquet, etc.)
- Third-party data providers
- Web scraping
- IoT sensors/devices
- Existing datasets (public or proprietary)
- Manually labeled data

### Q6: Data Volume & Characteristics

**Question**: What is the scale and nature of your data?
**Type**: textarea
**Required**: yes
**Format**:

```
Training Data Volume:
- Number of samples: [e.g., 1M rows]
- Data size: [e.g., 100GB]
- Feature count: [e.g., 50 features]
- Update frequency: [daily, weekly, real-time]

Inference Data Volume:
- Requests per day/second: [estimate]
- Batch vs real-time: [specify]

Data Characteristics:
- Structured, semi-structured, or unstructured
- Tabular, text, images, audio, video, time-series
- Data quality issues: [missing values, outliers, imbalance]
- Label availability: [fully labeled, partially labeled, unlabeled]
```

### Q7: Feature Engineering

**Question**: What feature engineering and preprocessing is required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Data cleaning (missing values, outliers)
- Feature scaling/normalization
- Feature encoding (one-hot, label, target encoding)
- Feature creation/derivation
- Dimensionality reduction (PCA, t-SNE, UMAP)
- Text preprocessing (tokenization, stemming, lemmatization)
- Image preprocessing (resizing, augmentation, normalization)
- Time series feature extraction (lag features, rolling statistics)
- Embedding generation (word2vec, BERT, etc.)
- Feature selection techniques
- Handling imbalanced data (SMOTE, undersampling, etc.)
- Domain-specific transformations

### Q8: Data Labeling & Annotation

**Question**: How will data be labeled and annotated?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Already fully labeled
- Manual labeling by internal team
- Third-party labeling service (Scale AI, Labelbox, etc.)
- Active learning approach
- Weak supervision/distant supervision
- Semi-automated labeling
- Crowdsourcing (Amazon MTurk, etc.)
- Transfer learning from pre-trained models
- Self-supervised learning
- Not applicable (unsupervised learning)

## Model Development

### Q9: ML Frameworks & Libraries

**Question**: What ML frameworks and libraries will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/tech-stack.md`
**Allow Custom**: yes

**Common ML Stack Options**:

ML Frameworks:

- TensorFlow
- PyTorch
- Scikit-learn
- XGBoost
- LightGBM
- CatBoost
- Keras
- JAX
- MXNet
- Hugging Face Transformers

Deep Learning:

- TensorFlow/Keras
- PyTorch
- PyTorch Lightning
- FastAI
- Detectron2 (Computer Vision)
- Stable Baselines3 (RL)

NLP:

- Hugging Face Transformers
- spaCy
- NLTK
- Gensim
- OpenAI API
- LangChain
- LlamaIndex

Computer Vision:

- OpenCV
- torchvision
- Pillow
- albumentations
- YOLO
- Detectron2

MLOps & Experiment Tracking:

- MLflow
- Weights & Biases (wandb)
- Neptune.ai
- Comet.ml
- TensorBoard
- DVC (Data Version Control)

### Q10: Model Architecture

**Question**: What model architectures or algorithms will be explored?
**Type**: list
**Required**: yes
**Examples by Problem Type**:

**Classical ML**:

- Linear/Logistic Regression
- Decision Trees
- Random Forest
- Gradient Boosting (XGBoost, LightGBM, CatBoost)
- Support Vector Machines (SVM)
- k-Nearest Neighbors (k-NN)
- Naive Bayes
- Neural Networks (MLP)

**Deep Learning**:

- Convolutional Neural Networks (CNN)
- Recurrent Neural Networks (RNN, LSTM, GRU)
- Transformers (BERT, GPT, T5)
- Vision Transformers (ViT)
- Autoencoders
- Generative Adversarial Networks (GAN)
- Diffusion Models
- Graph Neural Networks (GNN)

**Ensemble Methods**:

- Stacking
- Bagging
- Boosting
- Voting classifiers

### Q11: Model Training Strategy

**Question**: What training strategy and techniques will be employed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Train from scratch
- Transfer learning (fine-tuning pre-trained models)
- Few-shot learning
- Zero-shot learning
- Multi-task learning
- Curriculum learning
- Adversarial training
- Self-supervised pre-training
- Continual/incremental learning
- Federated learning
- Hyperparameter optimization (Grid Search, Random Search, Bayesian)
- AutoML (AutoKeras, Auto-sklearn, H2O AutoML)
- Neural Architecture Search (NAS)

### Q12: Model Evaluation Metrics

**Question**: What metrics will be used to evaluate model performance?
**Type**: multi-select
**Required**: yes
**Suggestions**:

**Classification**:

- Accuracy
- Precision
- Recall
- F1 Score
- AUC-ROC
- AUC-PR
- Confusion Matrix
- Log Loss
- Matthews Correlation Coefficient

**Regression**:

- Mean Absolute Error (MAE)
- Mean Squared Error (MSE)
- Root Mean Squared Error (RMSE)
- R-squared (R²)
- Mean Absolute Percentage Error (MAPE)

**Ranking/Recommendation**:

- Precision@K
- Recall@K
- MAP (Mean Average Precision)
- NDCG (Normalized Discounted Cumulative Gain)
- MRR (Mean Reciprocal Rank)

**NLP**:

- BLEU
- ROUGE
- Perplexity
- Exact Match
- F1 Score (token-level)

**Business Metrics**:

- Cost reduction
- Revenue impact
- Time savings
- User satisfaction

## ML Pipeline & Infrastructure

### Q13: Pipeline Components

**Question**: What components will be part of the ML pipeline?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Data ingestion
- Data validation
- Data preprocessing/transformation
- Feature engineering
- Feature store
- Model training
- Hyperparameter tuning
- Model evaluation
- Model validation
- Model versioning
- Model registry
- Model deployment
- Batch inference
- Real-time inference
- Model monitoring
- Model retraining
- A/B testing
- Shadow deployment
- Data drift detection
- Model drift detection

### Q14: MLOps Platform & Tools

**Question**: What MLOps tools and platforms will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**:

**End-to-End MLOps**:

- AWS SageMaker
- Azure Machine Learning
- Google Vertex AI
- Databricks ML
- Kubeflow
- MLflow
- Metaflow
- Weights & Biases

**Feature Store**:

- Feast
- Tecton
- AWS SageMaker Feature Store
- Google Vertex AI Feature Store
- Databricks Feature Store
- Hopsworks

**Model Registry**:

- MLflow Model Registry
- AWS SageMaker Model Registry
- Azure ML Model Registry
- Weights & Biases Model Registry

**Workflow Orchestration**:

- Apache Airflow
- Kubeflow Pipelines
- AWS Step Functions
- Prefect
- Dagster
- Argo Workflows

**Experiment Tracking**:

- MLflow
- Weights & Biases
- Neptune.ai
- Comet.ml
- TensorBoard

### Q15: Compute Infrastructure

**Question**: What compute infrastructure will be used for training and inference?
**Type**: multi-select
**Required**: yes
**Suggestions**:

**Training Infrastructure**:

- Local development machines
- On-premise GPU servers
- AWS EC2 (GPU instances)
- AWS SageMaker
- Google Cloud AI Platform/Vertex AI
- Azure Machine Learning Compute
- Google Colab / Kaggle Kernels
- Lambda Labs
- Paperspace
- Distributed training (multi-GPU, multi-node)

**Inference Infrastructure**:

- CPU servers (cost-effective for small models)
- GPU servers (for large models, real-time inference)
- Serverless (AWS Lambda, Google Cloud Functions)
- Container orchestration (Kubernetes, ECS, Cloud Run)
- Edge devices (mobile, IoT, edge computing)
- Model optimization (quantization, pruning, distillation)

**Acceleration**:

- NVIDIA GPUs (A100, V100, T4)
- Google TPUs
- AWS Inferentia/Trainium
- Custom ASICs

### Q16: Data & Model Storage

**Question**: Where will data and models be stored?
**Type**: multi-select
**Required**: yes
**Suggestions**:

**Data Storage**:

- Amazon S3
- Google Cloud Storage
- Azure Blob Storage
- HDFS
- Local file system
- Databases (PostgreSQL, MongoDB, etc.)

**Model Storage**:

- S3/GCS/Azure Blob
- Model registry (MLflow, SageMaker)
- Container registry (Docker Hub, ECR, GCR)
- Version control (Git LFS, DVC)

**Metadata Storage**:

- PostgreSQL
- MySQL
- DynamoDB
- MongoDB
- Experiment tracking platforms

## Model Deployment & Serving

### Q17: Deployment Strategy

**Question**: How will models be deployed and served?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Batch inference (scheduled jobs)
- Real-time inference (REST API)
- Real-time inference (gRPC)
- Streaming inference (Kafka, Kinesis)
- Edge deployment (mobile devices, IoT)
- Model as a service (AWS SageMaker, Vertex AI)
- Containerized deployment (Docker + Kubernetes)
- Serverless deployment (AWS Lambda, Cloud Functions)
- On-premise deployment
- Hybrid cloud deployment

### Q18: Inference Requirements

**Question**: What are the inference performance requirements?
**Type**: textarea
**Required**: yes
**Format**:

```
Latency Requirements:
- p50: [e.g., 50ms]
- p95: [e.g., 200ms]
- p99: [e.g., 500ms]

Throughput:
- Requests per second: [e.g., 1000 RPS]
- Batch size (if applicable): [e.g., 100]

Availability:
- Uptime SLA: [e.g., 99.9%]

Cost Constraints:
- Inference cost per prediction: [target]
- Monthly compute budget: [estimate]
```

### Q19: Model Serving Framework

**Question**: What model serving framework will be used?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- TensorFlow Serving
- TorchServe
- NVIDIA Triton Inference Server
- AWS SageMaker Endpoints
- Google Vertex AI Predictions
- Azure ML Endpoints
- FastAPI (custom API)
- Flask/Django (custom API)
- BentoML
- Seldon Core
- KServe (KFServing)
- Ray Serve
- ONNX Runtime

### Q20: Model Optimization

**Question**: What model optimization techniques will be applied?
**Type**: multi-select
**Required**: no
**Suggestions**:

- Quantization (INT8, FP16)
- Pruning (weight pruning, structured pruning)
- Knowledge distillation
- Model compression
- ONNX conversion
- TensorRT optimization
- OpenVINO optimization
- Dynamic batching
- Model caching
- Hardware-specific optimization (GPU, TPU, CPU)

## Monitoring & Maintenance

### Q21: Model Monitoring

**Question**: What monitoring and observability capabilities are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Prediction latency monitoring
- Throughput monitoring
- Error rate tracking
- Model performance metrics (accuracy, etc.)
- Data drift detection
- Concept drift detection
- Feature distribution monitoring
- Prediction distribution monitoring
- Outlier/anomaly detection in inputs
- Model explainability tracking
- Resource utilization (CPU, GPU, memory)
- Cost monitoring
- A/B test metrics
- Business KPI tracking
- Alerting on degradation

### Q22: Monitoring Tools

**Question**: What tools will be used for monitoring and alerting?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Prometheus + Grafana
- AWS CloudWatch
- Google Cloud Monitoring
- Azure Monitor
- Datadog
- New Relic
- Evidently AI (ML monitoring)
- Arize AI (ML observability)
- WhyLabs (data quality monitoring)
- Fiddler AI (ML monitoring)
- Custom dashboards

### Q23: Model Retraining Strategy

**Question**: What is the model retraining and update strategy?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Scheduled retraining (daily, weekly, monthly)
- Trigger-based retraining (performance degradation)
- Continuous learning/online learning
- Incremental retraining
- Full retraining from scratch
- A/B testing before promotion
- Shadow deployment validation
- Automated retraining pipeline
- Manual retraining with approval
- Champion/challenger model strategy

## Data Privacy & Security

### Q24: Data Privacy Requirements

**Question**: What data privacy and protection measures are required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Data anonymization/pseudonymization
- Personally Identifiable Information (PII) removal
- Differential privacy
- Federated learning (data stays on-device)
- Encryption at rest
- Encryption in transit
- Access control and authentication
- Data retention policies
- Right to deletion (GDPR)
- Data lineage tracking
- Audit logging
- Secure multi-party computation
- Homomorphic encryption

### Q25: Model Security & Compliance

**Question**: What security and compliance requirements must be met?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Model versioning and reproducibility
- Model access control
- Model encryption
- Adversarial robustness testing
- Model fairness evaluation
- Bias detection and mitigation
- Model interpretability/explainability
- GDPR compliance
- HIPAA compliance (healthcare)
- SOC 2 compliance
- Industry-specific regulations
- Ethical AI guidelines
- Model governance framework
- Audit trail for predictions

## Explainability & Fairness

### Q26: Model Explainability

**Question**: What level of model explainability is required?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Feature importance (global)
- SHAP values (local explanations)
- LIME (Local Interpretable Model-agnostic Explanations)
- Partial Dependence Plots (PDP)
- Individual Conditional Expectation (ICE)
- Counterfactual explanations
- Attention visualization (for deep learning)
- Model-agnostic explanations
- Rule extraction
- Prototype/example-based explanations
- Not required (black-box acceptable)

### Q27: Fairness & Bias Mitigation

**Question**: What fairness constraints and bias mitigation strategies are needed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Fairness metrics evaluation (demographic parity, equalized odds, etc.)
- Bias detection in training data
- Bias detection in model predictions
- Fairness-aware training algorithms
- Post-processing for fairness
- Sensitive attribute handling
- Disparate impact analysis
- Subgroup performance analysis
- Fairness constraints during optimization
- Regular fairness audits
- Not applicable

## Team & Resources

### Q28: Team Composition

**Question**: What roles and expertise are available on the team?
**Type**: multi-select
**Required**: yes
**Suggestions**: Load from `.ai-ley/shared/indexes/personas.md`
**Allow Custom**: yes
**Create If Missing**: yes (persona)
**Common Roles**:

- Data Scientist
- Machine Learning Engineer
- ML Ops Engineer
- Data Engineer
- Research Scientist
- AI Architect
- Software Engineer
- DevOps Engineer
- Data Analyst
- Domain Expert (SME)
- Product Manager

### Q29: Required Instructions

**Question**: What technical guidance and best practices will the team need?
**Type**: multi-select
**Required**: no
**Suggestions**: Load from `.ai-ley/shared/indexes/instructions.md`
**Allow Custom**: yes
**Create If Missing**: yes (instruction)
**Common Instructions**:

- ML model development best practices
- MLOps pipeline setup
- Data preprocessing guidelines
- Model evaluation standards
- Deployment procedures
- Monitoring and alerting setup
- Experiment tracking workflows
- Model governance policies
- Responsible AI guidelines

## Testing & Validation

### Q30: Testing Strategy

**Question**: What testing and validation strategies will be employed?
**Type**: multi-select
**Required**: yes
**Suggestions**:

- Train/validation/test split
- Cross-validation (k-fold, stratified)
- Time-based split (for time series)
- Holdout test set
- Unit tests for code
- Integration tests for pipeline
- Data quality tests
- Model performance tests
- Regression tests (compare to baseline)
- A/B testing in production
- Shadow deployment testing
- Adversarial testing
- Edge case testing
- Load testing

## Constraints & Timeline

### Q31: Timeline

**Question**: What is the target timeline and key milestones?
**Type**: textarea
**Required**: yes
**Format**:

```
POC/Prototype: [date]
MVP Model: [date]
Production Deployment: [date]
Key Milestones:
- Data collection & preparation: [date]
- Initial model training: [date]
- Model evaluation & selection: [date]
- Pipeline development: [date]
- Production deployment: [date]
```

### Q32: Budget

**Question**: What is the project budget or budget range?
**Type**: text
**Required**: no
**Note**: Include compute costs, data labeling, tools/platforms, and team resources

### Q33: Technical Constraints

**Question**: Are there any technical, computational, or data constraints?
**Type**: textarea
**Required**: no
**Suggestions**:

- Limited labeled data availability
- Computational budget constraints
- Latency requirements
- Model size constraints (edge deployment)
- Legacy system integration
- Data access restrictions
- Privacy regulations
- Specific technology mandates

## Success Metrics

### Q34: Key Performance Indicators

**Question**: How will ML project success be measured? What are the key metrics?
**Type**: list
**Required**: yes
**Suggestions**:

**Model Metrics**:

- Model accuracy/performance (specify target)
- Inference latency (target)
- Model size (if constrained)
- Training time

**Business Metrics**:

- Cost savings (specify target)
- Revenue increase (specify target)
- Efficiency gains (time saved, automation %)
- Customer satisfaction improvement
- Reduction in manual work
- ROI of ML investment

**Operational Metrics**:

- Model uptime/availability
- Retraining frequency
- Time to retrain and deploy
- Cost per prediction
- Pipeline reliability

### Q35: Success Criteria

**Question**: What specific outcomes would indicate the project is successful?
**Type**: textarea
**Required**: yes
**Examples**:

- "Achieve 95% accuracy on test set"
- "Reduce false positive rate by 50%"
- "Process 10,000 predictions per second with <100ms latency"
- "Save $500K annually in operational costs"
- "Deploy model to production within 6 months"
- "Maintain 99.9% uptime for inference service"
