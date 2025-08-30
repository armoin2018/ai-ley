# Software Troubleshooting Instructions

## Overview
- **Domain**: Software Problem Diagnosis and Resolution
- **Purpose**: Systematic approach to identifying, diagnosing, and resolving software issues
- **Applicable To**: All software systems, from development to production environments
- **Integration Level**: Critical operational skill affecting system reliability and user experience

## Core Principles

### Fundamental Concepts
1. **Systematic Approach**: Follow structured methodology to avoid missing critical steps
2. **Reproduce First**: Consistently reproduce issues before attempting fixes
3. **Minimal Changes**: Make one change at a time to isolate cause and effect
4. **Document Everything**: Record symptoms, steps, and resolutions for future reference

### Key Benefits
- Faster problem resolution with systematic approach
- Reduced downtime and improved system reliability
- Knowledge accumulation for preventing future issues
- Better team collaboration through shared troubleshooting practices
- Improved customer satisfaction through quick issue resolution

### Common Misconceptions
- **Myth**: Experienced developers don't need systematic troubleshooting
  **Reality**: Complex systems require structured approaches regardless of experience
- **Myth**: Quick fixes are better than thorough investigation
  **Reality**: Understanding root causes prevents recurring issues
- **Myth**: Troubleshooting is only for production issues
  **Reality**: Development and testing environments benefit from systematic debugging

## Implementation Framework

### Getting Started
#### Prerequisites
- Access to relevant logs, monitoring tools, and system documentation
- Understanding of system architecture and component interactions
- Basic knowledge of debugging tools and techniques
- Permission to access and modify relevant systems and configurations

#### Initial Setup
1. **Tool Preparation**: Set up logging, monitoring, and debugging tools
2. **Documentation Access**: Ensure access to system documentation and runbooks
3. **Communication Channels**: Establish incident communication procedures
4. **Escalation Paths**: Define when and how to escalate issues

### Core Methodologies
#### Root Cause Analysis (RCA)
- **Purpose**: Identify underlying causes rather than treating symptoms
- **When to Use**: For recurring issues, critical system failures, or post-incident analysis
- **Implementation Steps**:
  1. Define the problem clearly with specific symptoms
  2. Collect evidence and data about the issue
  3. Map the sequence of events leading to the problem
  4. Identify potential causes using techniques like "5 Whys"
  5. Test hypotheses and validate root causes
  6. Implement corrective and preventive actions
- **Success Metrics**: Issues don't recur, preventive measures are implemented

#### Binary Search Debugging
- **Purpose**: Efficiently narrow down the source of issues in large codebases
- **When to Use**: When dealing with large systems or recent changes causing issues
- **Implementation Steps**:
  1. Identify the working and non-working states
  2. Find a midpoint between the two states
  3. Test the midpoint to determine which half contains the issue
  4. Repeat the process on the problematic half
  5. Continue until the exact cause is isolated
- **Success Metrics**: Problem source identified with minimal testing

### Process Integration
#### Development Workflow Integration
```bash
# Example debugging workflow with version control
git log --oneline -10  # Check recent changes
git bisect start
git bisect bad HEAD    # Current state is bad
git bisect good <known-good-commit>  # Last known good state

# Git will checkout commits for testing
# After each test:
git bisect good   # if test passes
git bisect bad    # if test fails

# When done:
git bisect reset
```

#### Monitoring Integration
```yaml
# Example monitoring and alerting setup
version: '3.8'
services:
  app:
    image: myapp:latest
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
    environment:
      - LOG_LEVEL=DEBUG
      - ENABLE_PROFILING=true
    labels:
      - "prometheus.io/scrape=true"
      - "prometheus.io/port=3000"
      - "prometheus.io/path=/metrics"

  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml
    ports:
      - "9090:9090"

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
```

#### Documentation Requirements
- Incident response runbooks with step-by-step procedures
- System architecture diagrams showing component relationships
- Log analysis guides with common patterns and solutions
- Escalation procedures and contact information
- Post-incident reports with lessons learned

## Best Practices

