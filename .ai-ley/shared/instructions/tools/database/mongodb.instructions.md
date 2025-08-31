# MongoDB Database Instructions

## Database Overview
- **Database System**: MongoDB
- **Version**: 7.0+ (Current stable version)
- **Type**: NoSQL Document Database
- **License**: Server Side Public License (SSPL) / MongoDB Community License
- **Use Cases**: Content management, real-time analytics, IoT data, mobile apps, microservices

## Installation & Setup
### Local Installation
```bash
# Package manager installation
# Ubuntu/Debian
wget -qO - https://www.mongodb.org/static/pgp/server-7.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
sudo apt-get update && sudo apt-get install -y mongodb-org

# macOS
brew tap mongodb/brew
brew install mongodb-community

# Docker installation
docker run -d --name mongodb \
  -p 27017:27017 \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=password \
  -v mongodb_data:/data/db \
  mongo:7.0

# MongoDB Atlas (Cloud)
# Use MongoDB Atlas web interface or CLI
mongocli atlas cluster create myCluster --provider AWS --region US_EAST_1
```

### Configuration
```yaml
# mongod.conf - Main configuration file
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
  wiredTiger:
    engineConfig:
      cacheSizeGB: 1.5

systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log
  logRotate: rename

net:
  port: 27017
  bindIp: 127.0.0.1

processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod.pid

security:
  authorization: enabled
  keyFile: /etc/mongodb/mongodb-keyfile
```

## Core Concepts
### Collections and Documents
- **Purpose**: Collections store documents (BSON objects) similar to tables storing rows
- **Usage**: Flexible schema allows varied document structures within collections
- **Best Practices**: Use consistent document structure, avoid deeply nested documents (>100 levels)

### Indexes
- **Purpose**: Accelerate query performance through efficient data access
- **Usage**: Create on frequently queried fields, compound indexes for multi-field queries
- **Best Practices**: Monitor index usage, use sparse indexes for optional fields

### Replica Sets
- **Purpose**: Provide high availability and data redundancy
- **Usage**: Automatic failover and data replication across multiple nodes
- **Best Practices**: Use odd number of nodes, configure appropriate read preferences

## Connection and Authentication
### Connection Methods
```javascript
// MongoDB Node.js Driver
const { MongoClient } = require('mongodb');

// Connection string format
const uri = 'mongodb://username:password@localhost:27017/myapp?authSource=admin';

// Basic connection
const client = new MongoClient(uri, {
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
});

async function connectToDatabase() {
  try {
    await client.connect();
    console.log('Connected to MongoDB');
    return client.db('myapp');
  } catch (error) {
    console.error('Connection error:', error);
    throw error;
  }
}

// Connection pooling is handled automatically
```

```python
# Python with PyMongo
from pymongo import MongoClient
from pymongo.errors import ConnectionFailure

# Connection with authentication
client = MongoClient(
    host='localhost',
    port=27017,
    username='username',
    password='password',
    authSource='admin',
    maxPoolSize=50,
    serverSelectionTimeoutMS=5000
)

try:
    # Test connection
    client.admin.command('ping')
    db = client['myapp']
    print("Connected to MongoDB successfully")
except ConnectionFailure:
    print("Failed to connect to MongoDB")
```

### Authentication & Security
```javascript
// Create admin user
db.createUser({
  user: "admin",
  pwd: "securePassword",
  roles: [
    { role: "userAdminAnyDatabase", db: "admin" },
    { role: "readWriteAnyDatabase", db: "admin" },
    { role: "dbAdminAnyDatabase", db: "admin" }
  ]
});

// Create application user with limited privileges
db.createUser({
  user: "app_user",
  pwd: "appPassword",
  roles: [
    { role: "readWrite", db: "myapp" }
  ]
});

// Enable SSL/TLS (in mongod.conf)
// net:
//   tls:
//     mode: requireTLS
//     certificateKeyFile: /etc/ssl/mongodb.pem
//     CAFile: /etc/ssl/ca.pem
```

## Data Modeling
### Document Design Best Practices
- **Embed related data** that is accessed together (1-to-1, 1-to-few relationships)
- **Reference related data** for 1-to-many or many-to-many relationships
- **Consider query patterns** when designing document structure
- **Limit document size** to 16MB, optimal size is much smaller

