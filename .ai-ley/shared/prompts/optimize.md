---
agentMode: general
applyTo: general
author: AI-LEY
description: Comprehensive performance analysis, bottleneck identification, and optimization recommendations with profiling and monitoring
extensions:
  - .py
  - .js
  - .ts
  - .sql
  - .json
  - .yaml
guidelines: Follow AI-LEY project standards and performance optimization best practices
instructionType: general
keywords:
  [
    performance-optimization,
    bottleneck-analysis,
    database-optimization,
    caching-strategies,
    async-processing,
    profiling,
    monitoring,
  ]
lastUpdated: '2025-09-07T00:00:00.000000'
summaryScore: 3.0
title: Performance Optimization and Analysis
version: 1.0.0
---

# Copilot Command: Performance Optimization and Analysis

## Variables

- Folders, Files and Indexes are stored in `.ai-ley/shared/variables/folder-structure.yaml`
- Files and folders in this document will be referenced using the `folders`, `files`, and `indexes` variables defined in the folder structure YAML file using the mustache syntax such as `{{folders.plan}}`.

## References

- See the `.ai-ley/shared/global-instructions.md` file for global instructions that apply to all commands.
- Reference applicable personas in `{{folders.personas}}` and instructions in `{{folders.instructions}}` as needed.
- In the event of conflicting information utilize the `.ai-ley/shared/conflict-resolution.md` guidelines.

## Goal

Given:

- Project codebase with potential performance bottlenecks
- Database queries and data access patterns
- Network requests and API interactions
- Asynchronous processing implementations
- Memory management and resource utilization
- Current performance metrics and monitoring setup

Produce:

- Comprehensive performance analysis in `{{files.performance}}`
- Performance bottleneck identification and prioritization
- Database query optimization recommendations
- Caching strategy implementations
- Network and payload optimization suggestions
- Asynchronous processing improvements
- Profiling test scripts in `{{folders.performance}}`
- Optimization suggestions in `{{files.suggestions}}`
- Performance monitoring and alerting setup

## Command

You are a senior performance optimization engineer with expertise in full-stack performance analysis, database optimization, caching strategies, asynchronous processing, and performance monitoring across multiple technology stacks.

### 1. **Performance Analysis and Bottleneck Identification**

**Comprehensive Code Performance Scanning**:

```markdown
**Step 1.1: Performance Impact Code Analysis**

**Database Performance Analysis**:

- Scan for N+1 query patterns in ORM implementations
- Identify missing database indexes on frequently queried columns
- Analyze complex JOIN operations and subqueries for optimization
- Review database connection pooling and transaction management
- Examine bulk operations and batch processing efficiency
- Check for unnecessary data fetching (over-fetching, under-fetching)
- Analyze query execution plans and slow query logs
- Identify redundant or duplicate queries within request cycles

**Memory Management Analysis**:

- Scan for potential memory leaks in object creation patterns
- Identify excessive object instantiation in loops and iterations
- Review garbage collection patterns and memory retention
- Analyze closure usage and potential retain cycles
- Examine large data structure handling and streaming opportunities
- Check for proper resource disposal and cleanup
- Review caching implementations for memory efficiency
- Identify unnecessary data cloning and copying operations

**Network and I/O Performance Analysis**:

- Scan for synchronous calls to external services
- Identify excessive API requests and potential batching opportunities
- Analyze payload sizes and data transfer optimization
- Review file I/O operations and streaming implementations
- Examine network timeout configurations and retry strategies
- Check for unnecessary data serialization/deserialization
- Identify opportunities for request/response compression
- Analyze static asset delivery and CDN utilization

**Asynchronous Processing Analysis**:

- Scan for blocking operations on main execution threads
- Identify synchronous operations that could be asynchronous
- Review promise/callback nesting and potential callback hell
- Analyze task queue implementations and worker processes
- Examine concurrent processing patterns and race conditions
- Check for proper error handling in async operations
- Review background job processing and queue management
- Identify opportunities for parallel processing optimization

**Computation and Algorithm Analysis**:

- Scan for repetitive computations and calculation redundancy
- Identify inefficient algorithms and data structure usage
- Analyze loop complexity and nested iteration patterns
- Review recursive functions for optimization opportunities
- Examine sorting and searching algorithm implementations
- Check for unnecessary data transformations and processing
- Identify computational bottlenecks in business logic
- Analyze mathematical operations for optimization potential
```

### 2. **Performance Optimization Implementation**

**Systematic Performance Enhancement**:

````markdown
**Step 2.1: Database Query Optimization**

**Query Optimization Strategies**:

```sql
-- Example: N+1 Query Resolution
-- Before (N+1 Problem):
-- SELECT * FROM users WHERE department_id = ?
-- For each user: SELECT * FROM departments WHERE id = ?

-- After (Optimized with JOIN):
SELECT u.*, d.name as department_name, d.budget
FROM users u
LEFT JOIN departments d ON u.department_id = d.id
WHERE u.active = true
ORDER BY u.last_name;

-- Index Recommendations:
CREATE INDEX idx_users_department_active ON users(department_id, active);
CREATE INDEX idx_users_lastname ON users(last_name);
CREATE INDEX idx_departments_lookup ON departments(id, name);
```
````

**Caching Strategy Implementation**:

