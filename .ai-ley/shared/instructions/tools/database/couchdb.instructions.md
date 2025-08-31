Title: Apache CouchDB — AI Agent Implementation Guide

Purpose
- Provide strict, AI-agent-oriented guidance for when and how to use CouchDB.
- Enforce safe patterns for offline-first apps, multi-master replication, and JSON document storage.
- Prevent misuse: avoid using CouchDB for relational or strongly consistent workloads.

When to use
- Offline-first/mobile sync with multi-master replication (peer/edge/cloud).
- Documents with flexible schema and low contention updates.
- Eventual consistency is acceptable; conflict resolution can be automated.

When to avoid
- Strong consistency or relational queries/joins → prefer PostgreSQL.
- Complex aggregations/analytics → prefer PostgreSQL + columnar/warehouse.
- High-write contention on the same document → consider alternative designs.

Architecture essentials
- Storage: MVCC per document; revisions; attachments stored alongside doc metadata.
- Replication: filtered, continuous, and checkpointed; supports hub-and-spoke and mesh.
- Querying: Mango selectors, map/reduce views; secondary indexes via design documents.
- Clustering: Use CouchDB 3.x clustered setup with proper sharding/replicas; front with a reverse proxy.

Security and compliance
- Disable “admin party”; create admin users; enforce SCRAM auth; use TLS everywhere.
- Restrict _users and _replicator DBs; do not grant broad _admin roles to apps.
- Enforce CORS narrowly; pass auth via reverse proxy with JWT/OIDC if possible.
- PII: data minimization, encryption at rest (disk) and transit (TLS); redact logs.
- Backups: logical (replication to backup cluster) and snapshot-based; test restores.

Data modeling patterns
- One aggregate per document; embed small related data; avoid wide-hot docs.
- Use deterministic IDs for idempotency where appropriate.
- Conflict handling: store domain-specific merge logic; resolve promptly; log conflicts.
- Large binaries: prefer object storage; store references in docs.

Operations
- Compaction: schedule DB and view compaction during low traffic.
- Partitioning: use partitioned databases to optimize locality and query performance.
- Monitoring: couchdb-exporter → Prometheus; track open connections, request rates, 4xx/5xx, replication lag, conflicts.
- Capacity: plan shard/replica factors; validate with realistic load tests.

CI/CD and testing
- Validate design documents and Mango queries with unit tests.
- Spin ephemeral CouchDB in CI; seed representative datasets.
- Contract tests for replication filters/selectors and conflict-resolution routines.

Troubleshooting
- 409 Conflict spikes: inspect access patterns; add optimistic concurrency/backoff; reduce doc contention.
- Slow view builds: review map/reduce functions; schedule compaction; consider partitioned DBs.
- Replication stalls: check auth, network, and disk; reset checkpoints cautiously.

AI Assistant Guidelines
- Prefer PostgreSQL unless offline-first, replication-first requirements are explicit.
- Never propose joins; use document embedding or precomputed views.
- Include conflict-resolution strategy if writes can happen on multiple peers.
- Enforce security defaults: no admin party, TLS, least privilege, audit.
- Provide testable design-doc and Mango examples; include CI validation steps.

# CouchDB NoSQL Database Instructions

## Tool Overview
- **Tool Name**: Apache CouchDB
- **Version**: 3.3+ (Latest stable)
- **Category**: NoSQL Document Database
- **Purpose**: Distributed, fault-tolerant database with HTTP API and multi-master replication
- **Prerequisites**: CouchDB server installation, HTTP client

## Installation & Setup

### CouchDB Server Installation
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install couchdb

# macOS (via Homebrew)
brew install couchdb

# Docker installation
docker run -d --name couchdb \
  -e COUCHDB_USER=admin \
  -e COUCHDB_PASSWORD=password \
  -p 5984:5984 \
  apache/couchdb:3.3

# Start CouchDB service
sudo systemctl start couchdb
sudo systemctl enable couchdb

