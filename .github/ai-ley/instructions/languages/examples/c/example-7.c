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