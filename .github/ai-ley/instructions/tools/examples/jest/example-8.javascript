// Basic test structure
describe('Calculator', () => {
  describe('addition', () => {
    test('should add two positive numbers', () => {
      expect(add(2, 3)).toBe(5)
    })
    
    test('should add negative numbers', () => {
      expect(add(-2, -3)).toBe(-5)
    })
    
    test('should handle zero', () => {
      expect(add(0, 5)).toBe(5)
      expect(add(5, 0)).toBe(5)
    })
  })
  
  describe('division', () => {
    test('should divide numbers correctly', () => {
      expect(divide(10, 2)).toBe(5)
    })
    
    test('should throw error when dividing by zero', () => {
      expect(() => divide(10, 0)).toThrow('Division by zero')
    })
  })
})

// Async testing
describe('Async operations', () => {
  test('should resolve promise', async () => {
    const result = await fetchData()
    expect(result).toBeDefined()
  })
  
  test('should handle promise rejection', async () => {
    await expect(fetchInvalidData()).rejects.toThrow('Invalid data')
  })
})