### Issue Classification and Prioritization
#### Severity Classification Framework
```javascript
// Issue severity classification system
const severityLevels = {
  P0_CRITICAL: {
    description: "Complete system outage or data loss",
    responseTime: "15 minutes",
    examples: [
      "Production system completely down",
      "Data corruption or loss",
      "Security breach affecting user data",
      "Payment processing failures"
    ],
    escalation: "Immediate executive notification",
    resources: "All hands on deck"
  },
  
  P1_HIGH: {
    description: "Major functionality broken, workaround exists",
    responseTime: "1 hour",
    examples: [
      "Key feature not working but system accessible",
      "Performance degradation >50%",
      "Intermittent payment failures",
      "Authentication issues for some users"
    ],
    escalation: "Manager notification within 30 minutes",
    resources: "Primary on-call engineer"
  },
  
  P2_MEDIUM: {
    description: "Minor functionality issues",
    responseTime: "4 hours",
    examples: [
      "Non-critical feature bugs",
      "UI display issues",
      "Minor performance issues",
      "Documentation errors"
    ],
    escalation: "Standard ticket routing",
    resources: "Standard support queue"
  },
  
  P3_LOW: {
    description: "Enhancement requests or minor bugs",
    responseTime: "24 hours",
    examples: [
      "Feature requests",
      "Cosmetic issues",
      "Nice-to-have improvements",
      "Third-party integration wishes"
    ],
    escalation: "Product team review",
    resources: "Next sprint planning"
  }
};

function classifyIssue(issue) {
  const impactScore = calculateImpact(issue);
  const urgencyScore = calculateUrgency(issue);
  
  // Priority matrix
  if (impactScore >= 9 || urgencyScore >= 9) return severityLevels.P0_CRITICAL;
  if (impactScore >= 7 || urgencyScore >= 7) return severityLevels.P1_HIGH;
  if (impactScore >= 5 || urgencyScore >= 5) return severityLevels.P2_MEDIUM;
  return severityLevels.P3_LOW;
}
```

#### Triage Process
```markdown
# Incident Triage Checklist

## Initial Assessment (5 minutes)
- [ ] **Safety Check**: Is this a security incident? If yes, follow security runbook
- [ ] **Impact Assessment**: How many users/systems affected?
- [ ] **Service Status**: Which services are impacted?
- [ ] **Workaround Available**: Can users continue with alternative methods?

## Severity Assignment
- [ ] **P0**: Complete outage, data loss, or security breach
- [ ] **P1**: Major functionality broken, significant user impact
- [ ] **P2**: Minor functionality issues, limited user impact
- [ ] **P3**: Enhancement or cosmetic issues

## Resource Assignment
- [ ] **On-call Engineer**: Assigned for P0/P1 issues
- [ ] **Subject Matter Expert**: Identified if specialized knowledge needed
- [ ] **Communication Lead**: Assigned for P0/P1 issues
- [ ] **Manager Notification**: For P0/P1 issues

## Communication Setup
- [ ] **Incident Channel**: Created (e.g., #incident-2024-0315-001)
- [ ] **Status Page**: Updated if customer-facing
- [ ] **Stakeholder Notification**: Internal teams notified
- [ ] **Customer Communication**: Prepared if external impact
```

### Systematic Debugging Approach
#### The TRACE Method
```markdown
# TRACE Debugging Methodology

## T - Track the Problem
- **Reproduce**: Can you consistently reproduce the issue?
- **Environment**: What environment(s) does this occur in?
- **Timing**: When did this start? Is it constant or intermittent?
- **Scope**: Who/what is affected? What works correctly?

## R - Research and Gather Information
- **Logs**: Check application, system, and error logs
- **Metrics**: Review performance and resource utilization
- **Recent Changes**: What changed recently? (deployments, config, etc.)
- **External Factors**: Network issues, third-party service problems?

## A - Analyze the Data
- **Patterns**: Are there patterns in the failures?
- **Correlations**: Do errors correlate with specific conditions?
- **Timeline**: Map events chronologically
- **Dependencies**: What systems/services are involved?

## C - Create Hypotheses
- **Root Cause Theories**: What could be causing this?
- **Testable Hypotheses**: Form specific, testable theories
- **Prioritization**: Order hypotheses by likelihood and impact
- **Test Plan**: How will you test each hypothesis?

## E - Execute Tests and Evaluate
- **Controlled Testing**: Test one hypothesis at a time
- **Measure Results**: Did the test confirm or refute the hypothesis?
- **Document Findings**: Record what you learned
- **Iterate**: Refine hypotheses based on results
```

