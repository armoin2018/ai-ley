// ✅ Object pooling for frequently allocated objects
var bufferPool = sync.Pool{
    New: func() interface{} {
        return make([]byte, 4096)
    },
}

func processData(data []byte) ([]byte, error) {
    buf := bufferPool.Get().([]byte)
    defer bufferPool.Put(buf[:0]) // Reset length but keep capacity
    
    // Use buf for processing
    result := append(buf, processedData(data)...)
    
    // Return a copy since we're returning the buffer to the pool
    output := make([]byte, len(result))
    copy(output, result)
    
    return output, nil
}

// ✅ Slice pre-allocation when size is known
func processItems(items []Item) []ProcessedItem {
    results := make([]ProcessedItem, 0, len(items)) // Pre-allocate capacity
    
    for _, item := range items {
        if processed := processItem(item); processed != nil {
            results = append(results, *processed)
        }
    }
    
    return results
}

// ✅ String builder for efficient string concatenation
func buildLargeString(parts []string) string {
    var builder strings.Builder
    
    // Pre-allocate if we know approximate size
    totalSize := 0
    for _, part := range parts {
        totalSize += len(part)
    }
    builder.Grow(totalSize)
    
    for _, part := range parts {
        builder.WriteString(part)
    }
    
    return builder.String()
}