```javascript
// Redis Caching with TTL and Invalidation
class PerformanceCache {
  constructor(redisClient) {
    this.redis = redisClient;
    this.defaultTTL = 3600; // 1 hour
  }

  async getOrSet(key, fetchFunction, ttl = this.defaultTTL) {
    try {
      const cached = await this.redis.get(key);
      if (cached) {
        return JSON.parse(cached);
      }

      const data = await fetchFunction();
      await this.redis.setex(key, ttl, JSON.stringify(data));
      return data;
    } catch (error) {
      console.error(`Cache error for key ${key}:`, error);
      return await fetchFunction(); // Fallback to direct fetch
    }
  }

  async invalidatePattern(pattern) {
    const keys = await this.redis.keys(pattern);
    if (keys.length > 0) {
      await this.redis.del(keys);
    }
  }
}

// Usage Example:
const cache = new PerformanceCache(redisClient);
const userData = await cache.getOrSet(
  `user:${userId}:profile`,
  () => database.getUserProfile(userId),
  1800, // 30 minutes TTL
);
```

**Asynchronous Processing Optimization**:

```javascript
// Async/Await with Parallel Processing
class AsyncOptimizer {
  // Before: Sequential processing
  async processDataSequential(items) {
    const results = [];
    for (const item of items) {
      const processed = await this.processItem(item);
      results.push(processed);
    }
    return results;
  }

  // After: Parallel processing with concurrency control
  async processDataParallel(items, concurrency = 5) {
    const results = [];
    const chunks = this.chunkArray(items, concurrency);

    for (const chunk of chunks) {
      const chunkResults = await Promise.all(chunk.map((item) => this.processItem(item)));
      results.push(...chunkResults);
    }
    return results;
  }

  // Background task queue processing
  async processWithQueue(items) {
    const queue = new Queue('data-processing', { concurrency: 10 });

    const jobs = items.map((item) =>
      queue.add(
        'process-item',
        { item },
        {
          attempts: 3,
          backoff: 'exponential',
          delay: 2000,
        },
      ),
    );

    return Promise.all(jobs.map((job) => job.finished()));
  }

  chunkArray(array, size) {
    const chunks = [];
    for (let i = 0; i < array.length; i += size) {
      chunks.push(array.slice(i, i + size));
    }
    return chunks;
  }
}
```

**Network Optimization Implementation**:

```javascript
// Request Batching and Payload Optimization
class NetworkOptimizer {
  constructor() {
    this.batchQueue = new Map();
    this.batchTimeout = 50; // 50ms batching window
  }

  // Batch multiple requests
  async batchRequest(endpoint, data) {
    return new Promise((resolve, reject) => {
      if (!this.batchQueue.has(endpoint)) {
        this.batchQueue.set(endpoint, {
          items: [],
          timeout: setTimeout(() => this.flushBatch(endpoint), this.batchTimeout),
        });
      }

      const batch = this.batchQueue.get(endpoint);
      batch.items.push({ data, resolve, reject });
    });
  }

  async flushBatch(endpoint) {
    const batch = this.batchQueue.get(endpoint);
    if (!batch || batch.items.length === 0) return;

    this.batchQueue.delete(endpoint);
    clearTimeout(batch.timeout);

    try {
      const batchData = batch.items.map((item) => item.data);
      const results = await this.executeBatchRequest(endpoint, batchData);

      batch.items.forEach((item, index) => {
        item.resolve(results[index]);
      });
    } catch (error) {
      batch.items.forEach((item) => item.reject(error));
    }
  }

  // Compress payloads
  async compressPayload(data) {
    const jsonString = JSON.stringify(data);
    if (jsonString.length > 1024) {
      // Only compress if > 1KB
      return {
        compressed: true,
        data: await gzip(jsonString),
      };
    }
    return { compressed: false, data: jsonString };
  }
}
```

**Memory Management Optimization**:

```javascript
// Memory-Efficient Data Processing
class MemoryOptimizer {
  // Stream processing for large datasets
  async processLargeDataset(dataStream) {
    const results = [];
    const batchSize = 1000;
    let batch = [];

    for await (const item of dataStream) {
      batch.push(item);

      if (batch.length >= batchSize) {
        const processed = await this.processBatch(batch);
        results.push(...processed);
        batch = []; // Clear batch to free memory
      }
    }

    // Process remaining items
    if (batch.length > 0) {
      const processed = await this.processBatch(batch);
      results.push(...processed);
    }

    return results;
  }

  // Object pooling for frequent instantiation
  createObjectPool(factory, resetFn, initialSize = 10) {
    const pool = [];

    // Pre-populate pool
    for (let i = 0; i < initialSize; i++) {
      pool.push(factory());
    }

    return {
      acquire() {
        return pool.length > 0 ? pool.pop() : factory();
      },

      release(obj) {
        resetFn(obj);
        pool.push(obj);
      },
    };
  }

  // Weak reference caching to prevent memory leaks
  createWeakCache() {
    const cache = new WeakMap();

    return {
      get(key) {
        return cache.get(key);
      },
      set(key, value) {
        cache.set(key, value);
      },
      has(key) {
        return cache.has(key);
      },
    };
  }
}
```

````

### 3. **Performance Monitoring and Profiling**

**Comprehensive Performance Tracking**:
```markdown
**Step 3.1: Performance Monitoring Setup**

**Create Performance Monitoring Dashboard**:
```javascript
// Performance Metrics Collection
class PerformanceMonitor {
  constructor() {
    this.metrics = new Map();
    this.thresholds = {
      responseTime: 2000, // 2 seconds
      memoryUsage: 0.8,   // 80% of available memory
      cpuUsage: 0.7,      // 70% CPU utilization
      errorRate: 0.05     // 5% error rate
    };
  }

