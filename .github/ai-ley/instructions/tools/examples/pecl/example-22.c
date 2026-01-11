// example_extension.c - Basic PECL extension template
#include "php.h"
#include "php_example.h"

// Extension function declarations
PHP_FUNCTION(example_hello);
PHP_FUNCTION(example_add);

// Function entry table
const zend_function_entry example_functions[] = {
    PHP_FE(example_hello, NULL)
    PHP_FE(example_add, NULL)
    PHP_FE_END
};

// Module entry
zend_module_entry example_module_entry = {
    STANDARD_MODULE_HEADER,
    "example",
    example_functions,
    NULL,                   // PHP_MINIT
    NULL,                   // PHP_MSHUTDOWN
    NULL,                   // PHP_RINIT
    NULL,                   // PHP_RSHUTDOWN
    NULL,                   // PHP_MINFO
    "1.0.0",
    STANDARD_MODULE_PROPERTIES
};

ZEND_GET_MODULE(example)

// Function implementations
PHP_FUNCTION(example_hello) {
    char *name = "World";
    size_t name_len = strlen(name);
    
    if (zend_parse_parameters(ZEND_NUM_ARGS(), "|s", &name, &name_len) == FAILURE) {
        return;
    }
    
    php_printf("Hello %s!\n", name);
}

PHP_FUNCTION(example_add) {
    zend_long a, b;
    
    if (zend_parse_parameters(ZEND_NUM_ARGS(), "ll", &a, &b) == FAILURE) {
        return;
    }
    
    RETURN_LONG(a + b);
}