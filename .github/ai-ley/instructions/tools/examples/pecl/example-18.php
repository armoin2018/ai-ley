<?php
// Extension Performance Monitoring
class ExtensionPerformanceMonitor {
    private $metrics = [];
    private $logFile = '/var/log/php-extension-performance.log';
    
    public function measureExtensionPerformance($extension, $operations = 1000) {
        if (!extension_loaded($extension)) {
            throw new Exception("Extension $extension not loaded");
        }
        
        $startTime = microtime(true);
        $startMemory = memory_get_usage(true);
        
        // Extension-specific performance tests
        switch ($extension) {
            case 'redis':
                $this->testRedisPerformance($operations);
                break;
            case 'mongodb':
                $this->testMongoDBPerformance($operations);
                break;
            case 'apcu':
                $this->testAPCuPerformance($operations);
                break;
            default:
                $this->testGenericPerformance($extension, $operations);
        }
        
        $endTime = microtime(true);
        $endMemory = memory_get_usage(true);
        
        $metrics = [
            'extension' => $extension,
            'operations' => $operations,
            'execution_time' => $endTime - $startTime,
            'memory_used' => $endMemory - $startMemory,
            'ops_per_second' => $operations / ($endTime - $startTime),
            'timestamp' => date('Y-m-d H:i:s')
        ];
        
        $this->logMetrics($metrics);
        return $metrics;
    }
    
    private function testRedisPerformance($operations) {
        $redis = new Redis();
        $redis->connect('127.0.0.1', 6379);
        
        for ($i = 0; $i < $operations; $i++) {
            $redis->set("test_key_$i", "test_value_$i");
            $redis->get("test_key_$i");
        }
        
        // Cleanup
        for ($i = 0; $i < $operations; $i++) {
            $redis->del("test_key_$i");
        }
        
        $redis->close();
    }
    
    private function testAPCuPerformance($operations) {
        for ($i = 0; $i < $operations; $i++) {
            apcu_store("test_key_$i", "test_value_$i");
            apcu_fetch("test_key_$i");
        }
        
        // Cleanup
        for ($i = 0; $i < $operations; $i++) {
            apcu_delete("test_key_$i");
        }
    }
    
    private function logMetrics($metrics) {
        $logEntry = json_encode($metrics) . "\n";
        file_put_contents($this->logFile, $logEntry, FILE_APPEND | LOCK_EX);
    }
}

// Usage
$monitor = new ExtensionPerformanceMonitor();

try {
    $redisMetrics = $monitor->measureExtensionPerformance('redis', 1000);
    echo "Redis Performance: " . $redisMetrics['ops_per_second'] . " ops/sec\n";
    
    $apcuMetrics = $monitor->measureExtensionPerformance('apcu', 5000);
    echo "APCu Performance: " . $apcuMetrics['ops_per_second'] . " ops/sec\n";
    
} catch (Exception $e) {
    echo "Performance test failed: " . $e->getMessage() . "\n";
}
?>