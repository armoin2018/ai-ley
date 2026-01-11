describe('Jest matchers', () => {
  test('common matchers', () => {
    // Exact equality
    expect(2 + 2).toBe(4)
    expect({ name: 'John' }).toEqual({ name: 'John' })
    
    // Truthiness
    expect(true).toBeTruthy()
    expect(false).toBeFalsy()
    expect(null).toBeNull()
    expect(undefined).toBeUndefined()
    expect('Hello').toBeDefined()
    
    // Numbers
    expect(2 + 2).toBeGreaterThan(3)
    expect(Math.PI).toBeCloseTo(3.14159, 5)
    
    // Strings
    expect('Hello World').toMatch(/World/)
    expect('Jest testing').toContain('test')
    
    // Arrays and iterables
    expect(['apple', 'banana', 'orange']).toContain('banana')
    expect(['a', 'b', 'c']).toHaveLength(3)
    
    // Objects
    expect({ name: 'John', age: 30 }).toHaveProperty('name')
    expect({ name: 'John', age: 30 }).toHaveProperty('age', 30)
    
    // Exceptions
    expect(() => {
      throw new Error('Something went wrong')
    }).toThrow('Something went wrong')
  })
  
  test('custom matchers', () => {
    // Array matchers
    expect([1, 2, 3]).toEqual(expect.arrayContaining([1, 3]))
    expect(['a', 'b', 'c']).toEqual(expect.arrayContaining(['a']))
    
    // Object matchers
    expect({ name: 'John', age: 30, city: 'NYC' }).toMatchObject({
      name: 'John',
      age: 30
    })
    
    // Any type matchers
    expect('string').toEqual(expect.any(String))
    expect(123).toEqual(expect.any(Number))
    expect({ id: 1 }).toEqual({ id: expect.any(Number) })
  })
})