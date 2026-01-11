import { fetchUser, createUser, updateUser } from '../api/users'
import axios from 'axios'

jest.mock('axios')
const mockedAxios = axios as jest.Mocked<typeof axios>

describe('Users API', () => {
  afterEach(() => {
    jest.clearAllMocks()
  })
  
  describe('fetchUser', () => {
    test('should fetch user successfully', async () => {
      const userData = { id: 1, name: 'John Doe', email: 'john@example.com' }
      mockedAxios.get.mockResolvedValue({ data: userData })
      
      const result = await fetchUser(1)
      
      expect(result).toEqual(userData)
      expect(mockedAxios.get).toHaveBeenCalledWith('/api/users/1')
    })
    
    test('should handle fetch error', async () => {
      mockedAxios.get.mockRejectedValue(new Error('Network error'))
      
      await expect(fetchUser(1)).rejects.toThrow('Network error')
    })
  })
  
  describe('createUser', () => {
    test('should create user successfully', async () => {
      const newUser = { name: 'Jane Doe', email: 'jane@example.com' }
      const createdUser = { id: 2, ...newUser }
      
      mockedAxios.post.mockResolvedValue({ data: createdUser })
      
      const result = await createUser(newUser)
      
      expect(result).toEqual(createdUser)
      expect(mockedAxios.post).toHaveBeenCalledWith('/api/users', newUser)
    })
    
    test('should handle validation errors', async () => {
      const invalidUser = { name: '', email: 'invalid-email' }
      const errorResponse = {
        response: {
          status: 400,
          data: { errors: ['Name is required', 'Invalid email format'] }
        }
      }
      
      mockedAxios.post.mockRejectedValue(errorResponse)
      
      await expect(createUser(invalidUser)).rejects.toMatchObject({
        response: { status: 400 }
      })
    })
  })
})