  // Response time tracking
  trackResponseTime(operation) {
    return async (...args) => {
      const startTime = process.hrtime.bigint();
      try {
        const result = await operation(...args);
        const endTime = process.hrtime.bigint();
        const duration = Number(endTime - startTime) / 1000000; // Convert to ms

        this.recordMetric('response_time', operation.name, duration);
        return result;
      } catch (error) {
        this.recordMetric('error_count', operation.name, 1);
        throw error;
      }
    };
  }

  // Memory usage monitoring
  trackMemoryUsage() {
    const usage = process.memoryUsage();
    this.recordMetric('memory_heap_used', 'system', usage.heapUsed);
    this.recordMetric('memory_heap_total', 'system', usage.heapTotal);
    this.recordMetric('memory_rss', 'system', usage.rss);

    const heapUtilization = usage.heapUsed / usage.heapTotal;
    if (heapUtilization > this.thresholds.memoryUsage) {
      this.alertHighMemoryUsage(heapUtilization);
    }
  }

  // Database query performance tracking
  trackDatabaseQuery(query, executionTime, rowCount) {
    this.recordMetric('db_query_time', query.type || 'unknown', executionTime);
    this.recordMetric('db_rows_affected', query.type || 'unknown', rowCount);

    if (executionTime > 1000) { // Slow query threshold: 1 second
      this.alertSlowQuery(query, executionTime);
    }
  }

  recordMetric(type, operation, value) {
    const key = `${type}:${operation}`;
    if (!this.metrics.has(key)) {
      this.metrics.set(key, []);
    }

    this.metrics.get(key).push({
      value,
      timestamp: new Date().toISOString()
    });
  }

  generatePerformanceReport() {
    const report = {
      timestamp: new Date().toISOString(),
      summary: {},
      details: {},
      alerts: []
    };

    for (const [key, values] of this.metrics.entries()) {
      const [type, operation] = key.split(':');
      const recentValues = values.slice(-100); // Last 100 measurements

      const stats = {
        count: recentValues.length,
        average: recentValues.reduce((sum, v) => sum + v.value, 0) / recentValues.length,
        min: Math.min(...recentValues.map(v => v.value)),
        max: Math.max(...recentValues.map(v => v.value)),
        p95: this.calculatePercentile(recentValues.map(v => v.value), 95)
      };

      if (!report.details[type]) report.details[type] = {};
      report.details[type][operation] = stats;
    }

    return report;
  }

  calculatePercentile(values, percentile) {
    const sorted = values.sort((a, b) => a - b);
    const index = Math.ceil((percentile / 100) * sorted.length) - 1;
    return sorted[Math.max(0, index)];
  }
}
````

**Profiling Test Scripts Creation**:

