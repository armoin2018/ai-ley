#define MAX_STRING_LENGTH 256

// ✅ Safe string copy with bounds checking
int safe_string_copy(char* dest, const char* src, size_t dest_size) {
    if (!dest || !src || dest_size == 0) {
        return -1;  // Invalid parameters
    }
    
    size_t src_len = strlen(src);
    if (src_len >= dest_size) {
        return -2;  // Source too large
    }
    
    strncpy(dest, src, dest_size - 1);
    dest[dest_size - 1] = '\0';  // Ensure null termination
    return 0;  // Success
}

// ✅ Safe string concatenation
int safe_string_concat(char* dest, const char* src, size_t dest_size) {
    if (!dest || !src || dest_size == 0) {
        return -1;
    }
    
    size_t dest_len = strlen(dest);
    size_t available = dest_size - dest_len - 1;
    
    if (strlen(src) >= available) {
        return -2;  // Not enough space
    }
    
    strncat(dest, src, available);
    return 0;
}