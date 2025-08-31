---
applyTo: "**/*.c,**/*.h"
---

# C Programming Instructions

Comprehensive instructions for C development with AI coding assistants, focusing on modern C best practices, memory safety, and maintainable code.

## 🧠 Context

- **Language**: C (C17/C18 preferred)
- **Common Use Cases**: System software, embedded systems, CLI tools, libraries
- **Frameworks**: POSIX, GNU libc, embedded RTOS
- **Build Systems**: Make, CMake, Autotools
- **Architecture**: Modular, layered, driver-oriented

## 📁 Project Structure

```text
src/
  core/           # Core application logic
  drivers/        # Hardware abstraction layer
  include/        # Public header files  
  platform/       # Platform-specific code
  utils/          # Utility functions
tests/
  unit/           # Unit tests
  integration/    # Integration tests
build/            # Build artifacts
docs/            # Documentation
```

## 🔧 General Guidelines

### Core Principles
- Write idiomatic, portable C following C17 standards
- Prioritize memory safety and avoid undefined behavior
- Use modular design with clear separation of concerns
- Implement defensive programming practices
- Focus on readability and maintainability

### Code Organization
- Use header files (.h) for declarations and source files (.c) for implementations
- Keep functions small, focused, and single-purpose
- Use static functions for internal module functionality
- Implement clear interfaces between modules
- Abstract platform-specific code behind interfaces

## 📜 Naming Conventions

- **Functions**: `snake_case` (e.g., `process_user_data`)
- **Variables**: `snake_case` (e.g., `buffer_size`, `user_count`)
- **Constants**: `UPPER_SNAKE_CASE` (e.g., `MAX_BUFFER_SIZE`)
- **Types**: `snake_case_t` (e.g., `user_data_t`, `config_t`)
- **Macros**: `UPPER_SNAKE_CASE` (e.g., `ARRAY_SIZE`)
- **Global variables**: `g_snake_case` (avoid when possible)

## 🛡️ Memory Management

### Allocation Best Practices

```c
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
```

### Memory Safety Rules
- Always pair `malloc()` with `free()`
- Set pointers to `NULL` after freeing
- Check all allocation return values
- Initialize allocated memory before use
- Use `const` qualifiers for read-only data
- Implement RAII-style cleanup patterns where possible

## 🔤 String Handling

### Safe String Operations

```c
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
```

### String Safety Rules
- Always null-terminate strings
- Use `strncpy`, `strncat`, `snprintf` instead of unsafe variants
- Check buffer bounds before string operations
- Use `const char*` for read-only string parameters
- Validate string lengths before operations

## ⚠️ Error Handling

### Error Handling Patterns

```c
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
```

### Error Handling Rules
- Use consistent return codes or error enums
- Check all function return values
- Use `errno` for system call errors
- Implement proper cleanup on errors using `goto` when appropriate
- Log errors appropriately for debugging

## 🔄 Functions and APIs

### Function Design Principles

```c
/**
 * Process user data with validation and error handling
 * 
 * @param input_data: Source data to process (must not be NULL)
 * @param output_buffer: Destination buffer (must be pre-allocated)
 * @param buffer_size: Size of output buffer in bytes
 * @param bytes_written: Number of bytes written to output (optional)
 * 
 * @return: RESULT_SUCCESS on success, error code on failure
 */
result_t process_user_data(const user_data_t* input_data,
                          char* output_buffer,
                          size_t buffer_size,
                          size_t* bytes_written) {
    // Parameter validation
    if (!input_data || !output_buffer || buffer_size == 0) {
        return RESULT_ERROR_INVALID_PARAM;
    }
    
    // Set optional output to safe default
    if (bytes_written) {
        *bytes_written = 0;
    }
    
    // Implementation...
    
    return RESULT_SUCCESS;
}
```

### Function Guidelines
- Keep functions small and focused (ideally < 50 lines)
- Use meaningful parameter names
- Validate all input parameters
- Document function behavior with comments
- Return error codes for status indication
- Use `const` for read-only parameters
- Minimize side effects

## ⚡ Performance Guidelines