### Example Schema
```javascript
// Users collection - embedded profile data
{
  _id: ObjectId("64a7b8c9d1e2f3a4b5c6d7e8"),
  email: "user@example.com",
  username: "johndoe",
  passwordHash: "$2b$12$...",
  profile: {
    firstName: "John",
    lastName: "Doe",
    dateOfBirth: ISODate("1990-05-15"),
    location: {
      city: "New York",
      country: "USA",
      coordinates: [40.7128, -74.0060]
    },
    preferences: {
      theme: "dark",
      notifications: true,
      language: "en"
    }
  },
  createdAt: ISODate(),
  updatedAt: ISODate(),
  isActive: true,
  tags: ["premium", "verified"]
}

// Posts collection - referenced user data
{
  _id: ObjectId("64a7b8c9d1e2f3a4b5c6d7e9"),
  userId: ObjectId("64a7b8c9d1e2f3a4b5c6d7e8"),
  title: "My First Blog Post",
  content: "This is the content of my blog post...",
  tags: ["mongodb", "nosql", "database"],
  publishedAt: ISODate(),
  createdAt: ISODate(),
  updatedAt: ISODate(),
  comments: [
    {
      _id: ObjectId(),
      userId: ObjectId("64a7b8c9d1e2f3a4b5c6d7f0"),
      content: "Great post!",
      createdAt: ISODate()
    }
  ],
  metadata: {
    views: 1250,
    likes: 45,
    shares: 12
  },
  status: "published"
}
```

## CRUD Operations
### Create Operations
```javascript
// Insert single document
const result = await db.collection('users').insertOne({
  email: 'user@example.com',
  username: 'johndoe',
  passwordHash: '$2b$12$...',
  profile: {
    firstName: 'John',
    lastName: 'Doe'
  },
  createdAt: new Date(),
  isActive: true
});

console.log('Inserted document ID:', result.insertedId);

// Insert multiple documents
const posts = [
  {
    userId: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8'),
    title: 'First Post',
    content: 'Content here',
    createdAt: new Date()
  },
  {
    userId: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8'),
    title: 'Second Post', 
    content: 'More content',
    createdAt: new Date()
  }
];

const insertResult = await db.collection('posts').insertMany(posts, {
  ordered: false // Continue on error
});

// Upsert operation
const upsertResult = await db.collection('users').updateOne(
  { email: 'user@example.com' },
  {
    $set: {
      username: 'johndoe',
      updatedAt: new Date()
    },
    $setOnInsert: {
      createdAt: new Date(),
      isActive: true
    }
  },
  { upsert: true }
);
```

### Read Operations
```javascript
// Simple find with projection
const users = await db.collection('users')
  .find(
    { isActive: true },
    { projection: { passwordHash: 0, __v: 0 } }
  )
  .sort({ createdAt: -1 })
  .limit(50)
  .toArray();

// Complex aggregation pipeline
const userStats = await db.collection('posts').aggregate([
  {
    $match: {
      publishedAt: { $exists: true },
      createdAt: { $gte: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000) }
    }
  },
  {
    $lookup: {
      from: 'users',
      localField: 'userId',
      foreignField: '_id',
      as: 'user'
    }
  },
  {
    $unwind: '$user'
  },
  {
    $group: {
      _id: '$userId',
      username: { $first: '$user.username' },
      postCount: { $sum: 1 },
      totalViews: { $sum: '$metadata.views' },
      avgViews: { $avg: '$metadata.views' },
      lastPost: { $max: '$publishedAt' }
    }
  },
  {
    $sort: { postCount: -1, totalViews: -1 }
  },
  {
    $limit: 10
  }
]).toArray();

// Text search
const searchResults = await db.collection('posts')
  .find(
    { $text: { $search: 'mongodb database tutorial' } },
    { score: { $meta: 'textScore' } }
  )
  .sort({ score: { $meta: 'textScore' } })
  .limit(20)
  .toArray();

// Geospatial query
const nearbyUsers = await db.collection('users').find({
  'profile.location.coordinates': {
    $near: {
      $geometry: {
        type: 'Point',
        coordinates: [-74.0060, 40.7128] // [longitude, latitude]
      },
      $maxDistance: 1000 // meters
    }
  }
}).toArray();
```

