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