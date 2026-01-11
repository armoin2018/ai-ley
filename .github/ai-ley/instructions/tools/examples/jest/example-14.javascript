// Custom matcher definition
expect.extend({
  toBeWithinRange(received, floor, ceiling) {
    const pass = received >= floor && received <= ceiling
    if (pass) {
      return {
        message: () => `expected ${received} not to be within range ${floor} - ${ceiling}`,
        pass: true
      }
    } else {
      return {
        message: () => `expected ${received} to be within range ${floor} - ${ceiling}`,
        pass: false
      }
    }
  },
  
  toBeValidEmail(received) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
    const pass = emailRegex.test(received)
    
    return {
      message: () => pass 
        ? `expected ${received} not to be a valid email`
        : `expected ${received} to be a valid email`,
      pass
    }
  }
})

// Usage
describe('Custom matchers', () => {
  test('should be within range', () => {
    expect(100).toBeWithinRange(90, 110)
  })
  
  test('should be valid email', () => {
    expect('user@example.com').toBeValidEmail()
    expect('invalid-email').not.toBeValidEmail()
  })
})