### Update Operations
```javascript
// Update single document
const updateResult = await db.collection('users').updateOne(
  { _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8') },
  {
    $set: {
      'profile.firstName': 'John',
      updatedAt: new Date()
    },
    $inc: { 'profile.loginCount': 1 },
    $addToSet: { tags: 'frequent_user' }
  }
);

// Update multiple documents
const bulkUpdateResult = await db.collection('posts').updateMany(
  { 
    userId: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8'),
    publishedAt: { $exists: false }
  },
  {
    $set: { 
      publishedAt: new Date(),
      status: 'published'
    }
  }
);

// Array operations
const arrayUpdateResult = await db.collection('posts').updateOne(
  { _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e9') },
  {
    $push: {
      comments: {
        _id: new ObjectId(),
        userId: ObjectId('64a7b8c9d1e2f3a4b5c6d7f0'),
        content: 'Great post!',
        createdAt: new Date()
      }
    },
    $inc: { 'metadata.views': 1 }
  }
);

// Positional updates
const positionUpdateResult = await db.collection('posts').updateOne(
  { 
    _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e9'),
    'comments._id': ObjectId('64a7b8c9d1e2f3a4b5c6d7f1')
  },
  {
    $set: { 
      'comments.$.content': 'Updated comment content',
      'comments.$.updatedAt': new Date()
    }
  }
);
```

### Delete Operations
```javascript
// Soft delete (recommended)
const softDeleteResult = await db.collection('users').updateOne(
  { _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8') },
  {
    $set: {
      isActive: false,
      deletedAt: new Date()
    }
  }
);

// Hard delete single document
const deleteResult = await db.collection('posts').deleteOne({
  _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e9')
});

// Delete multiple documents with conditions
const bulkDeleteResult = await db.collection('posts').deleteMany({
  createdAt: { $lt: new Date(Date.now() - 365 * 24 * 60 * 60 * 1000) },
  status: 'draft'
});

// Remove array elements
const arrayDeleteResult = await db.collection('posts').updateOne(
  { _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7e9') },
  {
    $pull: {
      comments: {
        _id: ObjectId('64a7b8c9d1e2f3a4b5c6d7f1')
      }
    }
  }
);
```

## Performance Optimization
### Indexing Strategies
```javascript
// Single field index
db.users.createIndex({ email: 1 });
db.users.createIndex({ username: 1 }, { unique: true });

// Compound index (order matters!)
db.posts.createIndex({ userId: 1, publishedAt: -1 });
db.posts.createIndex({ status: 1, createdAt: -1 });

// Text index for search
db.posts.createIndex({
  title: 'text',
  content: 'text',
  tags: 'text'
}, {
  weights: {
    title: 10,
    content: 5,
    tags: 1
  },
  name: 'posts_text_index'
});

// Geospatial index
db.users.createIndex({ 'profile.location.coordinates': '2dsphere' });

// Sparse index (only indexes documents with the field)
db.users.createIndex({ 'profile.phoneNumber': 1 }, { sparse: true });

// Partial index (with filter)
db.posts.createIndex(
  { publishedAt: -1 },
  { 
    partialFilterExpression: { 
      status: 'published',
      publishedAt: { $exists: true }
    }
  }
);

// TTL index (automatic deletion)
db.sessions.createIndex(
  { createdAt: 1 },
  { expireAfterSeconds: 3600 } // 1 hour
);
```

### Query Optimization
```javascript
// Use explain() to analyze query performance
const explainResult = await db.collection('posts')
  .find({ userId: ObjectId('64a7b8c9d1e2f3a4b5c6d7e8') })
  .sort({ publishedAt: -1 })
  .explain('executionStats');

// Efficient pagination with _id
const page1 = await db.collection('posts')
  .find({ status: 'published' })
  .sort({ _id: -1 })
  .limit(20)
  .toArray();

const lastId = page1[page1.length - 1]._id;
const page2 = await db.collection('posts')
  .find({ 
    status: 'published',
    _id: { $lt: lastId }
  })
  .sort({ _id: -1 })
  .limit(20)
  .toArray();

// Efficient counting with estimatedDocumentCount
const estimatedCount = await db.collection('posts').estimatedDocumentCount();
const exactCount = await db.collection('posts').countDocuments({ status: 'published' });

// Use aggregation for complex queries
const optimizedAggregation = [
  // Match early to reduce document flow
  { $match: { status: 'published', publishedAt: { $exists: true } } },
  
  // Project only needed fields
  { 
    $project: {
      userId: 1,
      title: 1,
      publishedAt: 1,
      'metadata.views': 1
    }
  },
  
  // Sort with index
  { $sort: { publishedAt: -1 } },
  
  // Limit early
  { $limit: 100 },
  
  // Then do expensive operations
  {
    $lookup: {
      from: 'users',
      localField: 'userId',
      foreignField: '_id',
      as: 'user'
    }
  }
];
```

