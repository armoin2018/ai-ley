// ❌ Bad: Missing await
test('async test', () => {
  return fetchData().then(data => {
    expect(data).toBeDefined()
  })
})

// ✅ Good: Using async/await
test('async test', async () => {
  const data = await fetchData()
  expect(data).toBeDefined()
})