```python
# Python Performance Profiling Script
import cProfile
import pstats
import io
from memory_profiler import profile
import time
import asyncio
import concurrent.futures
import psutil
import threading

class PerformanceProfiler:
    def __init__(self, output_dir='{{folders.performance}}'):
        self.output_dir = output_dir
        self.results = {}

    def profile_cpu_usage(self, func, *args, **kwargs):
        """Profile CPU usage and execution time"""
        profiler = cProfile.Profile()
        profiler.enable()

        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()

        profiler.disable()

        # Generate profiling report
        s = io.StringIO()
        ps = pstats.Stats(profiler, stream=s).sort_stats('cumulative')
        ps.print_stats()

        self.results[f'{func.__name__}_cpu_profile'] = {
            'execution_time': end_time - start_time,
            'profile_data': s.getvalue(),
            'function_stats': ps.get_stats_profile()
        }

        return result

    @profile
    def profile_memory_usage(self, func, *args, **kwargs):
        """Profile memory usage line by line"""
        return func(*args, **kwargs)

    def profile_database_queries(self, db_connection):
        """Profile database query performance"""
        queries = [
            "SELECT COUNT(*) FROM users WHERE active = true",
            "SELECT u.*, p.name FROM users u JOIN profiles p ON u.id = p.user_id LIMIT 100",
            "SELECT * FROM orders WHERE created_at > NOW() - INTERVAL '1 day'"
        ]

        query_results = []
        for query in queries:
            start_time = time.time()
            cursor = db_connection.cursor()
            cursor.execute(query)
            results = cursor.fetchall()
            end_time = time.time()

            query_results.append({
                'query': query,
                'execution_time': end_time - start_time,
                'row_count': len(results),
                'explain_plan': self.get_explain_plan(db_connection, query)
            })

        self.results['database_queries'] = query_results
        return query_results

    def profile_async_performance(self, async_func, *args, **kwargs):
        """Profile asynchronous function performance"""
        async def run_profile():
            start_time = time.time()
            result = await async_func(*args, **kwargs)
            end_time = time.time()

            return {
                'result': result,
                'execution_time': end_time - start_time,
                'is_async': True
            }

        loop = asyncio.new_event_loop()
        asyncio.set_event_loop(loop)
        profile_result = loop.run_until_complete(run_profile())
        loop.close()

        self.results[f'{async_func.__name__}_async_profile'] = profile_result
        return profile_result['result']

    def profile_concurrent_performance(self, func, test_data, max_workers=5):
        """Profile concurrent execution performance"""
        start_time = time.time()

        with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = [executor.submit(func, data) for data in test_data]
            results = [future.result() for future in concurrent.futures.as_completed(futures)]

        end_time = time.time()

        self.results[f'{func.__name__}_concurrent_profile'] = {
            'total_time': end_time - start_time,
            'tasks_count': len(test_data),
            'max_workers': max_workers,
            'throughput': len(test_data) / (end_time - start_time),
            'results': results
        }

        return results

    def monitor_system_resources(self, duration_seconds=60):
        """Monitor system resources during test execution"""
        resource_data = []
        start_time = time.time()

        def collect_metrics():
            while time.time() - start_time < duration_seconds:
                cpu_percent = psutil.cpu_percent(interval=1)
                memory = psutil.virtual_memory()
                disk_io = psutil.disk_io_counters()

                resource_data.append({
                    'timestamp': time.time(),
                    'cpu_percent': cpu_percent,
                    'memory_percent': memory.percent,
                    'memory_available': memory.available,
                    'disk_read_bytes': disk_io.read_bytes if disk_io else 0,
                    'disk_write_bytes': disk_io.write_bytes if disk_io else 0
                })

                time.sleep(1)

        monitor_thread = threading.Thread(target=collect_metrics)
        monitor_thread.start()
        monitor_thread.join()

        self.results['system_resources'] = resource_data
        return resource_data

    def generate_performance_report(self):
        """Generate comprehensive performance report"""
        report = {
            'timestamp': time.time(),
            'profiling_results': self.results,
            'recommendations': self.generate_recommendations(),
            'bottlenecks_identified': self.identify_bottlenecks()
        }

        # Save report to file
        import json
        report_file = f"{self.output_dir}/performance_report_{int(time.time())}.json"
        with open(report_file, 'w') as f:
            json.dump(report, f, indent=2, default=str)

        return report

    def generate_recommendations(self):
        """Generate optimization recommendations based on profiling data"""
        recommendations = []

        # CPU usage recommendations
        for key, data in self.results.items():
            if 'cpu_profile' in key and 'execution_time' in data:
                if data['execution_time'] > 5.0:  # More than 5 seconds
                    recommendations.append({
                        'type': 'CPU Optimization',
                        'function': key.replace('_cpu_profile', ''),
                        'issue': f"Long execution time: {data['execution_time']:.2f}s",
                        'recommendation': "Consider optimizing algorithm complexity or using async processing"
                    })

        # Database query recommendations
        if 'database_queries' in self.results:
            for query_data in self.results['database_queries']:
                if query_data['execution_time'] > 1.0:  # More than 1 second
                    recommendations.append({
                        'type': 'Database Optimization',
                        'query': query_data['query'][:100] + '...',
                        'issue': f"Slow query: {query_data['execution_time']:.2f}s",
                        'recommendation': "Add appropriate indexes or optimize query structure"
                    })

        return recommendations

    def identify_bottlenecks(self):
        """Identify performance bottlenecks from profiling data"""
        bottlenecks = []

        # System resource bottlenecks
        if 'system_resources' in self.results:
            avg_cpu = sum(d['cpu_percent'] for d in self.results['system_resources']) / len(self.results['system_resources'])
            avg_memory = sum(d['memory_percent'] for d in self.results['system_resources']) / len(self.results['system_resources'])

            if avg_cpu > 80:
                bottlenecks.append({
                    'type': 'CPU Bottleneck',
                    'severity': 'High',
                    'metric': f'Average CPU usage: {avg_cpu:.1f}%',
                    'impact': 'System performance degradation'
                })

            if avg_memory > 85:
                bottlenecks.append({
                    'type': 'Memory Bottleneck',
                    'severity': 'High',
                    'metric': f'Average memory usage: {avg_memory:.1f}%',
                    'impact': 'Risk of out-of-memory errors'
                })

        return bottlenecks

# Usage Example
if __name__ == "__main__":
    profiler = PerformanceProfiler()

    # Example function to profile
    def example_cpu_intensive():
        total = 0
        for i in range(1000000):
            total += i * i
        return total

    # Profile the function
    result = profiler.profile_cpu_usage(example_cpu_intensive)

    # Monitor system resources
    profiler.monitor_system_resources(duration_seconds=30)

    # Generate report
    report = profiler.generate_performance_report()
    print(f"Performance report generated: {report}")
```

**Load Testing Script Creation**:

```javascript
// JavaScript/Node.js Load Testing Script
const axios = require('axios');
const cluster = require('cluster');
const os = require('os');

class LoadTester {
  constructor(baseUrl, options = {}) {
    this.baseUrl = baseUrl;
    this.options = {
      concurrency: options.concurrency || 10,
      duration: options.duration || 60000, // 60 seconds
      requestsPerSecond: options.requestsPerSecond || 100,
      ...options,
    };
    this.results = {
      requests: [],
      summary: {},
      errors: [],
    };
  }

  async runLoadTest(scenarios) {
    console.log(
      `Starting load test with ${this.options.concurrency} concurrent users for ${this.options.duration}ms`,
    );

    const startTime = Date.now();
    const workers = [];
    const numWorkers = Math.min(this.options.concurrency, os.cpus().length);

    if (cluster.isMaster) {
      // Master process - coordinate workers
      for (let i = 0; i < numWorkers; i++) {
        const worker = cluster.fork();
        workers.push(worker);

        worker.on('message', (data) => {
          if (data.type === 'request_result') {
            this.results.requests.push(data.result);
          } else if (data.type === 'error') {
            this.results.errors.push(data.error);
          }
        });
      }

      // Wait for test duration
      setTimeout(() => {
        workers.forEach((worker) => worker.kill());
        this.generateLoadTestReport();
      }, this.options.duration);
    } else {
      // Worker process - execute requests
      await this.executeWorkerRequests(scenarios);
    }
  }

  async executeWorkerRequests(scenarios) {
    const requestInterval = 1000 / (this.options.requestsPerSecond / os.cpus().length);
    const startTime = Date.now();

    while (Date.now() - startTime < this.options.duration) {
      for (const scenario of scenarios) {
        try {
          const requestStart = process.hrtime.bigint();
          const response = await axios({
            method: scenario.method || 'GET',
            url: `${this.baseUrl}${scenario.endpoint}`,
            data: scenario.data,
            headers: scenario.headers,
            timeout: 30000,
          });
          const requestEnd = process.hrtime.bigint();

          const responseTime = Number(requestEnd - requestStart) / 1000000; // Convert to ms

          process.send({
            type: 'request_result',
            result: {
              scenario: scenario.name,
              endpoint: scenario.endpoint,
              method: scenario.method || 'GET',
              statusCode: response.status,
              responseTime,
              timestamp: Date.now(),
              success: response.status >= 200 && response.status < 300,
            },
          });
        } catch (error) {
          process.send({
            type: 'error',
            error: {
              scenario: scenario.name,
              endpoint: scenario.endpoint,
              error: error.message,
              timestamp: Date.now(),
            },
          });
        }

        // Rate limiting
        await this.sleep(requestInterval);
      }
    }
  }

  generateLoadTestReport() {
    const totalRequests = this.results.requests.length;
    const successfulRequests = this.results.requests.filter((r) => r.success).length;
    const failedRequests = totalRequests - successfulRequests;

    const responseTimes = this.results.requests.map((r) => r.responseTime);
    const avgResponseTime = responseTimes.reduce((a, b) => a + b, 0) / responseTimes.length;
    const minResponseTime = Math.min(...responseTimes);
    const maxResponseTime = Math.max(...responseTimes);

    // Calculate percentiles
    const sortedTimes = responseTimes.sort((a, b) => a - b);
    const p50 = sortedTimes[Math.floor(sortedTimes.length * 0.5)];
    const p95 = sortedTimes[Math.floor(sortedTimes.length * 0.95)];
    const p99 = sortedTimes[Math.floor(sortedTimes.length * 0.99)];

    this.results.summary = {
      duration: this.options.duration,
      totalRequests,
      successfulRequests,
      failedRequests,
      successRate: ((successfulRequests / totalRequests) * 100).toFixed(2),
      requestsPerSecond: (totalRequests / (this.options.duration / 1000)).toFixed(2),
      averageResponseTime: avgResponseTime.toFixed(2),
      minResponseTime: minResponseTime.toFixed(2),
      maxResponseTime: maxResponseTime.toFixed(2),
      p50ResponseTime: p50.toFixed(2),
      p95ResponseTime: p95.toFixed(2),
      p99ResponseTime: p99.toFixed(2),
      errorRate: ((failedRequests / totalRequests) * 100).toFixed(2),
    };

    // Save results
    const fs = require('fs');
    const reportPath = `{{folders.performance}}/load_test_report_${Date.now()}.json`;
    fs.writeFileSync(reportPath, JSON.stringify(this.results, null, 2));

    console.log('Load Test Results:', this.results.summary);
    return this.results;
  }

  sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms));
  }
}

// Usage Example
const loadTester = new LoadTester('http://localhost:3000', {
  concurrency: 20,
  duration: 120000, // 2 minutes
  requestsPerSecond: 50,
});

const testScenarios = [
  {
    name: 'Homepage Load',
    endpoint: '/',
    method: 'GET',
  },
  {
    name: 'API Data Fetch',
    endpoint: '/api/users',
    method: 'GET',
    headers: { Authorization: 'Bearer token' },
  },
  {
    name: 'User Registration',
    endpoint: '/api/register',
    method: 'POST',
    data: { username: 'testuser', email: 'test@example.com' },
  },
];

loadTester.runLoadTest(testScenarios);
```

````

### 4. **Performance Report Generation**

**Comprehensive Performance Documentation**:
```markdown
**Step 4.1: Generate Performance Analysis Report**

**Performance Analysis Report Template** (`{{files.performance}}`):
```markdown
# Performance Optimization Analysis Report

## Executive Summary
**Analysis Date**: {current-date}
**Project**: {project-name}
**Analysis Scope**: {codebase-coverage-areas}
**Critical Issues Found**: {high-priority-count}
**Total Recommendations**: {recommendation-count}
**Estimated Performance Gain**: {projected-improvement-percentage}

## Performance Bottlenecks Identified

### Critical Priority Bottlenecks

#### 1. Database Performance Issues
**Category**: Database Query Optimization
**Severity**: Critical
**Impact**: Response time increase of 300-500ms per request

**Issues Identified**:
- **N+1 Query Pattern**: Found in user profile loading (users.py, line 45)
  - **Current**: 1 + N individual queries for N users
  - **Impact**: 200ms * N additional latency
  - **Fix**: Implement eager loading with JOIN operations