#### Log Analysis Framework
```bash
# Comprehensive log analysis workflow

# 1. Identify relevant log sources
LOG_SOURCES=(
  "/var/log/application/app.log"
  "/var/log/nginx/access.log" 
  "/var/log/nginx/error.log"
  "/var/log/mysql/error.log"
  "/var/log/syslog"
)

# 2. Define time window of interest
START_TIME="2024-01-15 14:00:00"
END_TIME="2024-01-15 15:00:00"

# 3. Extract logs for time window
for log_file in "${LOG_SOURCES[@]}"; do
  echo "=== Analyzing $log_file ==="
  
  # Extract time-windowed logs
  awk -v start="$START_TIME" -v end="$END_TIME" '
    $0 >= start && $0 <= end {print}
  ' "$log_file" > "filtered_$(basename $log_file)"
  
  # Count error patterns
  grep -i error "filtered_$(basename $log_file)" | \
    cut -d' ' -f5- | sort | uniq -c | sort -nr
  
  # Check for common issues
  echo "--- Connection Issues ---"
  grep -i "connection\|timeout\|refused" "filtered_$(basename $log_file)"
  
  echo "--- Memory Issues ---"
  grep -i "memory\|oom\|out of memory" "filtered_$(basename $log_file)"
  
  echo "--- Performance Issues ---"
  grep -i "slow\|performance\|timeout" "filtered_$(basename $log_file)"
done

# 4. Cross-reference logs for correlation
echo "=== Cross-referencing logs ==="
# Find common timestamps across error logs
grep -h "ERROR\|FATAL" filtered_*.log | \
  cut -d' ' -f1-2 | sort | uniq -c | sort -nr | head -10
```

### Performance Troubleshooting
#### Application Performance Analysis
```javascript
// Performance monitoring and analysis toolkit
class PerformanceAnalyzer {
  constructor(appName) {
    this.appName = appName;
    this.metrics = new Map();
    this.thresholds = {
      responseTime: 1000,    // ms
      memoryUsage: 500,      // MB
      cpuUsage: 80,          // %
      errorRate: 5           // %
    };
  }

  // Monitor critical metrics
  collectMetrics() {
    const metrics = {
      timestamp: Date.now(),
      responseTime: this.measureResponseTime(),
      memoryUsage: process.memoryUsage(),
      cpuUsage: this.getCPUUsage(),
      activeConnections: this.getActiveConnections(),
      errorRate: this.calculateErrorRate(),
      throughput: this.getThroughput()
    };
    
    this.metrics.set(metrics.timestamp, metrics);
    this.analyzeMetrics(metrics);
    return metrics;
  }

  analyzeMetrics(current) {
    const issues = [];
    
    // Response time analysis
    if (current.responseTime > this.thresholds.responseTime) {
      issues.push({
        type: 'PERFORMANCE',
        severity: 'HIGH',
        message: `Response time ${current.responseTime}ms exceeds threshold ${this.thresholds.responseTime}ms`,
        recommendations: [
          'Check database query performance',
          'Review API endpoint efficiency',
          'Analyze network latency',
          'Consider caching strategies'
        ]
      });
    }

    // Memory analysis
    const memoryMB = current.memoryUsage.heapUsed / 1024 / 1024;
    if (memoryMB > this.thresholds.memoryUsage) {
      issues.push({
        type: 'MEMORY',
        severity: 'HIGH', 
        message: `Memory usage ${memoryMB.toFixed(2)}MB exceeds threshold ${this.thresholds.memoryUsage}MB`,
        recommendations: [
          'Check for memory leaks',
          'Review object lifecycle management',
          'Analyze garbage collection patterns',
          'Consider increasing heap size'
        ]
      });
    }

    // Error rate analysis
    if (current.errorRate > this.thresholds.errorRate) {
      issues.push({
        type: 'RELIABILITY',
        severity: 'CRITICAL',
        message: `Error rate ${current.errorRate}% exceeds threshold ${this.thresholds.errorRate}%`,
        recommendations: [
          'Review recent deployments',
          'Check external service dependencies',
          'Analyze error logs for patterns',
          'Implement circuit breakers'
        ]
      });
    }

    if (issues.length > 0) {
      this.triggerAlerts(issues);
    }

    return issues;
  }

  generatePerformanceReport() {
    const recentMetrics = Array.from(this.metrics.values())
      .slice(-100); // Last 100 data points

    return {
      summary: {
        avgResponseTime: this.average(recentMetrics.map(m => m.responseTime)),
        maxResponseTime: Math.max(...recentMetrics.map(m => m.responseTime)),
        avgMemoryUsage: this.average(recentMetrics.map(m => m.memoryUsage.heapUsed)),
        avgErrorRate: this.average(recentMetrics.map(m => m.errorRate))
      },
      trends: this.analyzeTrends(recentMetrics),
      recommendations: this.generateRecommendations(recentMetrics)
    };
  }

  generateRecommendations(metrics) {
    const recommendations = [];
    
    // Performance trend analysis
    const responseTimes = metrics.map(m => m.responseTime);
    if (this.isIncreasingTrend(responseTimes)) {
      recommendations.push({
        category: 'Performance',
        priority: 'HIGH',
        action: 'Investigate performance degradation trend',
        details: 'Response times showing consistent upward trend'
      });
    }

    // Memory trend analysis
    const memoryUsages = metrics.map(m => m.memoryUsage.heapUsed);
    if (this.isIncreasingTrend(memoryUsages)) {
      recommendations.push({
        category: 'Memory',
        priority: 'MEDIUM',
        action: 'Investigate potential memory leak',
        details: 'Memory usage showing consistent growth'
      });
    }

    return recommendations;
  }
}
```

