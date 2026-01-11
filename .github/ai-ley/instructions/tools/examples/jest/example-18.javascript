describe('Error handling', () => {
  test('should handle synchronous errors', () => {
    function throwError() {
      throw new Error('Something went wrong')
    }
    
    expect(() => throwError()).toThrow('Something went wrong')
    expect(() => throwError()).toThrow(Error)
    expect(() => throwError()).toThrow(/went wrong/)
  })
  
  test('should handle async errors', async () => {
    async function asyncError() {
      throw new Error('Async error')
    }
    
    await expect(asyncError()).rejects.toThrow('Async error')
    await expect(asyncError()).rejects.toBeInstanceOf(Error)
  })
  
  test('should handle custom errors', () => {
    class CustomError extends Error {
      constructor(message, code) {
        super(message)
        this.name = 'CustomError'
        this.code = code
      }
    }
    
    function throwCustomError() {
      throw new CustomError('Custom error message', 'CUSTOM_001')
    }
    
    expect(() => throwCustomError()).toThrow(CustomError)
    expect(() => throwCustomError()).toThrow(expect.objectContaining({
      message: 'Custom error message',
      code: 'CUSTOM_001'
    }))
  })
})