// ❌ Bad: Mock after import
import { fetchData } from './api'
jest.mock('./api')

// ✅ Good: Mock before import
jest.mock('./api')
import { fetchData } from './api'

// ❌ Bad: Not clearing mocks
describe('Tests', () => {
  test('first test', () => {
    // Mock setup
  })
  test('second test', () => {
    // Mock might have state from previous test
  })
})

// ✅ Good: Clear mocks
describe('Tests', () => {
  afterEach(() => {
    jest.clearAllMocks()
  })
})