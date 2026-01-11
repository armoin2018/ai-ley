describe('Database tests', () => {
  let db
  
  // Run once before all tests in this describe block
  beforeAll(async () => {
    db = await connectToDatabase()
  })
  
  // Run once after all tests in this describe block
  afterAll(async () => {
    await db.close()
  })
  
  // Run before each test
  beforeEach(async () => {
    await db.clear()
    await db.seed()
  })
  
  // Run after each test
  afterEach(async () => {
    await db.cleanup()
  })
  
  test('should create user', async () => {
    const user = await db.createUser({ name: 'John' })
    expect(user.id).toBeDefined()
  })
  
  test('should find user', async () => {
    await db.createUser({ name: 'John' })
    const user = await db.findUser({ name: 'John' })
    expect(user).toBeDefined()
  })
})