### Monitoring & Profiling
```javascript
// Enable profiling
db.setProfilingLevel(2, { slowms: 100 }); // Profile queries slower than 100ms

// View slow queries
db.system.profile.find().sort({ ts: -1 }).limit(10);

// Database statistics
db.stats();
db.collection('posts').stats();

// Index usage statistics
db.collection('posts').aggregate([
  { $indexStats: {} }
]);

// Current operations
db.currentOp({ "active": true, "secs_running": { "$gt": 5 } });

// Server status
db.serverStatus();
```

## Backup and Recovery
### Backup Strategies
```bash
# Full database backup
mongodump --host localhost:27017 --db myapp --out /backup/myapp-backup

# Compressed backup
mongodump --host localhost:27017 --db myapp --archive=/backup/myapp.archive --gzip

# Backup with authentication
mongodump --host localhost:27017 --username admin --password password --authenticationDatabase admin --db myapp --out /backup/

# Collection-specific backup
mongodump --host localhost:27017 --db myapp --collection posts --out /backup/posts-backup

# Replica set backup (from secondary)
mongodump --host secondary.example.com:27017 --db myapp --readPreference secondary --out /backup/
```

### Recovery Procedures
```bash
# Full database restore
mongorestore --host localhost:27017 --db myapp /backup/myapp-backup/myapp

# Restore from archive
mongorestore --host localhost:27017 --archive=/backup/myapp.archive --gzip

# Restore with drop (replace existing)
mongorestore --host localhost:27017 --db myapp --drop /backup/myapp-backup/myapp

# Restore to different database
mongorestore --host localhost:27017 --db myapp_restored /backup/myapp-backup/myapp

# Point-in-time recovery using oplog
mongorestore --host localhost:27017 --oplogReplay --oplogLimit 1640995200:1 /backup/replica-backup
```

## Scaling and High Availability
### Replica Set Setup
```javascript
// Initialize replica set
rs.initiate({
  _id: "myReplicaSet",
  members: [
    { _id: 0, host: "mongodb1.example.com:27017", priority: 2 },
    { _id: 1, host: "mongodb2.example.com:27017", priority: 1 },
    { _id: 2, host: "mongodb3.example.com:27017", arbiterOnly: true }
  ]
});

// Add new member to replica set
rs.add("mongodb4.example.com:27017");

// Set read preference in application
const client = new MongoClient(uri, {
  readPreference: 'secondaryPreferred',
  readConcern: { level: 'majority' },
  writeConcern: { w: 'majority', j: true, wtimeout: 5000 }
});
```

### Sharding (Horizontal Scaling)
```bash
# Start config servers
mongod --configsvr --replSet configReplSet --dbpath /data/configdb --port 27019

# Start shard servers
mongod --shardsvr --replSet shard1ReplSet --dbpath /data/shard1 --port 27018

# Start mongos router
mongos --configdb configReplSet/config1.example.com:27019 --port 27017

# Add shards to cluster
sh.addShard("shard1ReplSet/shard1.example.com:27018")
sh.addShard("shard2ReplSet/shard2.example.com:27018")

# Enable sharding on database and collection
sh.enableSharding("myapp")
sh.shardCollection("myapp.posts", { "userId": 1 })
```

## Security Best Practices
### Access Control
```javascript
// Create role-based users
db.createRole({
  role: "postManager",
  privileges: [
    {
      resource: { db: "myapp", collection: "posts" },
      actions: ["find", "insert", "update", "remove"]
    },
    {
      resource: { db: "myapp", collection: "users" },
      actions: ["find"]
    }
  ],
  roles: []
});

db.createUser({
  user: "postEditor",
  pwd: "securePassword",
  roles: ["postManager"]
});

// Field-level security with views
db.createView(
  "publicUsers",
  "users",
  [
    {
      $project: {
        username: 1,
        'profile.firstName': 1,
        'profile.lastName': 1,
        createdAt: 1,
        passwordHash: 0,
        email: 0
      }
    }
  ]
);
```

