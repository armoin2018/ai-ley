import { 
  formatCurrency, 
  debounce, 
  deepClone, 
  validateEmail,
  calculateAge 
} from '../utils/helpers'

describe('Utility functions', () => {
  describe('formatCurrency', () => {
    test('should format positive numbers', () => {
      expect(formatCurrency(1234.56)).toBe('$1,234.56')
      expect(formatCurrency(0)).toBe('$0.00')
    })
    
    test('should format negative numbers', () => {
      expect(formatCurrency(-1234.56)).toBe('-$1,234.56')
    })
    
    test('should handle different currencies', () => {
      expect(formatCurrency(1234.56, 'EUR')).toBe('€1,234.56')
      expect(formatCurrency(1234.56, 'GBP')).toBe('£1,234.56')
    })
  })
  
  describe('debounce', () => {
    beforeEach(() => {
      jest.useFakeTimers()
    })
    
    afterEach(() => {
      jest.useRealTimers()
    })
    
    test('should delay function execution', () => {
      const mockFn = jest.fn()
      const debouncedFn = debounce(mockFn, 1000)
      
      debouncedFn('arg1')
      debouncedFn('arg2')
      debouncedFn('arg3')
      
      expect(mockFn).not.toHaveBeenCalled()
      
      jest.advanceTimersByTime(1000)
      
      expect(mockFn).toHaveBeenCalledTimes(1)
      expect(mockFn).toHaveBeenCalledWith('arg3')
    })
  })
  
  describe('deepClone', () => {
    test('should clone primitive values', () => {
      expect(deepClone(42)).toBe(42)
      expect(deepClone('hello')).toBe('hello')
      expect(deepClone(true)).toBe(true)
      expect(deepClone(null)).toBe(null)
    })
    
    test('should clone objects', () => {
      const original = { a: 1, b: { c: 2 } }
      const cloned = deepClone(original)
      
      expect(cloned).toEqual(original)
      expect(cloned).not.toBe(original)
      expect(cloned.b).not.toBe(original.b)
    })
    
    test('should clone arrays', () => {
      const original = [1, [2, 3], { a: 4 }]
      const cloned = deepClone(original)
      
      expect(cloned).toEqual(original)
      expect(cloned).not.toBe(original)
      expect(cloned[1]).not.toBe(original[1])
    })
  })
  
  describe('validateEmail', () => {
    test('should validate correct emails', () => {
      expect(validateEmail('user@example.com')).toBe(true)
      expect(validateEmail('test.email+tag@domain.co.uk')).toBe(true)
    })
    
    test('should reject invalid emails', () => {
      expect(validateEmail('invalid-email')).toBe(false)
      expect(validateEmail('user@')).toBe(false)
      expect(validateEmail('@domain.com')).toBe(false)
      expect(validateEmail('')).toBe(false)
    })
  })
  
  describe('calculateAge', () => {
    beforeEach(() => {
      jest.useFakeTimers()
      jest.setSystemTime(new Date('2023-06-15'))
    })
    
    afterEach(() => {
      jest.useRealTimers()
    })
    
    test('should calculate age correctly', () => {
      expect(calculateAge(new Date('1990-06-15'))).toBe(33)
      expect(calculateAge(new Date('1990-06-16'))).toBe(32) // Birthday hasn't passed
      expect(calculateAge(new Date('1990-06-14'))).toBe(33) // Birthday has passed
    })
  })
})