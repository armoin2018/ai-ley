// Error codes enum
typedef enum {
    RESULT_SUCCESS = 0,
    RESULT_ERROR_NULL_POINTER = -1,
    RESULT_ERROR_INVALID_PARAM = -2,
    RESULT_ERROR_OUT_OF_MEMORY = -3,
    RESULT_ERROR_FILE_NOT_FOUND = -4,
    RESULT_ERROR_PERMISSION_DENIED = -5
} result_t;

// ✅ Structured error handling with cleanup
result_t process_file(const char* filename, char** output) {
    if (!filename || !output) {
        return RESULT_ERROR_NULL_POINTER;
    }
    
    FILE* file = NULL;
    char* buffer = NULL;
    result_t result = RESULT_SUCCESS;
    
    file = fopen(filename, "r");
    if (!file) {
        result = RESULT_ERROR_FILE_NOT_FOUND;
        goto cleanup;
    }
    
    buffer = malloc(BUFFER_SIZE);
    if (!buffer) {
        result = RESULT_ERROR_OUT_OF_MEMORY;
        goto cleanup;
    }
    
    // Process file...
    *output = buffer;
    buffer = NULL;  // Transfer ownership
    
cleanup:
    if (file) {
        fclose(file);
    }
    if (buffer) {
        free(buffer);
    }
    
    return result;
}