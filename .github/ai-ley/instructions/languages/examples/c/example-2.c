// ✅ Good: Check allocation, handle errors, clean up
char* create_buffer(size_t size) {
    if (size == 0) {
        return NULL;
    }
    
    char* buffer = malloc(size);
    if (buffer == NULL) {
        // Log error or handle appropriately
        return NULL;
    }
    
    memset(buffer, 0, size);  // Initialize memory
    return buffer;
}

void destroy_buffer(char** buffer) {
    if (buffer && *buffer) {
        free(*buffer);
        *buffer = NULL;  // Prevent double-free
    }
}