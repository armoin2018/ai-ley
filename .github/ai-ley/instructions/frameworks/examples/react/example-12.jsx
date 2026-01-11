// Component test example
import { render, screen, fireEvent } from '@testing-library/react';
import UserCard from './UserCard';

test('renders user information', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  render(<UserCard user={user} onEdit={jest.fn()} />);

  expect(screen.getByText('John Doe')).toBeInTheDocument();
  expect(screen.getByText('john@example.com')).toBeInTheDocument();
});

test('calls onEdit when edit button is clicked', () => {
  const user = { id: 1, name: 'John Doe', email: 'john@example.com' };
  const onEdit = jest.fn();
  render(<UserCard user={user} onEdit={onEdit} />);

  fireEvent.click(screen.getByText('Edit'));
  expect(onEdit).toHaveBeenCalledWith(1);
});