# Verify installation
curl http://localhost:5984/
```

### CouchDB Configuration
```bash
# Setup admin user (first time setup)
curl -X PUT http://localhost:5984/_node/_local/_config/admins/admin -d '"password"'

# Enable CORS
curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/httpd/enable_cors -d '"true"'
curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/cors/origins -d '"*"'
curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/cors/credentials -d '"true"'
curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/cors/methods -d '"GET, PUT, POST, HEAD, DELETE"'
curl -X PUT http://admin:password@localhost:5984/_node/_local/_config/cors/headers -d '"accept, authorization, content-type, origin, referer, x-csrf-token"'
```

### Client Libraries
```bash
# Python
pip install couchdb requests

# Node.js
npm install nano

# Java
# Add to pom.xml
<dependency>
    <groupId>org.lightcouch</groupId>
    <artifactId>lightcouch</artifactId>
    <version>0.2.0</version>
</dependency>

# PHP
composer require doctrine/couchdb
```

## Configuration

### Database Connection Setup
```python
import couchdb
import requests
import json
from typing import Dict, List, Any, Optional
import logging

class CouchDBManager:
    """Comprehensive CouchDB database manager."""
    
    def __init__(self, host='localhost', port=5984, username=None, password=None, use_ssl=False):
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.use_ssl = use_ssl
        
        # Build server URL
        protocol = 'https' if use_ssl else 'http'
        if username and password:
            self.server_url = f"{protocol}://{username}:{password}@{host}:{port}"
        else:
            self.server_url = f"{protocol}://{host}:{port}"
        
        # Initialize connection
        try:
            self.server = couchdb.Server(self.server_url)
            # Test connection
            info = self.get_server_info()
            logging.info(f"Connected to CouchDB {info.get('version')} on {host}:{port}")
        except Exception as e:
            logging.error(f"Failed to connect to CouchDB: {e}")
            raise
    
    def get_server_info(self) -> Dict[str, Any]:
        """Get CouchDB server information."""
        try:
            response = requests.get(f"{self.server_url}/")
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            logging.error(f"Error getting server info: {e}")
            raise
    
    def create_database(self, db_name: str) -> bool:
        """Create a new database."""
        try:
            if db_name in self.server:
                logging.warning(f"Database '{db_name}' already exists")
                return False
            
            self.server.create(db_name)
            logging.info(f"Database '{db_name}' created successfully")
            return True
        except Exception as e:
            logging.error(f"Error creating database '{db_name}': {e}")
            raise
    
    def delete_database(self, db_name: str) -> bool:
        """Delete a database."""
        try:
            if db_name not in self.server:
                logging.warning(f"Database '{db_name}' does not exist")
                return False
            
            del self.server[db_name]
            logging.info(f"Database '{db_name}' deleted successfully")
            return True
        except Exception as e:
            logging.error(f"Error deleting database '{db_name}': {e}")
            raise
    
    def list_databases(self) -> List[str]:
        """List all databases."""
        try:
            return list(self.server)
        except Exception as e:
            logging.error(f"Error listing databases: {e}")
            raise
    
    def get_database(self, db_name: str):
        """Get database instance."""
        try:
            if db_name not in self.server:
                raise ValueError(f"Database '{db_name}' does not exist")
            return self.server[db_name]
        except Exception as e:
            logging.error(f"Error accessing database '{db_name}': {e}")
            raise

# Usage example
couchdb_manager = CouchDBManager(
    host='localhost',
    port=5984,
    username='admin',
    password='password'
)

