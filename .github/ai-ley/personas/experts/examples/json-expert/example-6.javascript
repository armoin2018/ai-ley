import Ajv from 'ajv';
import addFormats from 'ajv-formats';

class JSONValidator {
  constructor(schema) {
    this.ajv = new Ajv({ 
      allErrors: true, 
      verbose: true,
      strict: true 
    });
    addFormats(this.ajv);
    this.validate = this.ajv.compile(schema);
  }

  validateData(data) {
    const isValid = this.validate(data);
    
    if (!isValid) {
      return {
        valid: false,
        errors: this.validate.errors.map(error => ({
          path: error.instancePath || 'root',
          message: error.message,
          value: error.data,
          schema: error.schema,
          keyword: error.keyword
        }))
      };
    }

    return { valid: true, errors: [] };
  }

  formatErrorMessage(validationResult) {
    if (validationResult.valid) return null;

    const errorMessages = validationResult.errors.map(error => {
      const path = error.path === 'root' ? '' : error.path;
      return `${path}: ${error.message}`;
    });

    return `Validation failed:\n${errorMessages.join('\n')}`;
  }
}

// Safe JSON parsing with validation
function safeParseJSON(jsonString, schema = null) {
  try {
    const parsed = JSON.parse(jsonString);
    
    if (schema) {
      const validator = new JSONValidator(schema);
      const result = validator.validateData(parsed);
      
      if (!result.valid) {
        throw new Error(validator.formatErrorMessage(result));
      }
    }
    
    return parsed;
  } catch (error) {
    if (error instanceof SyntaxError) {
      throw new Error(`Invalid JSON format: ${error.message}`);
    }
    throw error;
  }
}

// Usage
try {
  const productData = safeParseJSON(jsonString, productSchema);
  console.log('Valid product:', productData);
} catch (error) {
  console.error('JSON processing failed:', error.message);
}