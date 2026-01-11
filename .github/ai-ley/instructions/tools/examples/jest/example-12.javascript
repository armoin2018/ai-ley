import { render } from '@testing-library/react'
import Button from '../Button'

describe('Button component', () => {
  test('renders correctly', () => {
    const { container } = render(<Button>Click me</Button>)
    expect(container.firstChild).toMatchSnapshot()
  })
  
  test('renders with different props', () => {
    const { container } = render(
      <Button variant="primary" size="large" disabled>
        Submit
      </Button>
    )
    expect(container.firstChild).toMatchSnapshot()
  })
  
  test('inline snapshot', () => {
    const user = { id: 1, name: 'John Doe', email: 'john@example.com' }
    expect(user).toMatchInlineSnapshot(`
      Object {
        "email": "john@example.com",
        "id": 1,
        "name": "John Doe",
      }
    `)
  })
})

// Custom snapshot serializer
expect.addSnapshotSerializer({
  test: (val) => val && val.hasOwnProperty('$$typeof'),
  print: (val, serialize) => serialize(val.props)
})