### Data Encryption
```bash
# Enable encryption at rest (Enterprise feature)
mongod --enableEncryption --encryptionKeyFile /etc/mongodb/encryption-key

# Client-side field level encryption (CSFLE)
# Configure in application with encryption schemas
```

```javascript
// Application-level encryption for sensitive fields
const crypto = require('crypto');
const algorithm = 'aes-256-gcm';
const secretKey = process.env.ENCRYPTION_KEY;

function encryptField(text) {
  const iv = crypto.randomBytes(16);
  const cipher = crypto.createCipher(algorithm, secretKey);
  cipher.setAAD(Buffer.from('additional-auth-data'));
  
  let encrypted = cipher.update(text, 'utf8', 'hex');
  encrypted += cipher.final('hex');
  
  const authTag = cipher.getAuthTag();
  
  return {
    iv: iv.toString('hex'),
    encrypted: encrypted,
    authTag: authTag.toString('hex')
  };
}

// Store encrypted sensitive data
const user = {
  username: 'johndoe',
  email: 'user@example.com',
  encryptedSSN: encryptField('123-45-6789'),
  createdAt: new Date()
};
```

## Integration Patterns
### Application Integration with Mongoose (Node.js)
```javascript
const mongoose = require('mongoose');

// Connection with options
mongoose.connect('mongodb://localhost:27017/myapp', {
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
  bufferCommands: false,
  bufferMaxEntries: 0
});

// Define schemas
const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true, lowercase: true },
  username: { type: String, required: true, unique: true, trim: true },
  passwordHash: { type: String, required: true, select: false },
  profile: {
    firstName: { type: String, trim: true },
    lastName: { type: String, trim: true },
    dateOfBirth: Date,
    location: {
      city: String,
      country: String,
      coordinates: {
        type: [Number], // [longitude, latitude]
        index: '2dsphere'
      }
    },
    preferences: {
      theme: { type: String, enum: ['light', 'dark'], default: 'light' },
      notifications: { type: Boolean, default: true },
      language: { type: String, default: 'en' }
    }
  },
  tags: [{ type: String, lowercase: true }],
  isActive: { type: Boolean, default: true }
}, {
  timestamps: true,
  toJSON: { virtuals: true },
  toObject: { virtuals: true }
});

// Indexes
userSchema.index({ email: 1 });
userSchema.index({ username: 1 });
userSchema.index({ 'profile.location.coordinates': '2dsphere' });
userSchema.index({ tags: 1 });

// Virtuals
userSchema.virtual('profile.fullName').get(function() {
  return `${this.profile.firstName} ${this.profile.lastName}`;
});

// Middleware
userSchema.pre('save', function(next) {
  if (this.isModified('email')) {
    this.email = this.email.toLowerCase();
  }
  next();
});

// Methods
userSchema.methods.toPublicJSON = function() {
  const user = this.toObject();
  delete user.passwordHash;
  delete user.__v;
  return user;
};

// Static methods
userSchema.statics.findActive = function() {
  return this.find({ isActive: true });
};

const User = mongoose.model('User', userSchema);

// Usage examples
class UserService {
  async createUser(userData) {
    try {
      const user = new User(userData);
      await user.save();
      return user.toPublicJSON();
    } catch (error) {
      if (error.code === 11000) {
        throw new Error('User already exists');
      }
      throw error;
    }
  }
  
  async findUserByEmail(email) {
    return await User.findOne({ email: email.toLowerCase(), isActive: true });
  }
  
  async findNearbyUsers(longitude, latitude, maxDistance = 1000) {
    return await User.find({
      'profile.location.coordinates': {
        $near: {
          $geometry: {
            type: 'Point',
            coordinates: [longitude, latitude]
          },
          $maxDistance: maxDistance
        }
      },
      isActive: true
    });
  }
  
  async getUserStats() {
    return await User.aggregate([
      {
        $group: {
          _id: null,
          totalUsers: { $sum: 1 },
          activeUsers: {
            $sum: {
              $cond: [{ $eq: ['$isActive', true] }, 1, 0]
            }
          },
          avgTagsPerUser: { $avg: { $size: '$tags' } }
        }
      }
    ]);
  }
}
```

