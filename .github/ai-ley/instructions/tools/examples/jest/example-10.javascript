// Mock functions
describe('Mock functions', () => {
  test('mock implementation', () => {
    const mockCallback = jest.fn(x => x * 2)
    const result = [1, 2, 3].map(mockCallback)
    
    expect(result).toEqual([2, 4, 6])
    expect(mockCallback).toHaveBeenCalledTimes(3)
    expect(mockCallback).toHaveBeenCalledWith(1)
    expect(mockCallback).toHaveBeenLastCalledWith(3)
  })
  
  test('mock return values', () => {
    const mockFn = jest.fn()
    mockFn.mockReturnValue(42)
    mockFn.mockReturnValueOnce(10)
    
    expect(mockFn()).toBe(10) // First call
    expect(mockFn()).toBe(42) // Subsequent calls
  })
  
  test('mock resolved values', async () => {
    const mockAsyncFn = jest.fn()
    mockAsyncFn.mockResolvedValue('async result')
    
    const result = await mockAsyncFn()
    expect(result).toBe('async result')
  })
})

// Module mocking
jest.mock('../services/api', () => ({
  fetchUser: jest.fn(() => Promise.resolve({ id: 1, name: 'John' })),
  createUser: jest.fn(() => Promise.resolve({ id: 2, name: 'Jane' }))
}))

describe('API service', () => {
  const { fetchUser, createUser } = require('../services/api')
  
  test('should fetch user', async () => {
    const user = await fetchUser(1)
    expect(user).toEqual({ id: 1, name: 'John' })
    expect(fetchUser).toHaveBeenCalledWith(1)
  })
})

// Partial mocking
jest.mock('../utils/helpers', () => ({
  ...jest.requireActual('../utils/helpers'),
  getCurrentDate: jest.fn(() => new Date('2023-01-01'))
}))

// Mock implementation
const axios = require('axios')
jest.mock('axios')
const mockedAxios = axios as jest.Mocked<typeof axios>

describe('HTTP requests', () => {
  test('should fetch data', async () => {
    const data = { users: [{ id: 1, name: 'John' }] }
    mockedAxios.get.mockResolvedValue({ data })
    
    const response = await fetchUsers()
    expect(response).toEqual(data.users)
    expect(mockedAxios.get).toHaveBeenCalledWith('/api/users')
  })
})