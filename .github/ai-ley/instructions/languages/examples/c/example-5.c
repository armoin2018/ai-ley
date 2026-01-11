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