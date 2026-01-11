// ❌ Bad: No cleanup
describe('Timer tests', () => {
  test('should run timer', () => {
    setInterval(() => {}, 1000) // This keeps running
  })
})

// ✅ Good: Cleanup
describe('Timer tests', () => {
  beforeEach(() => {
    jest.useFakeTimers()
  })
  
  afterEach(() => {
    jest.useRealTimers()
  })
})