## Common Patterns and Examples

### Pattern 1: Database Performance Issues
**Scenario**: Application experiencing slow response times with database-related errors
**Implementation**:
```sql
-- Database performance troubleshooting queries

-- 1. Identify slow queries
SELECT 
    query_time,
    lock_time,
    rows_sent,
    rows_examined,
    sql_text
FROM mysql.slow_log 
WHERE start_time >= DATE_SUB(NOW(), INTERVAL 1 HOUR)
ORDER BY query_time DESC
LIMIT 20;

-- 2. Check for blocking queries
SHOW PROCESSLIST;

-- 3. Analyze index usage
EXPLAIN SELECT * FROM users WHERE email = 'user@example.com';

-- 4. Check table locks
SHOW OPEN TABLES WHERE In_use > 0;

-- 5. Monitor connection usage
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Max_used_connections';
```

```bash
# System-level database troubleshooting
# Check disk I/O
iostat -x 1 5

# Monitor database processes
top -p $(pgrep mysql)

# Check disk space
df -h /var/lib/mysql

# Analyze MySQL error log
tail -f /var/log/mysql/error.log | grep -E "ERROR|WARNING"
```
**Expected Outcomes**: Identification of slow queries, index issues, or resource constraints

### Pattern 2: Memory Leak Investigation
**Scenario**: Application memory usage continuously increasing over time
**Implementation**:
```javascript
// Memory leak detection and analysis
class MemoryLeakDetector {
  constructor(interval = 30000) { // 30 seconds
    this.interval = interval;
    this.samples = [];
    this.monitoring = false;
  }

  startMonitoring() {
    this.monitoring = true;
    console.log('Starting memory leak detection...');
    
    this.monitoringInterval = setInterval(() => {
      const sample = this.takeSample();
      this.samples.push(sample);
      
      // Keep only last 100 samples
      if (this.samples.length > 100) {
        this.samples.shift();
      }
      
      this.analyzeLeakPattern();
    }, this.interval);
  }

  takeSample() {
    const memUsage = process.memoryUsage();
    return {
      timestamp: Date.now(),
      heapUsed: memUsage.heapUsed,
      heapTotal: memUsage.heapTotal,
      external: memUsage.external,
      rss: memUsage.rss
    };
  }

  analyzeLeakPattern() {
    if (this.samples.length < 10) return;

    const recentSamples = this.samples.slice(-10);
    const firstSample = recentSamples[0];
    const lastSample = recentSamples[recentSamples.length - 1];
    
    const heapGrowth = lastSample.heapUsed - firstSample.heapUsed;
    const timeSpan = lastSample.timestamp - firstSample.timestamp;
    const growthRate = heapGrowth / timeSpan * 1000 * 60; // bytes per minute

    if (growthRate > 1024 * 1024) { // 1MB per minute
      console.warn(`Potential memory leak detected!`);
      console.warn(`Growth rate: ${(growthRate / 1024 / 1024).toFixed(2)} MB/min`);
      
      this.generateHeapSnapshot();
      this.logMemoryDetails();
    }
  }

  generateHeapSnapshot() {
    if (global.gc) {
      global.gc(); // Force garbage collection
      console.log('Forced garbage collection');
    }
    
    // Generate heap snapshot (requires --inspect flag)
    const filename = `heap-${Date.now()}.heapsnapshot`;
    console.log(`Generate heap snapshot: ${filename}`);
    
    // Analyze object counts
    this.analyzeObjectCounts();
  }

  analyzeObjectCounts() {
    // Monkey-patch constructors to track object creation
    const objectCounts = new Map();
    
    const originalObjectCreate = Object.create;
    Object.create = function(...args) {
      const obj = originalObjectCreate.apply(this, args);
      const constructor = obj.constructor.name;
      objectCounts.set(constructor, (objectCounts.get(constructor) || 0) + 1);
      return obj;
    };

    // Log top object types
    setTimeout(() => {
      const sortedCounts = Array.from(objectCounts.entries())
        .sort((a, b) => b[1] - a[1])
        .slice(0, 10);
      
      console.log('Top object types:');
      sortedCounts.forEach(([type, count]) => {
        console.log(`  ${type}: ${count}`);
      });
    }, 5000);
  }

  stopMonitoring() {
    this.monitoring = false;
    if (this.monitoringInterval) {
      clearInterval(this.monitoringInterval);
    }
    console.log('Memory leak detection stopped');
  }
}

// Usage
const detector = new MemoryLeakDetector();
detector.startMonitoring();

// Stop monitoring after 10 minutes
setTimeout(() => detector.stopMonitoring(), 10 * 60 * 1000);
```
**Expected Outcomes**: Detection of memory growth patterns and identification of potential leak sources