### Efficient Code Patterns

```c
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
```

## 🧪 Testing Guidelines

### Unit Testing Best Practices

```c
// Example using Unity test framework
#include "unity.h"
#include "string_utils.h"

void setUp(void) {
    // Set up test fixtures
}

void tearDown(void) {
    // Clean up test fixtures
}

void test_safe_string_copy_normal_case(void) {
    char dest[10];
    const char* src = "hello";
    
    int result = safe_string_copy(dest, src, sizeof(dest));
    
    TEST_ASSERT_EQUAL(0, result);
    TEST_ASSERT_EQUAL_STRING("hello", dest);
}

void test_safe_string_copy_buffer_too_small(void) {
    char dest[3];
    const char* src = "hello";
    
    int result = safe_string_copy(dest, src, sizeof(dest));
    
    TEST_ASSERT_EQUAL(-2, result);
}

void test_safe_string_copy_null_parameters(void) {
    char dest[10];
    
    TEST_ASSERT_EQUAL(-1, safe_string_copy(NULL, "test", 10));
    TEST_ASSERT_EQUAL(-1, safe_string_copy(dest, NULL, 10));
    TEST_ASSERT_EQUAL(-1, safe_string_copy(dest, "test", 0));
}
```

### Testing Rules
- Test individual functions in isolation
- Test both normal and error conditions
- Use descriptive test names
- Validate memory usage with tools like Valgrind
- Test edge cases and boundary conditions
- Mock external dependencies when needed

## 🛠️ Build and Tools

### Recommended Tools
- **Static Analysis**: `clang-static-analyzer`, `cppcheck`, `PVS-Studio`
- **Memory Debugging**: `valgrind`, `AddressSanitizer`
- **Formatting**: `clang-format`
- **Testing**: `Unity`, `CMock`, `Check`
- **Build**: `CMake`, `Make`
- **Documentation**: `Doxygen`

### Compiler Flags
```makefile
# Recommended compiler flags for development
CFLAGS = -std=c17 -Wall -Wextra -Wpedantic -Werror \
         -Wformat=2 -Wconversion -Wunused -Wshadow \
         -Wstrict-prototypes -Wmissing-prototypes \
         -g -O2 -fstack-protector-strong
```

## 🚫 Common Pitfalls to Avoid

- **Buffer Overflows**: Always check bounds before array/string operations
- **Memory Leaks**: Ensure every `malloc` has a corresponding `free`
- **Double Free**: Set pointers to `NULL` after freeing
- **Uninitialized Variables**: Initialize all variables before use
- **Integer Overflow**: Check for overflow in arithmetic operations
- **Format String Vulnerabilities**: Use static format strings
- **Global State**: Minimize global variables and shared mutable state

## 📚 Standard Libraries

### Essential Headers
```c
#include <stdio.h>      // Input/output operations
#include <stdlib.h>     // Memory allocation, utilities
#include <string.h>     // String manipulation
#include <stdint.h>     // Fixed-width integer types
#include <stdbool.h>    // Boolean type and values
#include <errno.h>      // Error number definitions
#include <assert.h>     // Debugging assertions
#include <stddef.h>     // Standard type definitions
```

## 🔍 Code Review Checklist

- [ ] All parameters validated
- [ ] Memory properly allocated and freed
- [ ] Error conditions handled
- [ ] Buffer bounds checked
- [ ] Return values checked
- [ ] Functions documented
- [ ] No undefined behavior
- [ ] Thread safety considered (if applicable)
- [ ] Performance implications reviewed

## 📖 References

- [ISO C Standard (C17)](https://www.iso.org/standard/74528.html)
- [GNU C Library Documentation](https://www.gnu.org/software/libc/manual/)
- [Modern C by Jens Gustedt](https://gustedt.gitlabpages.inria.fr/modern-c/)
- [CERT C Coding Standard](https://wiki.sei.cmu.edu/confluence/display/c/SEI+CERT+C+Coding+Standard)
- [Unity Test Framework](https://github.com/ThrowTheSwitch/Unity)
- [Valgrind Documentation](https://valgrind.org/docs/manual/)