### API Integration (Express.js)
```javascript
const express = require('express');
const { body, validationResult } = require('express-validator');
const userService = new UserService();

const router = express.Router();

// Create user endpoint
router.post('/users', [
  body('email').isEmail().normalizeEmail(),
  body('username').isLength({ min: 3, max: 20 }).trim(),
  body('password').isLength({ min: 8 })
], async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    const { email, username, password, profile } = req.body;
    const passwordHash = await bcrypt.hash(password, 12);
    
    const user = await userService.createUser({
      email,
      username,
      passwordHash,
      profile
    });
    
    res.status(201).json({ user });
  } catch (error) {
    if (error.message === 'User already exists') {
      return res.status(409).json({ error: error.message });
    }
    console.error('Error creating user:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Find nearby users
router.get('/users/nearby', [
  query('longitude').isFloat({ min: -180, max: 180 }),
  query('latitude').isFloat({ min: -90, max: 90 }),
  query('maxDistance').optional().isInt({ min: 1, max: 50000 })
], async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    
    const { longitude, latitude, maxDistance = 1000 } = req.query;
    
    const users = await userService.findNearbyUsers(
      parseFloat(longitude),
      parseFloat(latitude),
      parseInt(maxDistance)
    );
    
    res.json({ users: users.map(user => user.toPublicJSON()) });
  } catch (error) {
    console.error('Error finding nearby users:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});
```

## Monitoring and Alerting
### Key Metrics
- **Performance Metrics**: Query response time, operations per second, connection count
- **Resource Metrics**: CPU usage, memory usage, disk I/O, network throughput
- **Database Metrics**: Lock percentage, page faults, cache hit ratio, index usage

### Monitoring Setup
```javascript
// Custom monitoring with MongoDB driver
const { MongoClient } = require('mongodb');

class MongoDBMonitor {
  constructor(client) {
    this.client = client;
    this.metrics = {
      queries: 0,
      errors: 0,
      responseTime: []
    };
  }
  
  async getServerStatus() {
    try {
      const admin = this.client.db().admin();
      return await admin.serverStatus();
    } catch (error) {
      console.error('Error getting server status:', error);
      throw error;
    }
  }
  
  async getDatabaseStats(dbName) {
    try {
      const db = this.client.db(dbName);
      return await db.stats();
    } catch (error) {
      console.error('Error getting database stats:', error);
      throw error;
    }
  }
  
  async getSlowQueries() {
    try {
      const db = this.client.db();
      return await db.collection('system.profile')
        .find({ millis: { $gt: 100 } })
        .sort({ ts: -1 })
        .limit(10)
        .toArray();
    } catch (error) {
      console.error('Error getting slow queries:', error);
      throw error;
    }
  }
  
  trackQuery(startTime, error = null) {
    const duration = Date.now() - startTime;
    this.metrics.queries++;
    this.metrics.responseTime.push(duration);
    
    if (error) {
      this.metrics.errors++;
    }
    
    // Alert on slow queries
    if (duration > 5000) {
      console.warn(`Slow query detected: ${duration}ms`);
    }
    
    // Keep only last 1000 response times
    if (this.metrics.responseTime.length > 1000) {
      this.metrics.responseTime = this.metrics.responseTime.slice(-1000);
    }
  }
  
  getAverageResponseTime() {
    if (this.metrics.responseTime.length === 0) return 0;
    
    const sum = this.metrics.responseTime.reduce((a, b) => a + b, 0);
    return sum / this.metrics.responseTime.length;
  }
}

// Usage in application
const monitor = new MongoDBMonitor(client);

// Middleware to track query performance
function trackQueryPerformance(operation) {
  return async function(...args) {
    const startTime = Date.now();
    try {
      const result = await operation.apply(this, args);
      monitor.trackQuery(startTime);
      return result;
    } catch (error) {
      monitor.trackQuery(startTime, error);
      throw error;
    }
  };
}
```