- **Missing Index**: `user_activity.created_at` column lacks index
  - **Query**: `SELECT * FROM user_activity WHERE created_at > ?`
  - **Impact**: Full table scan on 2.3M records
  - **Fix**: `CREATE INDEX idx_user_activity_created_at ON user_activity(created_at)`

- **Inefficient Query**: Complex JOIN with subquery in reports module
  - **Location**: reports/analytics.py, line 123
  - **Current Execution Time**: 3.2 seconds
  - **Optimization**: Replace subquery with CTE and add composite index

**Recommended Solutions**:
```sql
-- Optimize N+1 Query
SELECT u.*, p.bio, p.avatar_url, d.name as department
FROM users u
LEFT JOIN profiles p ON u.id = p.user_id
LEFT JOIN departments d ON u.department_id = d.id
WHERE u.active = true;

-- Add Missing Index
CREATE INDEX idx_user_activity_created_at ON user_activity(created_at);
CREATE INDEX idx_user_activity_lookup ON user_activity(user_id, created_at);

-- Optimize Complex Query with CTE
WITH user_stats AS (
  SELECT user_id, COUNT(*) as activity_count,
         MAX(created_at) as last_activity
  FROM user_activity
  WHERE created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
  GROUP BY user_id
)
SELECT u.username, u.email, us.activity_count, us.last_activity
FROM users u
JOIN user_stats us ON u.id = us.user_id
ORDER BY us.activity_count DESC;
````

#### 2. Memory Management Issues

**Category**: Memory Leaks and Excessive Allocation
**Severity**: High
**Impact**: Memory usage grows 40MB/hour, potential OOM errors

**Issues Identified**:

- **Object Retention**: Event listeners not properly removed (frontend/events.js)
- **Large Array Processing**: Loading entire dataset into memory (data_processor.py, line 67)
- **Circular References**: Component references causing memory leaks (components/dashboard.js)

**Memory Optimization Solutions**:

```python
# Before: Loading entire dataset
def process_user_data():
    users = User.objects.all()  # Loads all users into memory
    results = []
    for user in users:
        results.append(transform_user_data(user))
    return results

# After: Stream processing with batching
def process_user_data_optimized():
    batch_size = 1000
    results = []

    for batch_start in range(0, User.objects.count(), batch_size):
        user_batch = User.objects.all()[batch_start:batch_start + batch_size]
        for user in user_batch:
            results.append(transform_user_data(user))
        # Clear batch from memory
        del user_batch

    return results

# Generator-based streaming for very large datasets
def process_user_data_streaming():
    def user_generator():
        for user in User.objects.iterator(chunk_size=100):
            yield transform_user_data(user)

    return user_generator()
```

#### 3. Network and I/O Performance Issues

**Category**: Synchronous Operations and Excessive Requests
**Severity**: High
**Impact**: 2-5 second delays in user interactions

**Issues Identified**:

- **Synchronous External API Calls**: Payment processing blocks main thread
- **Excessive HTTP Requests**: Frontend makes 15+ API calls per page load
- **Large Payload Sizes**: JSON responses average 2.3MB without compression
- **No Request Batching**: Individual API calls for related data

**Network Optimization Solutions**:

```javascript
// Before: Synchronous external calls
async function processPayment(paymentData) {
  const result = await fetch('/api/payment/process', {
    method: 'POST',
    body: JSON.stringify(paymentData),
  });

  // Blocks for 3-5 seconds
  const response = await result.json();
  return response;
}

// After: Asynchronous with timeout and fallback
async function processPaymentOptimized(paymentData) {
  const controller = new AbortController();
  const timeoutId = setTimeout(() => controller.abort(), 10000); // 10s timeout

  try {
    const result = await fetch('/api/payment/process', {
      method: 'POST',
      body: JSON.stringify(paymentData),
      headers: { 'Content-Encoding': 'gzip' },
      signal: controller.signal,
    });

    clearTimeout(timeoutId);
    return await result.json();
  } catch (error) {
    if (error.name === 'AbortError') {
      return { error: 'Payment processing timeout', retry: true };
    }
    throw error;
  }
}

// Batch API requests
class APIBatcher {
  constructor() {
    this.batches = new Map();
    this.batchDelay = 50; // 50ms batching window
  }

  async batchRequest(endpoint, data) {
    return new Promise((resolve, reject) => {
      if (!this.batches.has(endpoint)) {
        this.batches.set(endpoint, {
          requests: [],
          timeout: setTimeout(() => this.executeBatch(endpoint), this.batchDelay),
        });
      }

      this.batches.get(endpoint).requests.push({ data, resolve, reject });
    });
  }