### Anti-Patterns to Avoid
#### Anti-Pattern 1: Guess and Check Debugging
- **Description**: Making random changes without systematic investigation
- **Why It's Problematic**: Can introduce new bugs and wastes time
- **Better Approach**: Follow systematic debugging methodology and test hypotheses

#### Anti-Pattern 2: Fixing Symptoms Instead of Root Causes
- **Description**: Addressing immediate symptoms without investigating underlying causes
- **Why It's Problematic**: Issues will likely recur and may manifest in other ways
- **Better Approach**: Use root cause analysis to identify and fix underlying issues

## Tools and Resources

### Essential Tools
#### Logging and Monitoring
- **ELK Stack**: Elasticsearch, Logstash, Kibana for log aggregation and analysis
- **Prometheus + Grafana**: Metrics collection and visualization
- **Datadog**: Comprehensive monitoring and alerting platform
- **New Relic**: Application performance monitoring

#### Debugging Tools
- **Chrome DevTools**: Frontend debugging and performance analysis
- **Node.js Inspector**: Server-side JavaScript debugging
- **GDB**: System-level debugging for compiled languages
- **Wireshark**: Network protocol analysis

#### System Monitoring
```bash
# Essential system monitoring commands
# CPU usage
top
htop
vmstat 1

# Memory usage
free -h
cat /proc/meminfo

# Disk I/O
iostat -x 1
iotop

# Network
netstat -tuln
ss -tuln
tcpdump -i eth0

# Process monitoring
ps aux
pstree
lsof -p <pid>
```

### Templates and Checklists
#### Incident Response Checklist
- [ ] **Immediate Response**: Acknowledge incident and assess severity
- [ ] **Team Assembly**: Gather relevant team members based on severity
- [ ] **Communication**: Set up incident communication channel
- [ ] **Investigation**: Begin systematic troubleshooting using TRACE method
- [ ] **Mitigation**: Implement immediate fixes or workarounds
- [ ] **Monitoring**: Verify fix effectiveness and monitor for recurrence
- [ ] **Documentation**: Record incident details, actions taken, and lessons learned
- [ ] **Follow-up**: Schedule post-incident review and implement preventive measures