### Alerting Configuration
```javascript
// Simple alerting system
class MongoDBAlerts {
  constructor(thresholds = {}) {
    this.thresholds = {
      maxResponseTime: thresholds.maxResponseTime || 1000,
      maxErrorRate: thresholds.maxErrorRate || 0.05,
      maxConnectionCount: thresholds.maxConnectionCount || 80
    };
    
    this.alertCallbacks = [];
  }
  
  addAlertCallback(callback) {
    this.alertCallbacks.push(callback);
  }
  
  async checkAlerts(monitor, serverStatus) {
    const avgResponseTime = monitor.getAverageResponseTime();
    const errorRate = monitor.metrics.errors / monitor.metrics.queries;
    const connectionCount = serverStatus.connections.current;
    
    // Check response time
    if (avgResponseTime > this.thresholds.maxResponseTime) {
      this.triggerAlert('HIGH_RESPONSE_TIME', {
        current: avgResponseTime,
        threshold: this.thresholds.maxResponseTime
      });
    }
    
    // Check error rate
    if (errorRate > this.thresholds.maxErrorRate) {
      this.triggerAlert('HIGH_ERROR_RATE', {
        current: errorRate,
        threshold: this.thresholds.maxErrorRate
      });
    }
    
    // Check connection count
    if (connectionCount > this.thresholds.maxConnectionCount) {
      this.triggerAlert('HIGH_CONNECTION_COUNT', {
        current: connectionCount,
        threshold: this.thresholds.maxConnectionCount
      });
    }
  }
  
  triggerAlert(type, data) {
    const alert = {
      type,
      timestamp: new Date(),
      data
    };
    
    console.error(`ALERT: ${type}`, alert);
    
    // Trigger all alert callbacks
    this.alertCallbacks.forEach(callback => {
      try {
        callback(alert);
      } catch (error) {
        console.error('Error in alert callback:', error);
      }
    });
  }
}
```

## Common Issues & Troubleshooting
### Performance Issues
**Issue**: Slow query performance
**Solution**:
- Use `.explain()` to analyze query execution plans
- Create appropriate indexes for query patterns
- Consider query restructuring or data model changes
- Use aggregation pipeline optimization techniques

**Issue**: High memory usage
**Solution**:
- Monitor working set size and adjust cache settings
- Optimize document size and eliminate unnecessary fields
- Use projection to reduce data transfer
- Consider archiving old data

### Connection Issues
**Issue**: Connection pool exhaustion
**Solution**:
- Increase maxPoolSize in connection options
- Implement proper connection cleanup in application
- Monitor connection usage patterns
- Use connection pooling middleware

**Issue**: Authentication failures
**Solution**:
- Verify user credentials and roles
- Check authentication database settings
- Ensure proper SSL/TLS configuration
- Monitor authentication logs

### Data Consistency Issues
**Issue**: Read preference conflicts
**Solution**:
- Use appropriate read concern levels
- Implement proper error handling for replica set operations
- Consider read preference based on use case
- Monitor replication lag

```javascript
// Diagnostic queries
const diagnostics = {
  // Check index usage
  async checkIndexUsage(db, collection) {
    return await db.collection(collection).aggregate([
      { $indexStats: {} }
    ]).toArray();
  },
  
  // Check slow operations
  async getSlowOperations(db) {
    return await db.admin().aggregate([
      { $currentOp: { allUsers: true, idleSessions: false } },
      { $match: { secs_running: { $gt: 5 } } }
    ]).toArray();
  },
  
  // Get collection statistics
  async getCollectionStats(db, collection) {
    return await db.collection(collection).stats();
  },
  
  // Check replica set status
  async getReplicaSetStatus(db) {
    try {
      return await db.admin().replSetGetStatus();
    } catch (error) {
      console.log('Not a replica set member');
      return null;
    }
  }
};
```

## AI Assistant Guidelines
When helping with MongoDB:

1. **Always consider document structure and query patterns together**
2. **Suggest appropriate indexing strategies for specific queries**
3. **Include error handling for connection and operation failures**
4. **Consider MongoDB-specific features (aggregation, geospatial, text search)**
5. **Provide both raw MongoDB operations and Mongoose examples**
6. **Include performance implications of data modeling decisions**
7. **Suggest monitoring and alerting for production deployments**
8. **Consider scalability implications (sharding, replica sets)**

### Code Generation Rules
- Generate schemas that leverage MongoDB's flexibility while maintaining consistency
- Include proper validation and error handling in all database operations
- Use MongoDB-specific features appropriately (aggregation over multiple queries)
- Include comments explaining complex aggregation pipelines
- Provide both callback and async/await examples as appropriate
- Consider connection pooling and resource management in generated code
- Include index recommendations for frequently queried fields
- Use appropriate data types for MongoDB (ObjectId, ISODate, etc.)