  async executeBatch(endpoint) {
    const batch = this.batches.get(endpoint);
    this.batches.delete(endpoint);
    clearTimeout(batch.timeout);

    try {
      const batchData = batch.requests.map((r) => r.data);
      const responses = await fetch(`${endpoint}/batch`, {
        method: 'POST',
        body: JSON.stringify({ requests: batchData }),
        headers: { 'Content-Type': 'application/json' },
      }).then((r) => r.json());

      batch.requests.forEach((request, index) => {
        request.resolve(responses[index]);
      });
    } catch (error) {
      batch.requests.forEach((request) => request.reject(error));
    }
  }
}
```

### Medium Priority Bottlenecks

#### 4. Asynchronous Processing Issues

**Category**: Blocking Operations and Poor Concurrency
**Severity**: Medium
**Impact**: Reduced throughput and user experience delays

**Issues Identified**:

- **Callback Hell**: Deep nesting in file processing (file_handler.js, line 89)
- **Sequential Processing**: Image processing tasks run sequentially instead of parallel
- **No Background Job Queue**: Long-running tasks block web requests

#### 5. Algorithm and Computation Inefficiencies

**Category**: Algorithm Optimization
**Severity**: Medium
**Impact**: CPU usage 30% higher than optimal

**Issues Identified**:

- **Inefficient Sorting**: Using bubble sort for large datasets (utils/sort.py)
- **Redundant Calculations**: Recalculating complex formulas in loops
- **Poor Data Structure Choice**: Using lists for frequent lookups instead of dictionaries

## Performance Optimization Recommendations

### Immediate Actions (Week 1-2)

#### Database Optimizations

1. **Add Critical Indexes**

   - Priority: Critical
   - Effort: 2 hours
   - Impact: 60% reduction in query time

   ```sql
   CREATE INDEX idx_user_activity_created_at ON user_activity(created_at);
   CREATE INDEX idx_users_active_department ON users(active, department_id);
   ```

2. **Implement Query Optimization**

   - Priority: Critical
   - Effort: 8 hours
   - Impact: 70% reduction in N+1 queries
   - Files to modify: users.py, profiles.py, reports/analytics.py

3. **Enable Query Caching**
   - Priority: High
   - Effort: 4 hours
   - Impact: 40% reduction in database load
   - Implementation: Redis-based query result caching

#### Memory Management

4. **Implement Stream Processing**

   - Priority: High
   - Effort: 12 hours
   - Impact: 80% reduction in memory usage for large datasets
   - Files: data_processor.py, bulk_operations.py

5. **Fix Memory Leaks**
   - Priority: High
   - Effort: 6 hours
   - Impact: Eliminate 40MB/hour memory growth
   - Files: frontend/events.js, components/dashboard.js

### Short-term Actions (Week 3-4)

#### Network and I/O Optimizations

6. **Implement Request Batching**

   - Priority: Medium
   - Effort: 16 hours
   - Impact: 50% reduction in API calls
   - Implementation: APIBatcher class and endpoint modifications

7. **Enable Response Compression**

   - Priority: Medium
   - Effort: 4 hours
   - Impact: 65% reduction in payload sizes
   - Configuration: Enable gzip compression on web server

8. **Asynchronous Processing Setup**
   - Priority: Medium
   - Effort: 20 hours
   - Impact: Non-blocking user experience
   - Implementation: Background job queue with Redis/Celery

### Long-term Actions (Month 2-3)

#### Infrastructure and Architecture

9. **Implement Caching Strategy**

   - Priority: Medium
   - Effort: 32 hours
   - Impact: 50% improvement in response times
   - Layers: Application cache, database query cache, CDN

10. **Algorithm Optimizations**
    - Priority: Low
    - Effort: 24 hours
    - Impact: 30% reduction in CPU usage
    - Files: utils/sort.py, calculations/formulas.py

## Performance Monitoring Setup

### Recommended Monitoring Tools

1. **Application Performance Monitoring (APM)**

   - Tool: New Relic / DataDog / Application Insights
   - Metrics: Response times, error rates, throughput
   - Alerting: Response time > 2s, error rate > 5%

2. **Database Monitoring**

   - Tool: Database-specific monitoring (PostgreSQL pg_stat_statements)
   - Metrics: Query execution time, lock waits, index usage
   - Alerting: Slow queries > 1s, lock waits > 100ms

3. **Infrastructure Monitoring**
   - Tool: Prometheus + Grafana
   - Metrics: CPU, memory, disk I/O, network
   - Alerting: CPU > 80%, Memory > 90%, Disk space < 10%

### Custom Performance Dashboards

```json
{
  "dashboard": "Application Performance",
  "panels": [
    {
      "title": "Response Time Percentiles",
      "metrics": ["response_time_p50", "response_time_p95", "response_time_p99"],
      "alert_thresholds": { "p95": 2000, "p99": 5000 }
    },
    {
      "title": "Database Performance",
      "metrics": ["query_execution_time", "connection_pool_usage", "slow_query_count"],
      "alert_thresholds": { "slow_queries": 10, "pool_usage": 80 }
    },
    {
      "title": "Memory and CPU Usage",
      "metrics": ["memory_usage_percent", "cpu_usage_percent", "gc_frequency"],
      "alert_thresholds": { "memory": 85, "cpu": 80 }
    }
  ]
}
```

## Performance Testing Results

### Load Testing Summary

**Test Configuration**:

- Concurrent Users: 100
- Test Duration: 10 minutes
- Target RPS: 500
- Test Environment: Staging (production-like)

**Current Performance Baseline**:

- Average Response Time: 2.3 seconds
- 95th Percentile: 4.8 seconds
- 99th Percentile: 8.2 seconds
- Error Rate: 3.2%
- Throughput: 387 requests/second

**Post-Optimization Projections**:

- Average Response Time: 0.8 seconds (65% improvement)
- 95th Percentile: 1.5 seconds (69% improvement)
- 99th Percentile: 2.1 seconds (74% improvement)
- Error Rate: < 1% (69% improvement)
- Throughput: 650 requests/second (68% improvement)

### Stress Testing Results

**Breaking Points Identified**:

- Database connections: Fails at 250 concurrent users
- Memory exhaustion: Occurs after 6 hours under heavy load
- CPU bottleneck: Reaches 95% at 180 concurrent users

## Implementation Timeline

### Phase 1: Critical Fixes (Weeks 1-2)

- [ ] Database index creation
- [ ] N+1 query elimination
- [ ] Memory leak fixes
- [ ] Basic monitoring setup

### Phase 2: Infrastructure Improvements (Weeks 3-4)

- [ ] Caching layer implementation
- [ ] Request batching
- [ ] Response compression
- [ ] Background job queue

### Phase 3: Advanced Optimizations (Weeks 5-8)

- [ ] Algorithm improvements
- [ ] Advanced monitoring
- [ ] Performance testing automation
- [ ] Documentation and training

## Success Metrics and KPIs

### Primary Performance KPIs

1. **Response Time**: Target < 1 second average, < 2 seconds 95th percentile
2. **Throughput**: Target > 600 requests/second
3. **Error Rate**: Target < 1%
4. **Memory Usage**: Target < 70% of available memory
5. **CPU Usage**: Target < 60% average utilization

### Business Impact Metrics

1. **User Experience**: Page load time < 2 seconds
2. **Conversion Rate**: Monitor for performance impact on conversions
3. **Server Costs**: Target 30% reduction in infrastructure costs
4. **Developer Productivity**: Faster deployment and testing cycles

## Next Steps and Recommendations

### Immediate Actions

1. **Review and prioritize** the critical bottlenecks identified
2. **Assign development resources** for database optimization work
3. **Set up basic monitoring** to establish performance baselines
4. **Create performance testing** as part of CI/CD pipeline

### Long-term Strategy

1. **Establish performance culture** with regular performance reviews
2. **Implement performance budgets** for new features
3. **Regular performance audits** (monthly or quarterly)
4. **Team training** on performance optimization best practices

### Budget and Resource Planning

- **Development Time**: 120-160 hours over 8 weeks
- **Infrastructure**: Additional monitoring tools ($200-500/month)
- **Testing Environment**: Performance testing setup ($100-300/month)
- **Training**: Team performance optimization workshop (8 hours)

---

**Report Generated**: {current-timestamp}
**Next Review Date**: {next-review-date}
**Report Contact**: Performance Engineering Team

```