### Learning Resources
- **Google SRE Book**: Site Reliability Engineering practices and incident response
- **The Art of Debugging**: Systematic debugging techniques and methodologies
- **Systems Performance** by Brendan Gregg: Comprehensive performance analysis
- **Effective Debugging** by Diomidis Spinellis: Practical debugging strategies

## Quality and Compliance

### Quality Standards
- All incidents documented with root cause analysis
- Response times meet SLA requirements based on severity
- Preventive measures implemented for recurring issues
- Knowledge base updated with new troubleshooting procedures

### Compliance Requirements
#### Incident Documentation
- **Requirements**: Maintain detailed records of all incidents and resolutions
- **Implementation**: Structured incident tracking with timeline and actions
- **Verification**: Regular audit of incident response procedures

#### Security Incident Handling
- **Requirements**: Special procedures for security-related incidents
- **Implementation**: Isolated investigation, evidence preservation, compliance notification
- **Verification**: Security team review and external audit compliance

### Audit and Review Processes
- Weekly review of critical incidents and response effectiveness
- Monthly analysis of incident trends and prevention opportunities
- Quarterly training updates based on lessons learned
- Annual incident response procedure review and improvement

## Troubleshooting and Problem Resolution

### Common Issues
#### Issue 1: Intermittent Application Failures
**Symptoms**: Application works sometimes but fails unpredictably
**Root Causes**: Race conditions, resource contention, external service instability
**Solutions**:
1. Add comprehensive logging around failure points
2. Implement retry mechanisms with exponential backoff
3. Analyze timing patterns and correlate with system metrics
4. Review concurrent access patterns and add synchronization
**Prevention**: Load testing, chaos engineering, comprehensive monitoring

#### Issue 2: Performance Degradation Over Time
**Symptoms**: Application starts fast but slows down over time
**Root Causes**: Memory leaks, cache pollution, resource exhaustion, database bloat
**Solutions**:
1. Monitor memory usage trends and analyze heap dumps
2. Review and optimize database queries and indexes
3. Implement proper cache expiration policies
4. Add resource monitoring and alerting
**Prevention**: Regular performance testing, proactive monitoring, capacity planning

### Escalation Procedures
- Technical issues: Senior engineer ’ Team lead ’ Engineering manager
- Critical incidents: Immediate manager notification + On-call escalation
- Security incidents: Security team + Legal + Compliance teams
- Customer-impacting issues: Customer success team notification

### Continuous Improvement
- Incident retrospectives to identify process improvements
- Regular review of troubleshooting tools and techniques
- Knowledge sharing sessions on complex issue resolutions
- Training on new debugging tools and methodologies

## AI Assistant Guidelines

When helping with Software Troubleshooting:

1. **Systematic Approach**: Always recommend structured debugging methodologies
2. **Evidence First**: Require evidence gathering before proposing solutions
3. **Root Cause Focus**: Guide toward identifying underlying causes, not just symptoms
4. **Documentation**: Emphasize documenting findings and solutions for future reference
5. **Safety First**: Prioritize system stability and data safety in all recommendations
6. **One Change at a Time**: Recommend testing one hypothesis at a time
7. **Monitoring**: Include monitoring and validation in all troubleshooting steps
8. **Knowledge Sharing**: Promote sharing lessons learned with the team

### Decision Making Framework
When helping teams troubleshoot issues:

1. **Issue Classification**: Help classify severity and impact appropriately
2. **Information Gathering**: Guide systematic evidence collection
3. **Hypothesis Formation**: Help form testable theories about root causes
4. **Test Planning**: Recommend safe, controlled testing approaches
5. **Solution Validation**: Ensure fixes are properly tested and monitored
6. **Prevention Planning**: Include measures to prevent recurrence

### Code Generation Rules
- Generate debugging code that is safe and non-destructive
- Include comprehensive logging and error handling
- Provide monitoring and alerting configurations
- Create troubleshooting scripts that are well-documented
- Include rollback procedures for any changes made
- Generate diagnostic tools that provide actionable insights

### Quality Enforcement
-  Enforce systematic debugging approaches over random changes
-  Require evidence gathering before proposing solutions
-  Block changes that could compromise system stability
-  Promote comprehensive testing of fixes before deployment
-  Require documentation of troubleshooting steps and outcomes
-  Enforce proper incident communication and escalation procedures
-  Promote learning and prevention over quick fixes
-  Require root cause analysis for recurring or critical issues