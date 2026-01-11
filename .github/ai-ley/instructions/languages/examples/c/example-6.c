// ✅ Cache array length outside loops
size_t process_array(const int* arr, size_t length) {
    size_t processed = 0;
    
    // Cache length, avoid function calls in condition
    for (size_t i = 0; i < length; i++) {
        if (process_element(arr[i])) {
            processed++;
        }
    }
    
    return processed;
}

// ✅ Use appropriate data types
typedef struct {
    uint32_t id;        // Use specific-width types when needed
    uint16_t flags;     // Pack data efficiently
    uint8_t status;
    // Add padding if needed for alignment
} __attribute__((packed)) packet_t;

// ✅ Minimize allocations in loops
result_t process_data_stream(data_stream_t* stream) {
    char* buffer = malloc(BUFFER_SIZE);  // Allocate once
    if (!buffer) {
        return RESULT_ERROR_OUT_OF_MEMORY;
    }
    
    while (has_data(stream)) {
        // Reuse buffer instead of reallocating
        memset(buffer, 0, BUFFER_SIZE);
        process_chunk(stream, buffer, BUFFER_SIZE);
    }
    
    free(buffer);
    return RESULT_SUCCESS;
}