```

## Examples

### Example 1: Database Performance Analysis

**Input**:

```
optimize
```

**Expected Output**:

```markdown
🔍 Scanning codebase for performance bottlenecks...

⚠️ CRITICAL ISSUES FOUND:

🗃️ Database Performance:

- N+1 Query Pattern detected in user_profiles.py (line 45)
  Impact: 200ms × N users per request
  Solution: Implement eager loading with JOIN

- Missing Index on orders.created_at
  Impact: 3.2s query time on 1.2M records
  Fix: CREATE INDEX idx_orders_created_at ON orders(created_at)

🧠 Memory Issues:

- Memory leak in event handlers (dashboard.js)
  Impact: 45MB growth per hour
  Solution: Implement proper cleanup in useEffect

⚡ Network Bottlenecks:

- 23 individual API calls per page load
  Impact: 4.8s total load time
  Solution: Implement request batching

📊 Performance Report:
✅ Detailed analysis → {{files.performance}}
✅ Profiling scripts → {{folders.performance}}/
✅ 12 optimization suggestions → {{files.suggestions}}

🎯 Priority Actions:

1. Add database indexes (2h effort, 60% improvement)
2. Fix memory leaks (4h effort, eliminate growth)
3. Implement request batching (8h effort, 50% faster loads)

Estimated overall performance gain: 65% improvement in response times
```

### Example 2: Frontend Performance Optimization

**Input**:

```
optimize
```

**Expected Output**:

```markdown
🚀 Frontend Performance Analysis Complete

⚠️ BOTTLENECKS IDENTIFIED:

🎨 Rendering Performance:

- Large DOM manipulation in ProductList component
  Impact: 800ms render time for 500+ products
  Solution: Implement virtual scrolling

- Unnecessary re-renders in Dashboard
  Impact: 15 re-renders per state change
  Solution: Use React.memo and useCallback

📦 Bundle Size Issues:

- Main bundle: 2.3MB (target: <500KB)
  Cause: Importing entire utility libraries
  Solution: Tree shaking and selective imports

🔄 Async Operations:

- Sequential image loading blocking UI
  Impact: 6s delay for gallery view
  Solution: Parallel loading with Promise.all

📈 Optimization Results:

- Bundle size reduction: 76% (2.3MB → 550KB)
- Render time improvement: 85% (800ms → 120ms)
- Page load speed: 73% faster (6s → 1.6s)

🛠️ Generated Assets:

- Performance audit → performance_analysis_2025-09-07.json
- Profiling script → frontend_performance_test.js
- Load testing → load_test_config.json
- 8 actionable suggestions added to project backlog

Ready for performance optimization implementation! 🎯
```

## Notes

- **Comprehensive analysis** covers database, memory, network, async operations, and algorithms
- **Actionable recommendations** with effort estimates and impact projections
- **Automated profiling** generates test scripts and monitoring setup
- **Priority-based approach** focuses on highest impact optimizations first
- **Continuous monitoring** establishes ongoing performance tracking
- **Multiple output targets** ensure proper documentation and suggestion tracking
- **Cross-platform profiling** supports Python, JavaScript, and SQL optimization
- **Load testing integration** provides realistic performance measurement capabilities