# Create database
couchdb_manager.create_database('myapp')
```

## Core Features

### Document Operations
- **Purpose**: Create, read, update, and delete JSON documents
- **Usage**: Store and manipulate schema-free documents with automatic versioning
- **Example**:
```python
class CouchDBDocumentManager:
    """Document operations manager for CouchDB."""
    
    def __init__(self, couchdb_manager, db_name):
        self.couchdb_manager = couchdb_manager
        self.db_name = db_name
        self.db = couchdb_manager.get_database(db_name)
    
    def create_document(self, doc_data: Dict[str, Any], doc_id: str = None) -> Dict[str, Any]:
        """Create a new document."""
        try:
            # Add metadata
            doc_data['created_at'] = self._get_timestamp()
            doc_data['updated_at'] = self._get_timestamp()
            doc_data['type'] = doc_data.get('type', 'document')
            
            if doc_id:
                doc_data['_id'] = doc_id
                doc_id, doc_rev = self.db.save(doc_data)
            else:
                doc_id, doc_rev = self.db.save(doc_data)
            
            result = {
                'id': doc_id,
                'rev': doc_rev,
                'success': True
            }
            
            logging.info(f"Document created with ID: {doc_id}")
            return result
            
        except Exception as e:
            logging.error(f"Error creating document: {e}")
            raise
    
    def get_document(self, doc_id: str) -> Optional[Dict[str, Any]]:
        """Retrieve a document by ID."""
        try:
            doc = self.db[doc_id]
            logging.info(f"Document retrieved: {doc_id}")
            return dict(doc)
        except couchdb.ResourceNotFound:
            logging.warning(f"Document not found: {doc_id}")
            return None
        except Exception as e:
            logging.error(f"Error retrieving document {doc_id}: {e}")
            raise
    
    def update_document(self, doc_id: str, updates: Dict[str, Any]) -> Dict[str, Any]:
        """Update an existing document."""
        try:
            # Get current document
            doc = self.db[doc_id]
            
            # Apply updates
            for key, value in updates.items():
                if key not in ['_id', '_rev']:  # Preserve system fields
                    doc[key] = value
            
            # Update metadata
            doc['updated_at'] = self._get_timestamp()
            
            # Save updated document
            doc_id, doc_rev = self.db.save(doc)
            
            result = {
                'id': doc_id,
                'rev': doc_rev,
                'success': True
            }
            
            logging.info(f"Document updated: {doc_id}")
            return result
            
        except couchdb.ResourceNotFound:
            logging.error(f"Document not found for update: {doc_id}")
            raise ValueError(f"Document {doc_id} not found")
        except Exception as e:
            logging.error(f"Error updating document {doc_id}: {e}")
            raise
    
    def delete_document(self, doc_id: str) -> bool:
        """Delete a document."""
        try:
            doc = self.db[doc_id]
            self.db.delete(doc)
            logging.info(f"Document deleted: {doc_id}")
            return True
        except couchdb.ResourceNotFound:
            logging.warning(f"Document not found for deletion: {doc_id}")
            return False
        except Exception as e:
            logging.error(f"Error deleting document {doc_id}: {e}")
            raise
    
    def bulk_insert(self, documents: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Insert multiple documents in bulk."""
        try:
            # Add metadata to all documents
            for doc in documents:
                doc['created_at'] = self._get_timestamp()
                doc['updated_at'] = self._get_timestamp()
                doc['type'] = doc.get('type', 'document')
            
            # Bulk insert
            results = self.db.update(documents)
            
            # Process results
            processed_results = []
            for i, (success, doc_id, rev_or_error) in enumerate(results):
                if success:
                    processed_results.append({
                        'id': doc_id,
                        'rev': rev_or_error,
                        'success': True
                    })
                else:
                    processed_results.append({
                        'index': i,
                        'error': rev_or_error,
                        'success': False
                    })
            
            logging.info(f"Bulk insert completed: {len(documents)} documents")
            return processed_results
            
        except Exception as e:
            logging.error(f"Error in bulk insert: {e}")
            raise
    
    def get_all_documents(self, include_docs=True, limit=None, skip=None) -> List[Dict[str, Any]]:
        """Get all documents from database."""
        try:
            view_params = {'include_docs': include_docs}
            
            if limit:
                view_params['limit'] = limit
            if skip:
                view_params['skip'] = skip
            
            rows = self.db.view('_all_docs', **view_params)
            
            if include_docs:
                documents = [row.doc for row in rows if row.doc]
            else:
                documents = [{'id': row.id, 'key': row.key} for row in rows]
            
            logging.info(f"Retrieved {len(documents)} documents")
            return documents
            
        except Exception as e:
            logging.error(f"Error retrieving all documents: {e}")
            raise
    
    def _get_timestamp(self) -> str:
        """Get current timestamp in ISO format."""
        from datetime import datetime
        return datetime.utcnow().isoformat() + 'Z'

# Usage example
doc_manager = CouchDBDocumentManager(couchdb_manager, 'myapp')

# Create document
user_doc = {
    'type': 'user',
    'name': 'John Doe',
    'email': 'john@example.com',
    'age': 30,
    'preferences': {
        'theme': 'dark',
        'language': 'en'
    }
}

result = doc_manager.create_document(user_doc)
user_id = result['id']

# Update document
updates = {
    'age': 31,
    'preferences': {
        'theme': 'light',
        'language': 'en'
    }
}
doc_manager.update_document(user_id, updates)

# Retrieve document
user = doc_manager.get_document(user_id)
print(f"User: {user['name']}, Age: {user['age']}")
```

### Views and Queries
- **Purpose**: Create custom indexes and query patterns using MapReduce
- **Usage**: Efficient data retrieval and aggregation with JavaScript functions
- **Example**:
```python
class CouchDBViewManager:
    """Manage CouchDB views and queries."""
    
    def __init__(self, couchdb_manager, db_name):
        self.couchdb_manager = couchdb_manager
        self.db_name = db_name
        self.db = couchdb_manager.get_database(db_name)
    
    def create_design_document(self, design_name: str, views: Dict[str, Dict[str, str]]) -> Dict[str, Any]:
        """Create a design document with views."""
        try:
            design_doc = {
                '_id': f'_design/{design_name}',
                'language': 'javascript',
                'views': views
            }
            
            # Check if design document already exists
            try:
                existing_doc = self.db[f'_design/{design_name}']
                design_doc['_rev'] = existing_doc['_rev']
                logging.info(f"Updating existing design document: {design_name}")
            except couchdb.ResourceNotFound:
                logging.info(f"Creating new design document: {design_name}")
            
            doc_id, doc_rev = self.db.save(design_doc)
            
            result = {
                'id': doc_id,
                'rev': doc_rev,
                'success': True
            }
            
            logging.info(f"Design document saved: {design_name}")
            return result
            
        except Exception as e:
            logging.error(f"Error creating design document {design_name}: {e}")
            raise
    
    def query_view(self, design_name: str, view_name: str, **params) -> List[Dict[str, Any]]:
        """Query a view with optional parameters."""
        try:
            view_path = f'{design_name}/{view_name}'
            rows = self.db.view(view_path, **params)
            
            results = []
            for row in rows:
                result = {
                    'key': row.key,
                    'value': row.value
                }
                if hasattr(row, 'doc') and row.doc:
                    result['doc'] = row.doc
                results.append(result)
            
            logging.info(f"View query completed: {view_path}, {len(results)} results")
            return results
            
        except Exception as e:
            logging.error(f"Error querying view {design_name}/{view_name}: {e}")
            raise
    
    def create_user_views(self):
        """Create common views for user documents."""
        user_views = {
            'by_email': {
                'map': '''
                function(doc) {
                    if (doc.type === 'user' && doc.email) {
                        emit(doc.email, {
                            name: doc.name,
                            created_at: doc.created_at
                        });
                    }
                }
                '''
            },
            'by_age_range': {
                'map': '''
                function(doc) {
                    if (doc.type === 'user' && doc.age) {
                        var ageRange;
                        if (doc.age < 18) ageRange = 'minor';
                        else if (doc.age < 30) ageRange = 'young_adult';
                        else if (doc.age < 50) ageRange = 'adult';
                        else ageRange = 'senior';
                        
                        emit(ageRange, {
                            name: doc.name,
                            age: doc.age,
                            email: doc.email
                        });
                    }
                }
                ''',
                'reduce': '''
                function(keys, values, rereduce) {
                    return values.length;
                }
                '''
            },
            'active_users': {
                'map': '''
                function(doc) {
                    if (doc.type === 'user' && doc.last_login) {
                        var lastLogin = new Date(doc.last_login);
                        var thirtyDaysAgo = new Date();
                        thirtyDaysAgo.setDate(thirtyDaysAgo.getDate() - 30);
                        
                        if (lastLogin > thirtyDaysAgo) {
                            emit(doc.last_login, {
                                name: doc.name,
                                email: doc.email
                            });
                        }
                    }
                }
                '''
            }
        }
        
        return self.create_design_document('users', user_views)
    
    def find_users_by_email(self, email: str) -> List[Dict[str, Any]]:
        """Find users by email using view."""
        return self.query_view('users', 'by_email', key=email, include_docs=True)
    
    def get_users_by_age_range(self, age_range: str = None) -> List[Dict[str, Any]]:
        """Get users by age range."""
        if age_range:
            return self.query_view('users', 'by_age_range', key=age_range)
        else:
            return self.query_view('users', 'by_age_range', group=True)
    
    def get_active_users(self) -> List[Dict[str, Any]]:
        """Get recently active users."""
        return self.query_view('users', 'active_users', include_docs=True, descending=True)

# Usage example
view_manager = CouchDBViewManager(couchdb_manager, 'myapp')

# Create user views
view_manager.create_user_views()

# Query views
users_by_email = view_manager.find_users_by_email('john@example.com')
age_distribution = view_manager.get_users_by_age_range()
active_users = view_manager.get_active_users()
```

### Replication and Sync
- **Purpose**: Synchronize data between CouchDB instances
- **Usage**: Multi-master replication for distributed applications
- **Example**:
```python
class CouchDBReplicationManager:
    """Manage CouchDB replication and synchronization."""
    
    def __init__(self, couchdb_manager):
        self.couchdb_manager = couchdb_manager
        self.server = couchdb_manager.server
        self.server_url = couchdb_manager.server_url
    
    def create_replication(self, source_db: str, target_db: str, 
                          continuous: bool = False, 
                          create_target: bool = True,
                          replication_id: str = None) -> Dict[str, Any]:
        """Create a replication between databases."""
        try:
            replication_doc = {
                'source': source_db,
                'target': target_db,
                'continuous': continuous,
                'create_target': create_target
            }
            
            if replication_id:
                replication_doc['_id'] = replication_id
            
            # Create replication using _replicate endpoint
            response = requests.post(
                f"{self.server_url}/_replicate",
                json=replication_doc,
                headers={'Content-Type': 'application/json'}
            )
            response.raise_for_status()
            
            result = response.json()
            logging.info(f"Replication created: {source_db} -> {target_db}")
            return result
            
        except Exception as e:
            logging.error(f"Error creating replication: {e}")
            raise
    
    def create_continuous_replication(self, source_db: str, target_db: str) -> Dict[str, Any]:
        """Create continuous bidirectional replication."""
        try:
            # Create replication documents in _replicator database
            replicator_db_name = '_replicator'
            
            # Ensure _replicator database exists
            if replicator_db_name not in self.server:
                self.server.create(replicator_db_name)
            
            replicator_db = self.server[replicator_db_name]
            
            # Source to target replication
            source_to_target = {
                '_id': f'repl_{source_db}_to_{target_db}',
                'source': source_db,
                'target': target_db,
                'continuous': True,
                'create_target': True
            }
            
            # Target to source replication (bidirectional)
            target_to_source = {
                '_id': f'repl_{target_db}_to_{source_db}',
                'source': target_db,
                'target': source_db,
                'continuous': True,
                'create_target': True
            }
            
            # Save replication documents
            replicator_db.save(source_to_target)
            replicator_db.save(target_to_source)
            
            logging.info(f"Continuous bidirectional replication created: {source_db} <-> {target_db}")
            return {
                'source_to_target': source_to_target['_id'],
                'target_to_source': target_to_source['_id'],
                'success': True
            }
            
        except Exception as e:
            logging.error(f"Error creating continuous replication: {e}")
            raise
    
    def get_replication_status(self) -> List[Dict[str, Any]]:
        """Get status of all replications."""
        try:
            response = requests.get(f"{self.server_url}/_scheduler/docs")
            response.raise_for_status()
            
            scheduler_docs = response.json()
            
            replications = []
            for doc in scheduler_docs.get('docs', []):
                replications.append({
                    'id': doc.get('id'),
                    'database': doc.get('database'),
                    'doc_id': doc.get('doc_id'),
                    'source': doc.get('source'),
                    'target': doc.get('target'),
                    'state': doc.get('state'),
                    'info': doc.get('info', {})
                })
            
            return replications
            
        except Exception as e:
            logging.error(f"Error getting replication status: {e}")
            raise
    
    def stop_replication(self, replication_id: str) -> bool:
        """Stop a continuous replication."""
        try:
            replicator_db = self.server['_replicator']
            
            # Get replication document
            repl_doc = replicator_db[replication_id]
            
            # Delete replication document to stop replication
            replicator_db.delete(repl_doc)
            
            logging.info(f"Replication stopped: {replication_id}")
            return True
            
        except couchdb.ResourceNotFound:
            logging.warning(f"Replication not found: {replication_id}")
            return False
        except Exception as e:
            logging.error(f"Error stopping replication {replication_id}: {e}")
            raise

# Usage example
repl_manager = CouchDBReplicationManager(couchdb_manager)

# Create one-time replication
repl_manager.create_replication('myapp', 'myapp_backup')

# Create continuous bidirectional replication
repl_manager.create_continuous_replication('myapp', 'myapp_remote')

# Check replication status
status = repl_manager.get_replication_status()
for repl in status:
    print(f"Replication {repl['id']}: {repl['state']}")
```

## Development Workflow
1. **Setup**: Install CouchDB server and configure authentication
2. **Database Design**: Create databases and design documents with views
3. **Development**: Implement document operations and query patterns
4. **Testing**: Test CRUD operations and view queries
5. **Deployment**: Configure replication and backup strategies

## Best Practices

### Document Design Patterns
```python
class CouchDBDocumentPatterns:
    """Best practices for CouchDB document design."""
    
    @staticmethod
    def create_user_document(user_data: Dict[str, Any]) -> Dict[str, Any]:
        """Create well-structured user document."""
        from datetime import datetime
        import uuid
        
        doc = {
            '_id': f"user:{uuid.uuid4()}",
            'type': 'user',
            'created_at': datetime.utcnow().isoformat() + 'Z',
            'updated_at': datetime.utcnow().isoformat() + 'Z',
            'version': 1,
            
            # User data
            'profile': {
                'name': user_data.get('name'),
                'email': user_data.get('email'),
                'avatar_url': user_data.get('avatar_url')
            },
            
            # Preferences
            'preferences': user_data.get('preferences', {}),
            
            # Metadata
            'metadata': {
                'source': 'api',
                'last_login': None,
                'login_count': 0
            }
        }
        
        return doc
    
    @staticmethod
    def create_timestamped_document(doc_type: str, data: Dict[str, Any]) -> Dict[str, Any]:
        """Create document with proper timestamp and metadata."""
        from datetime import datetime
        import uuid
        
        doc = {
            '_id': f"{doc_type}:{uuid.uuid4()}",
            'type': doc_type,
            'created_at': datetime.utcnow().isoformat() + 'Z',
            'updated_at': datetime.utcnow().isoformat() + 'Z',
            'version': 1
        }
        
        # Add data fields
        doc.update(data)
        
        return doc
    
    @staticmethod
    def update_document_version(doc: Dict[str, Any], updates: Dict[str, Any]) -> Dict[str, Any]:
        """Update document with version increment."""
        from datetime import datetime
        
        # Apply updates
        for key, value in updates.items():
            if key not in ['_id', '_rev', 'created_at', 'version']:
                doc[key] = value
        
        # Update metadata
        doc['updated_at'] = datetime.utcnow().isoformat() + 'Z'
        doc['version'] = doc.get('version', 1) + 1
        
        return doc

# Usage example
user_data = {
    'name': 'Jane Smith',
    'email': 'jane@example.com',
    'preferences': {
        'theme': 'dark',
        'notifications': True
    }
}

user_doc = CouchDBDocumentPatterns.create_user_document(user_data)
```

### Performance Optimization
```python
class CouchDBPerformanceOptimizer:
    """Performance optimization techniques for CouchDB."""
    
    def __init__(self, couchdb_manager, db_name):
        self.couchdb_manager = couchdb_manager
        self.db = couchdb_manager.get_database(db_name)
    
    def create_indexes(self):
        """Create indexes for common query patterns."""
        indexes = [
            {
                'index': {
                    'fields': ['type', 'created_at']
                },
                'name': 'type-created-index',
                'type': 'json'
            },
            {
                'index': {
                    'fields': ['type', 'email']
                },
                'name': 'type-email-index',
                'type': 'json'
            },
            {
                'index': {
                    'fields': ['type', 'updated_at']
                },
                'name': 'type-updated-index',
                'type': 'json'
            }
        ]
        
        for index_def in indexes:
            try:
                response = requests.post(
                    f"{self.couchdb_manager.server_url}/{self.db.name}/_index",
                    json=index_def,
                    headers={'Content-Type': 'application/json'}
                )
                
                if response.status_code in [200, 201]:
                    logging.info(f"Index created: {index_def['name']}")
                else:
                    logging.warning(f"Index creation failed: {response.text}")
                    
            except Exception as e:
                logging.error(f"Error creating index {index_def['name']}: {e}")
    
    def optimize_bulk_operations(self, documents: List[Dict[str, Any]], batch_size: int = 100):
        """Optimize bulk operations with batching."""
        results = []
        
        for i in range(0, len(documents), batch_size):
            batch = documents[i:i + batch_size]
            
            try:
                batch_results = self.db.update(batch)
                results.extend(batch_results)
                logging.info(f"Processed batch {i//batch_size + 1}: {len(batch)} documents")
                
            except Exception as e:
                logging.error(f"Error in batch {i//batch_size + 1}: {e}")
                # Continue with next batch
                
        return results
    
    def use_mango_queries(self, selector: Dict[str, Any], 
                         fields: List[str] = None, 
                         sort: List[Dict[str, Any]] = None,
                         limit: int = None) -> List[Dict[str, Any]]:
        """Use Mango queries for efficient data retrieval."""
        query = {
            'selector': selector
        }
        
        if fields:
            query['fields'] = fields
        if sort:
            query['sort'] = sort
        if limit:
            query['limit'] = limit
        
        try:
            response = requests.post(
                f"{self.couchdb_manager.server_url}/{self.db.name}/_find",
                json=query,
                headers={'Content-Type': 'application/json'}
            )
            response.raise_for_status()
            
            result = response.json()
            documents = result.get('docs', [])
            
            logging.info(f"Mango query returned {len(documents)} documents")
            return documents
            
        except Exception as e:
            logging.error(f"Error in Mango query: {e}")
            raise

# Usage example
optimizer = CouchDBPerformanceOptimizer(couchdb_manager, 'myapp')

# Create performance indexes
optimizer.create_indexes()

# Use Mango query
active_users = optimizer.use_mango_queries(
    selector={
        'type': 'user',
        'metadata.last_login': {'$gte': '2023-01-01T00:00:00Z'}
    },
    fields=['_id', 'profile.name', 'profile.email'],
    sort=[{'metadata.last_login': 'desc'}],
    limit=50
)
```

## Common Commands
```bash
# Database operations via HTTP API
curl -X PUT http://admin:password@localhost:5984/mydb
curl -X GET http://admin:password@localhost:5984/mydb
curl -X DELETE http://admin:password@localhost:5984/mydb

# Document operations
curl -X PUT http://admin:password@localhost:5984/mydb/doc1 -d '{"name":"test"}'
curl -X GET http://admin:password@localhost:5984/mydb/doc1
curl -X DELETE http://admin:password@localhost:5984/mydb/doc1?rev=1-abc123

# View queries
curl -X GET http://admin:password@localhost:5984/mydb/_design/users/_view/by_email?key="john@example.com"

# Replication
curl -X POST http://admin:password@localhost:5984/_replicate -d '{"source":"db1","target":"db2"}'
```

## Common Issues & Solutions

### Issue 1: Document Update Conflicts
**Problem**: Concurrent updates causing document conflicts
**Solution**: Implement proper conflict resolution strategy
```python
def resolve_document_conflict(doc_manager, doc_id):
    """Resolve document conflicts by merging changes."""
    try:
        # Get document with conflicts
        doc = doc_manager.db[doc_id]
        
        if '_conflicts' in doc:
            conflicts = doc['_conflicts']
            logging.info(f"Resolving {len(conflicts)} conflicts for document {doc_id}")
            
            # Get all conflicted versions
            conflicted_docs = []
            for rev in conflicts:
                conflicted_doc = doc_manager.db.get(doc_id, rev=rev)
                conflicted_docs.append(conflicted_doc)
            
            # Merge strategy (newest wins)
            merged_doc = doc.copy()
            
            for conflicted_doc in conflicted_docs:
                if conflicted_doc.get('updated_at', '') > merged_doc.get('updated_at', ''):
                    # Merge newer fields
                    for key, value in conflicted_doc.items():
                        if key not in ['_id', '_rev', '_conflicts']:
                            merged_doc[key] = value
            
            # Save resolved document
            doc_manager.db.save(merged_doc)
            
            # Delete conflicted revisions
            for rev in conflicts:
                try:
                    doc_manager.db.delete({'_id': doc_id, '_rev': rev})
                except:
                    pass
            
            logging.info(f"Conflicts resolved for document {doc_id}")
            
    except Exception as e:
        logging.error(f"Error resolving conflicts for {doc_id}: {e}")
```

### Issue 2: View Performance Issues
**Problem**: Slow view queries affecting application performance
**Solution**: Optimize view design and use appropriate indexing
```python
def optimize_view_performance():
    """Tips for optimizing view performance."""
    
    # Use built-in reduce functions when possible
    optimized_view = {
        'by_status': {
            'map': '''
            function(doc) {
                if (doc.type === 'order') {
                    emit(doc.status, 1);
                }
            }
            ''',
            'reduce': '_count'  # Built-in reduce function
        }
    }
    
    # Create compound keys for complex queries
    compound_key_view = {
        'by_date_and_status': {
            'map': '''
            function(doc) {
                if (doc.type === 'order') {
                    emit([doc.created_date, doc.status], doc);
                }
            }
            '''
        }
    }
    
    return {
        'optimized_views': {
            'orders': optimized_view,
            'complex_queries': compound_key_view
        }
    }
```

## Security Considerations
- Enable authentication and use strong passwords
- Configure SSL/TLS for production deployments
- Implement proper database-level security with user roles
- Validate all input data before storing documents
- Use HTTPS for all client communications
- Implement proper backup and recovery procedures

## AI Assistant Guidelines
When helping with CouchDB implementation:

1. **Always emphasize document-oriented design** over relational thinking
2. **Use proper view design** for efficient queries and aggregations
3. **Implement conflict resolution** for distributed scenarios
4. **Include proper error handling** for network and database operations
5. **Suggest appropriate replication strategies** based on use case
6. **Follow CouchDB best practices** for document structure and indexing
7. **Consider performance implications** of view queries and bulk operations
8. **Reference CouchDB documentation** for advanced features and configuration

### Code Generation Rules
- Generate document-oriented data models with proper JSON structure
- Include comprehensive error handling for HTTP API operations
- Use appropriate CouchDB features like views, replication, and Mango queries
- Follow CouchDB naming conventions and design patterns
- Include conflict resolution strategies for distributed applications
- Provide performance optimization recommendations
- Generate modular code suitable for different CouchDB use cases
- Include proper authentication and security considerations