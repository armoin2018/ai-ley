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