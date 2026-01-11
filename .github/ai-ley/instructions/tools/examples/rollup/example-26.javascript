// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  moduleNameMapping: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  setupFilesAfterEnv: ['<rootDir>/src/test/setup.ts']
}

// Test TypeScript build output
import { MyLibrary } from '../dist/index.esm.js'

describe('Built library', () => {
  test('should work correctly', () => {
    const lib = new MyLibrary({ apiKey: 'test' })
    expect(lib).toBeDefined()
  })
})